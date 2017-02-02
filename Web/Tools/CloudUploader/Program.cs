using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Auth;
using Microsoft.WindowsAzure.Storage.Blob;
using System.Configuration;
using System.IO;

namespace Altech.CloudUploader
{
    class Program
    {
        const string imagesContainerName = "images";
        const string updateDefenitionsContainerName = "defenitions";

        static int Main(string[] args)
        {
            if (args == null || args.Length == 0)
            {
                Console.WriteLine("Во входном параметре не задан путь к каталогу с изображениями и файлом определения товаров.");
                Console.ReadLine();
                return 1;
            }

            if (!Directory.Exists(args[0]))
            {
                Console.WriteLine("Не найден каталог с изображениями и файлом определения товаров.");
                Console.ReadLine();
                return 2;
            }

            #region Get access to Storage account and required containers inside of it

            CloudBlobContainer imgContainer = null, fdContainer = null;
            try
            {
                CloudStorageAccount storageAccount = CloudStorageAccount.Parse(
                    ConfigurationManager.ConnectionStrings["StorageConnection"].ConnectionString);
                if (storageAccount == null)
                {
                    Console.WriteLine("В конфигурации приложения не найден параметр с именем 'StorageConnection'.");
                    Console.ReadLine();
                    return 3;
                }

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
                fdContainer = blobClient.GetContainerReference(updateDefenitionsContainerName);

                // Create the container if it doesn't already exist.
                fdContainer.CreateIfNotExists();

                // Make container public
                fdContainer.SetPermissions(
                    new BlobContainerPermissions
                    {
                        PublicAccess =
                            BlobContainerPublicAccessType.Off
                    });
            }
            catch (Exception ex)
            {
                Console.WriteLine(String.Format("Во время получения доступа к Storage-контейнерам произошла ошибка: '{0}'", ex.Message));
                Console.ReadLine();
                return 4;
            }

            #endregion

            #region Get directory's files and upload each item to Storage

            int fileCounter = 0;
            CloudBlockBlob blockBlob;
            try
            {
                foreach (var file in Directory.GetFiles(args[0]))
                {
                    switch (Path.GetExtension(file).ToLower())
                    {
                        case ".jpg":
                            // Retrieve reference to a blob named as file name
                            blockBlob = imgContainer.GetBlockBlobReference(Path.GetFileName(file));

                            // Create or overwrite the blob with contents from a local file.
                            using (var fileStream = System.IO.File.OpenRead(file))
                            {
                                blockBlob.UploadFromStream(fileStream);
                            }
                            
                            fileCounter++;
                            break;
                        case ".xml":
                            // Retrieve reference to a blob named as file name
                            blockBlob = fdContainer.GetBlockBlobReference(Path.GetFileName(file));

                            // Create or overwrite the blob with contents from a local file.
                            using (var fileStream = System.IO.File.OpenRead(file))
                            {
                                blockBlob.UploadFromStream(fileStream);
                            }

                            fileCounter++;
                            break;
                        default:
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(String.Format("Во время сохранения файлов в Storage произошла ошибка: '{0}'", ex.Message));
                Console.ReadLine();
                return 5;
            }

            #endregion

            Console.WriteLine(String.Format("Обновление отправлено на веб-сайт (всего файлов: '{0}'). Через некоторое время сайт будет обновлен.", fileCounter));
            return 0;
        }
    }
}
