using Altech.Core.Models;
using Altech.DAL;
using Altech.DAL.Interfaces;
using Microsoft.Azure.WebJobs;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity.Migrations;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Xml;

namespace Altech.WebJobs.DataUploader
{
    public class Program
    {
        const string imagesContainerName = "images";
        const string thumbnailImagesContainerName = "thumbnail-images";

        static void Main(string[] args)
        {
            JobHost host = new JobHost();
            host.RunAndBlock();

            #region Integration test example
            //var idDelList = new List<int>();

            //using (var xr = new XmlTextReader(@"C:\Users\juryger\Desktop\Test\Update_7.9.2014_224835.xml"))
            //{
            //    int groupId = default(int), subGroupId = default(int);
            //    while (xr.Read())
            //    {
            //        if (xr.NodeType != XmlNodeType.Element)
            //            continue;

            //        switch (xr.Name.ToLower())
            //        {
            //            case "groupitem":
            //                ProcessGroupItem(xr, idDelList, out groupId);
            //                break;
            //            case "subgroupitem":
            //                ProcessSubgroupItem(xr, groupId, idDelList, out subGroupId);
            //                break;
            //            case "goodsitem":
            //                ProcessMerchandiseItem(xr, subGroupId, idDelList);
            //                break;
            //        }
            //    }
            //}
            //db.SaveChanges(); 
            #endregion
        }

        public static void SaveDataToDb([BlobTrigger("defenitions/{name}")] CloudBlockBlob input, TextWriter log)
        {
            var idDelList = new List<int>();

            using (var db = new AltechContext())
            {
                using (var xr = new XmlTextReader(input.OpenRead()))
                {
                    int groupId = default(int), subGroupId = default(int);
                    while (xr.Read())
                    {
                        if (xr.NodeType != XmlNodeType.Element)
                            continue;

                        switch (xr.Name.ToLower())
                        {
                            case "discountitem":
                                ProcessDiscountItem(db, xr);
                                break;
                            case "groupitem":
                                ProcessGroupItem(db, xr, idDelList, out groupId);
                                break;
                            case "subgroupitem":
                                ProcessSubgroupItem(db, xr, groupId, idDelList, out subGroupId);
                                break;
                            case "goodsitem":
                                ProcessMerchandiseItem(db, xr, subGroupId, idDelList);
                                break;
                        }
                    }
                }

                // сохранить изменения в БД
                db.SaveChanges();

                // удалить blob в случае успешной обработки
                input.Delete();

                // Check if there are no links to images from Merchandiese Table
                log.WriteLine(String.Format("idDelList contains '{0}' items", idDelList.Count));
                foreach (var id in idDelList)
                    if (db.Merchandises.Find(id) == null)
                    {
                        log.WriteLine(String.Format("Following image: '{0}.jpg' does not has links from DB and will be deleted.", id));
                        DeleteImagesFromBlobStorage(id);
                    }
            }
        }

        #region Process operations
        
        private static void ProcessDiscountItem(IDbGeneralContext db, XmlTextReader xr)
        {
            if (db == null)
                throw new ArgumentNullException("db");
            if (xr == null)
                throw new ArgumentNullException("xr");

            int id;
            double summ;
            bool isDeleted;
            string testValue;

            testValue = xr.GetAttribute("id");
            if (!int.TryParse(testValue, out id))
                throw new ApplicationException(
                    String.Format("Не удалось привести идентификатор к типу int. Исходное строковое значение: {0}. XML({1},{2})", testValue, xr.LineNumber, xr.LinePosition));

            testValue = xr.GetAttribute("startSumm");
            if (!double.TryParse(testValue, out summ))
                throw new ApplicationException(
                    String.Format("Не удалось привести сумму для определения скидки к типу double. Исходное строковое значение: {0}. XML({1},{2})", testValue, xr.LineNumber, xr.LinePosition));

            testValue = xr.GetAttribute("deleted");
            isDeleted = String.Compare(testValue, "true", true) == 0 ? true : false;

            // Если группа должна быть удалена, то удалить также подгруппы и товары входящие в ее состав
            if (isDeleted)
            {
                DeleteDiscount(db, id);
                return;
            }

            // Добавление или обновление скидки в БД
            UpdateDiscount(db, new Discount { ID = id, StartSumm = summ });
        }

        private static void ProcessGroupItem(IDbGeneralContext db, XmlTextReader xr, List<int> idDelList, out int id)
        {
            if (db == null)
                throw new ArgumentNullException("db");
            if (xr == null)
                throw new ArgumentNullException("xr");

            string title;
            bool isDeleted;
            string testValue;

            testValue = xr.GetAttribute("id");
            if (!int.TryParse(testValue, out id))
                throw new ApplicationException(
                    String.Format("Не удалось привести идентификатор группы к типу int. Исходное строковое значение: {0}. XML({1},{2})", testValue, xr.LineNumber, xr.LinePosition));

            title = xr.GetAttribute("title");
            if (String.IsNullOrEmpty(title))
                throw new ApplicationException(
                    String.Format("Имя группы не должно быть пустым. XML({0},{1}).", xr.LineNumber, xr.LinePosition));

            testValue = xr.GetAttribute("deleted");
            isDeleted = String.Compare(testValue, "true", true) == 0 ? true : false;

            // Если группа должна быть удалена, то удалить также подгруппы и товары входящие в ее состав
            if (isDeleted)
            {
                DeleteGroup(db, id, idDelList);
                return;
            }

            // Добавление или обновление группы в БД
            UpdateGroup(db, new Group { ID = id, Title = title });
        }

        private static void ProcessSubgroupItem(IDbGeneralContext db, XmlTextReader xr, int groupId, List<int> idDelList, out int id)
        {
            if (db == null)
                throw new ArgumentNullException("db");
            if (xr == null)
                throw new ArgumentNullException("xr");

            string title;
            bool isDeleted;
            string testValue;

            testValue = xr.GetAttribute("id");
            if (!int.TryParse(testValue, out id))
                throw new ApplicationException(
                    String.Format("Не удалось привести идентификатор подгруппы к типу int. Исходное строковое значение: {0}. XML({1},{2})", testValue, xr.LineNumber, xr.LinePosition));

            title = xr.GetAttribute("title");
            if (String.IsNullOrEmpty(title))
                throw new ApplicationException(
                    String.Format("Имя подгруппы не должно быть пустым. XML({0},{1}).", xr.LineNumber, xr.LinePosition));

            testValue = xr.GetAttribute("deleted");
            isDeleted = String.Compare(testValue, "true", true) == 0 ? true : false;

            // Если подгруппа должна быть удалена, то удалить также товары входящие в ее состав
            if (isDeleted)
            {
                DeleteSubgroup(db, id, idDelList);
                return;
            }

            // Добавление или обновление подгруппы в БД
            UpdateSubgroup(db, new Subgroup { ID = id, GroupID = groupId, Title = title });
        }

        private static void ProcessMerchandiseItem(IDbGeneralContext db, XmlTextReader xr, int subgroupId, List<int> idDelList)
        {
            if (db == null)
                throw new ArgumentNullException("db");
            if (xr == null)
                throw new ArgumentNullException("xr");

            int id;
            string title;
            string measureUnits;
            int pack;
            double costWhs1, costWhs2, costWhs3;
            string imageFileName;
            bool isDeleted;
            string testValue;

            testValue = xr.GetAttribute("id");
            if (!int.TryParse(testValue, out id))
                throw new ApplicationException(
                    String.Format("Не удалось привести идентификатор товара к типу int. Исходное строковое значение: {0}. XML({1},{2})", testValue, xr.LineNumber, xr.LinePosition));

            title = xr.GetAttribute("title");
            if (String.IsNullOrEmpty(title))
                throw new ApplicationException(
                    String.Format("Имя товара не должно быть пустым. XML({0},{1}).", xr.LineNumber, xr.LinePosition));

            measureUnits = xr.GetAttribute("mu");
            if (String.IsNullOrEmpty(measureUnits))
                measureUnits = "шт";

            testValue = xr.GetAttribute("pack");
            if (!int.TryParse(testValue, out pack))
                throw new ApplicationException(
                    String.Format("Не удалось привести значение поля Упаковка к типу int. Исходное строковое значение: {0}. XML({1},{2})", testValue, xr.LineNumber, xr.LinePosition));

            testValue = xr.GetAttribute("costWhs1").Replace(',', '.');
            if (!double.TryParse(testValue, NumberStyles.AllowDecimalPoint, CultureInfo.InvariantCulture, out costWhs1))
                throw new ApplicationException(
                    String.Format("Не удалось привести значение поля Опт1 к типу double. Исходное строковое значение: {0}. XML({1},{2})", testValue, xr.LineNumber, xr.LinePosition));

            testValue = xr.GetAttribute("costWhs2").Replace(',', '.');
            if (!double.TryParse(testValue, NumberStyles.AllowDecimalPoint, CultureInfo.InvariantCulture, out costWhs2))
                throw new ApplicationException(
                    String.Format("Не удалось привести значение поля Опт2 к типу double. Исходное строковое значение: {0}. XML({1},{2})", testValue, xr.LineNumber, xr.LinePosition));

            testValue = xr.GetAttribute("costWhs3").Replace(',', '.');
            if (!double.TryParse(testValue, NumberStyles.AllowDecimalPoint, CultureInfo.InvariantCulture, out costWhs3))
                throw new ApplicationException(
                    String.Format("Не удалось привести значение поля Опт3 к типу double. Исходное строковое значение: {0}. XML({1},{2})", testValue, xr.LineNumber, xr.LinePosition));

            imageFileName = xr.GetAttribute("img");

            testValue = xr.GetAttribute("deleted");
            isDeleted = String.Compare(testValue, "true", true) == 0 ? true : false;

            if (isDeleted)
            {
                DeleteMerchandise(db, id, subgroupId, idDelList);
                return;
            }

            // Добавление или обновление товара в БД
            UpdateMerchandise(
                db,
                new Merchandise
                {
                    ID = id,
                    SubgroupID = subgroupId,
                    Title = title,
                    UnitMeasure = measureUnits,
                    Pack = pack,
                    CostWhs1 = costWhs1,
                    CostWhs2 = costWhs2,
                    CostWhs3 = costWhs3,
                    ImageName = imageFileName
                });
        } 

        #endregion

        #region Update operations

        private static void UpdateDiscount(IDbGeneralContext db, Discount d)
        {
            if (db == null)
                throw new ArgumentNullException("db");

            if (d == null)
                return;

            // save discount to DB
            db.Discounts.AddOrUpdate(p => p.ID, new Discount[] { d });
        }

        private static void UpdateGroup(IDbGeneralContext db, Group g)
        {
            if (db == null)
                throw new ArgumentNullException("db");

            if (g == null)
                return;

            // save group to DB
            db.Groups.AddOrUpdate(p => p.ID, new Group[] { g });
        }

        private static void UpdateSubgroup(IDbGeneralContext db, Subgroup s)
        {
            if (db == null)
                throw new ArgumentNullException("db");

            if (s == null)
                return;

            // save subgroup to DB
            db.Subgroups.AddOrUpdate(p => p.ID, new Subgroup[] { s });
        }

        private static void UpdateMerchandise(IDbGeneralContext db, Merchandise m)
        {
            if (db == null)
                throw new ArgumentNullException("db");

            if (m == null)
                return;

            // save merchandise to DB
            db.Merchandises.AddOrUpdate(p => p.ID, new Merchandise[] { m });
        } 

        #endregion

        #region Delete operations
        
        private static void DeleteDiscount(IDbGeneralContext db, int id)
        {
            if (db == null)
                throw new ArgumentNullException("db");

            var d = db.Discounts.Find(id);
            if (d == null)
                return;

            db.Discounts.Remove(d);
        }

        private static void DeleteGroup(IDbGeneralContext db, int id, List<int> idDelList)
        {
            if (db == null)
                throw new ArgumentNullException("db");

            var g = db.Groups.Find(id);
            if (g == null)
                return;

            // delete group from DB
            db.Groups.Remove(g);
        }

        private static void DeleteSubgroup(IDbGeneralContext db, int id, List<int> idDelList)
        {
            if (db == null)
                throw new ArgumentNullException("db");

            var s = db.Subgroups.Find(id);
            if (s == null)
                return;

            // delete group from DB
            db.Subgroups.Remove(s);
        }

        private static void DeleteMerchandise(IDbGeneralContext db, int id, int subgroupId, List<int> idDelList)
        {
            if (db == null)
                throw new ArgumentNullException("db");

            // delete merchandise from DB
            var item = db.Merchandises.FirstOrDefault(m => m.ID == id && m.SubgroupID == subgroupId);
            if (item != null)
            {
                db.Merchandises.Remove(item);
                idDelList.Add(id);
            }
        }

        private static void DeleteImagesFromBlobStorage(int merchandiseId)
        {
            #region Get access to Storage account and required containers inside of it

            CloudBlobContainer imgContainer = null, tbImgContainer = null;
            try
            {
                CloudStorageAccount storageAccount = CloudStorageAccount.Parse(
                    ConfigurationManager.ConnectionStrings["StorageConnection"].ConnectionString);

                CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();

                // Retrieve a reference to a container. 
                imgContainer = blobClient.GetContainerReference(imagesContainerName);

                // Create the container if it doesn't already exist.
                imgContainer.CreateIfNotExists();

                // Make container public
                imgContainer.SetPermissions(
                    new BlobContainerPermissions
                    {
                        PublicAccess =
                            BlobContainerPublicAccessType.Blob
                    });

                // Retrieve a reference to a container. 
                tbImgContainer = blobClient.GetContainerReference(thumbnailImagesContainerName);

                // Create the container if it doesn't already exist.
                tbImgContainer.CreateIfNotExists();

                // Make container public
                tbImgContainer.SetPermissions(
                    new BlobContainerPermissions
                    {
                        PublicAccess =
                            BlobContainerPublicAccessType.Blob
                    });
            }
            catch (Exception ex)
            {
                throw new ApplicationException(String.Format("Во время получения доступа к Storage-контейнерам произошла ошибка: '{0}'", ex.Message), ex);
            }

            #endregion

            // Retrieve reference to a blob
            var blockBlob = imgContainer.GetBlockBlobReference(String.Format("{0}.jpg", merchandiseId));

            // Delete the blob.
            if (blockBlob.Exists())
                blockBlob.Delete();

            blockBlob = tbImgContainer.GetBlockBlobReference(String.Format("{0}.jpg", merchandiseId));

            // Delete the blob.
            if (blockBlob.Exists())
                blockBlob.Delete();
        } 

        #endregion
    }
}
