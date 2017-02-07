using Altech.Core.Interfaces;
using Altech.Core.Models;
using Altech.DAL;
using Altech.DAL.Services;
using Altech.WebJobs.OrderProcessing.Exceptions;
using Microsoft.Azure.WebJobs;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
using SendGrid;
using SendGrid.Helpers.Mail;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Xsl;

namespace Altech.WebJobs.OrderProcessing
{
    // To learn more about Microsoft Azure WebJobs, please see http://go.microsoft.com/fwlink/?LinkID=401557
    public class Program
    {
        private const string ordersContainerName = "orders";

        static void Main()
        {
            JobHost host = new JobHost();
            host.RunAndBlock();
        }

        public static void ProcessQueueMessage([QueueTrigger("ordersqueue")] string inputText, TextWriter log)
        {
            int orderId;
            var errorMessage = string.Empty;
            
            if (!Int32.TryParse(inputText, out orderId))
            {
                errorMessage = "Failed to parse inputText to Int32.";
                log.WriteLine(errorMessage);
                throw new ApplicationException(errorMessage);
            }

            using (var db = new AltechContext())
            {
                var costCalculation = new OrderCostCalculation() { Db = db };

                #region 1. Get Order from DB by id (inputText)

                var order = db.Orders.SingleOrDefault(o => o.ID == orderId);
                if (order == null)
                {
                    errorMessage = "Failed to get Order form DB.";
                    log.WriteLine(errorMessage);
                    CleanUp(costCalculation);
                    throw new ApplicationException(errorMessage);
                }

                if (!order.Completed)
                {
                    errorMessage = "Order marked as NOT completed at DB.";
                    log.WriteLine(errorMessage);
                    CleanUp(costCalculation);
                    throw new ApplicationException(errorMessage);
                }

                #endregion

                #region 2. Get customer from DB

                var customer = db.Customers.SingleOrDefault(c => c.ID == order.CustomerID);
                if (customer == null)
                {
                    errorMessage = "Failed to get Customer form DB.";
                    log.WriteLine(errorMessage);
                    CleanUp(costCalculation);
                    throw new ApplicationException(errorMessage);
                }

                #endregion

                #region 3. Calculate Order Sum with possible discount

                double cost, costDiscount;
                costCalculation.GetOrderCostWithDiscount(orderId, out cost, out costDiscount);

                #endregion

                #region 4. Get access to Storage (Orders container)

                var xmlOrderFileName = String.Format("Order_{0}.xml", order.ID);
                var htmlOrderFileName = String.Format("Order_{0}.html", order.ID);

                var ordersContainer = GetOrdersBlobContainer();
                if (ordersContainer == null)
                {
                    errorMessage = String.Format("Failed to get Blob container: '{0}'.", ordersContainerName);
                    log.WriteLine(errorMessage);
                    CleanUp(costCalculation);
                    throw new ApplicationException(errorMessage);
                }

                var xmlBlob = ordersContainer.GetBlockBlobReference(xmlOrderFileName);
                if (xmlBlob == null)
                {
                    errorMessage = String.Format("Failed to get Blob with name: '{0}'.", xmlOrderFileName);
                    log.WriteLine(errorMessage);
                    CleanUp(costCalculation);
                    throw new ApplicationException(errorMessage);
                }

                var htmlBlob = ordersContainer.GetBlockBlobReference(htmlOrderFileName);
                if (htmlBlob == null)
                {
                    errorMessage = String.Format("Failed to get Blob with name: '{0}'.", htmlOrderFileName);
                    log.WriteLine(errorMessage);
                    CleanUp(costCalculation);
                    throw new ApplicationException(errorMessage);
                }

                #endregion

                #region 5. Generate XML file with data from order

                try
                {
                    using (var stream = xmlBlob.OpenWrite())
                    {
                        GenerateXmlFile(stream, order, customer, db.Merchandises, costCalculation);
                    }
                }
                catch (Exception ex)
                {
                    errorMessage = String.Format("Failed to generate xml order file: '{0}'.", ex.Message);
                    log.WriteLine(errorMessage);
                    CleanUp(costCalculation);
                    throw ex;
                }

                #endregion

                #region 6. Transform XML to HTML with XSLT transformation

                try
                {
                    using (var xmlStream = xmlBlob.OpenRead())
                    {
                        using (var htmlStream = htmlBlob.OpenWrite())
                        {
                            TransformXmlToHtml(xmlStream, htmlStream, costDiscount);
                        }
                    }
                }
                catch (Exception ex)
                {
                    errorMessage = String.Format("Failed to transform xml order file to html: '{0}'.", ex.Message);
                    log.WriteLine(errorMessage);
                    CleanUp(costCalculation);
                    throw ex;
                }

                #endregion

                #region 7. Send 2-emails: 1st without attachment to Customer and 2nd with attachment (xml) to Backoffice

                try
                {
                    using (var htmlStream = htmlBlob.OpenRead())
                    {
                        using (var htmlReader = new StreamReader(htmlStream))
                        {
                            using (var xmlStream = xmlBlob.OpenRead())
                            {
                                SendEmailNotifications(customer, htmlReader.ReadToEnd(), xmlStream, String.Format("order_{0}.xml", order.ID));
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    errorMessage = String.Format("Failed to send e-mails: '{0}'.", ex.Message);
                    log.WriteLine(errorMessage);
                    CleanUp(costCalculation);
                    throw ex;
                }

                #endregion

                #region 8. Delete blob files order_[#].xml and order_[#].html

                xmlBlob.Delete();
                htmlBlob.Delete();

                #endregion

                #region 9. Clean up (Order + OrderDetails) and Save changes

                // Decided to comment, because of having plans to purchase 2GB Database plan for storing historical data.
                //////db.Orders.Remove(order);
                //////db.SaveChanges();
                
                #endregion

                CleanUp(costCalculation);
            }                
            
            log.WriteLine("Message successfully processed.");
        }

        private static void CleanUp(IDisposable obj)
        {
            if (obj != null)
                obj.Dispose();
        }

        private static void GenerateXmlFile(Stream s, Order order, Customer customer, IEnumerable<Merchandise> merchandises, IOrderCostCalculation occ)
        {
            if (order == null)
                throw new ArgumentNullException("order");
            if (customer == null)
                throw new ArgumentNullException("customer");
            if (merchandises == null)
                throw new ArgumentNullException("merchandises");
            if (occ == null)
                throw new ArgumentNullException("occ");
            if (s == null)
                throw new ArgumentNullException("s");

            var writer = new XmlTextWriter(s, Encoding.UTF8);
            writer.Formatting = Formatting.Indented;
            var culture = new CultureInfo("ru-RU");

            // Order -->
            writer.WriteStartElement("Order");
            writer.WriteAttributeString("id", order.ID.ToString());
            writer.WriteAttributeString("created", order.Created.Date.ToString("d", culture));

            // Customer -->
            writer.WriteStartElement("Customer");

            writer.WriteStartElement("Info");
            writer.WriteAttributeString("name", "id");
            writer.WriteAttributeString("value", customer.ID);
            writer.WriteEndElement();

            writer.WriteStartElement("Info");
            writer.WriteAttributeString("name", "company");
            writer.WriteAttributeString("value", customer.Company);
            writer.WriteEndElement();

            writer.WriteStartElement("Info");
            writer.WriteAttributeString("name", "phone");
            writer.WriteAttributeString("value", customer.PhoneNumber);
            writer.WriteEndElement();

            writer.WriteStartElement("Info");
            writer.WriteAttributeString("name", "email");
            writer.WriteAttributeString("value", customer.EmailAddress);
            writer.WriteEndElement();

            writer.WriteStartElement("Info");
            writer.WriteAttributeString("name", "contactName");
            writer.WriteAttributeString("value", customer.ContactName);
            writer.WriteEndElement();

            writer.WriteStartElement("Info");
            writer.WriteAttributeString("name", "address");
            writer.WriteAttributeString("value", customer.Address);
            writer.WriteEndElement();

            writer.WriteStartElement("Info");
            writer.WriteAttributeString("name", "inn");
            writer.WriteAttributeString("value", customer.INN);
            writer.WriteEndElement();

            writer.WriteEndElement();
            // <-- Customer

            // OrderDetails -->
            writer.WriteStartElement("Details");

            #region Создать представление на основе таблиц OrderDetails и Merchandise
            
            var merchandiseOrder =
                order.Details.Join(merchandises, od => od.GoodsID, m => m.ID, (od, m) => new
                {
                    MerchandiseId = m.ID,
                    Title = m.Title,
                    Pack = m.Pack,
                    UnitMeasure = m.UnitMeasure,
                    OrderCost = occ.GetMerchandisePriceWithDiscount(order.ID, m.ID),
                    OrderQuantity = od.Quantity,
                    OrderComment = od.Comment
                });

            #endregion

            foreach (var item in merchandiseOrder)
            {
                writer.WriteStartElement("Item");
                writer.WriteAttributeString("merchandiseId", item.MerchandiseId.ToString());
                writer.WriteAttributeString("title", item.Title);
                writer.WriteAttributeString("unitMeasure", item.UnitMeasure);
                writer.WriteAttributeString("pack", item.Pack.ToString());
                writer.WriteAttributeString("cost", item.OrderCost.ToString());
                writer.WriteAttributeString("quantity", item.OrderQuantity.ToString());
                writer.WriteAttributeString("sum", (item.OrderCost * item.OrderQuantity).ToString());
                writer.WriteAttributeString("comment", item.OrderComment);
                writer.WriteEndElement();
            }

            writer.WriteEndElement();
            // <-- OrderDetails

            writer.WriteEndElement();
            // <-- Order

            writer.Flush();
        }

        private static void TransformXmlToHtml(Stream xmlStream, Stream htmlStream, double orderSum)
        {
            if (xmlStream == null)
                throw new ArgumentNullException("xmlStream");
            if (htmlStream == null)
                throw new ArgumentNullException("htmlStream");

            var xt = new XslCompiledTransform();

            var assembly = Assembly.GetExecutingAssembly();
            var resourceName = "Altech.WebJobs.OrderProcessing.order.xslt";
            using (var stream = assembly.GetManifestResourceStream(resourceName))
            using (var reader = new XmlTextReader(stream))
            {
                xt.Load(reader);
            }

            var args = new XsltArgumentList();
            args.AddParam("sum", String.Empty, orderSum.ToString("N"));

            xt.Transform(new XPathDocument(xmlStream), args, htmlStream);
        }

        private static CloudBlobContainer GetOrdersBlobContainer()
        {
            CloudBlobContainer ordersContainer = null;

            var storageAccount = CloudStorageAccount.Parse(
                    ConfigurationManager.ConnectionStrings["StorageConnection"].ConnectionString);

            var blobClient = storageAccount.CreateCloudBlobClient();

            // Retrieve a reference to a container. 
            ordersContainer = blobClient.GetContainerReference(ordersContainerName);

            // Create the container if it doesn't already exist.
            ordersContainer.CreateIfNotExists();

            // Make container private
            ordersContainer.SetPermissions(
                new BlobContainerPermissions
                {
                    PublicAccess =
                        BlobContainerPublicAccessType.Off
                });

            return ordersContainer;
        }

        private static void SendEmailNotifications(Customer customer, string html, Stream attachment, string attachmentFileName)
        {
            if (customer == null)
                throw new ArgumentNullException("customer");
            if (String.IsNullOrWhiteSpace(html))
                throw new ArgumentNullException("html");
            if (attachment == null)
                throw new ArgumentNullException("attachment");
            if (String.IsNullOrWhiteSpace(attachmentFileName))
                throw new ArgumentNullException("attachmentFileName");

            SendClientMail(customer, html).Wait();

            SendBackOfficeMail(customer, html, attachment, attachmentFileName).Wait();
        }

        private static async Task SendClientMail(Customer customer, string html)
        {
            var apiKey = ConfigurationManager.AppSettings["sg_altexweb"];
            dynamic sgc = new SendGridAPIClient(apiKey);

            var subject = "Новый заказ на сайте АЛТЕХ Хозтовары";
            var to = new Email(customer.EmailAddress);
            var from = new Email("admin@altexweb.ru", "Altex Web");
            var content = new Content("text/html", html);
            var mail = new Mail(from, subject, to, content);
            mail.ReplyTo = new Email("AlexTechnologies@gmail.com");

            // Send email to customer.
            dynamic response = await sgc.client.mail.send.post(requestBody: mail.Get());
            if (response.StatusCode != System.Net.HttpStatusCode.Accepted)
            {
                throw new FailedSendMailException(
                    String.Format("Failed to send mail to client, SendGrid server returned status: {0}", 
                        response.StatusCode.ToString()));
            }
        }

        private static async Task SendBackOfficeMail(Customer customer, string html, Stream attachment, string attachmentFileName)
        {
            var apiKey = ConfigurationManager.AppSettings["sg_altexweb"];
            dynamic sgc = new SendGridAPIClient(apiKey);

            string subject = String.Format("Новый заказ на сайте АЛТЕХ Хозтовары от {0}", customer.Company);
            var to = new Email("AlexTechnologies@gmail.com");
            var from = new Email("admin@altexweb.ru", "Altex Web");
            var content = new Content("text/html", html);
            var mail = new Mail(from, subject, to, content);
            mail.ReplyTo = new Email(customer.EmailAddress);

            #region attachment preparation 

            var attchLen = (int)attachment.Length;
            var attchBytes = new byte[attchLen];
            attachment.Read(attchBytes, 0, attchLen);

            var attch = new Attachment();
            attch.Content = System.Convert.ToBase64String(attchBytes);
            attch.Type = "text/plain";
            attch.Filename = attachmentFileName;
            attch.Disposition = "attachment";
            attch.ContentId = "Order Details";
            mail.AddAttachment(attch);

            #endregion

            // Send email to back   office.
            dynamic response = await sgc.client.mail.send.post(requestBody: mail.Get());
            if (response.StatusCode != System.Net.HttpStatusCode.Accepted)
            {
                throw new FailedSendMailException(
                    String.Format("Failed to send email to backoffice, SendGrid server returned status: {0}",
                        response.StatusCode.ToString()));
            }
        }

    }
}