using Altech.Core.Interfaces;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Queue;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace Altech.WebSite.Services
{
    internal class MQueueNewOrderNotifier: INewOrderNotifier
    {
        public void Notify(int orderId)
        {
            var storageAccount = CloudStorageAccount.Parse(
                ConfigurationManager.ConnectionStrings["StorageConnection"].ConnectionString);

            // Create the queue client
            var queueClient = storageAccount.CreateCloudQueueClient();

            // Retrieve a reference to a queue
            var queue = queueClient.GetQueueReference("ordersqueue");

            // Create the queue if it doesn't already exist
            queue.CreateIfNotExists();

            // Create a message and add it to the queue.
            queue.AddMessage(new CloudQueueMessage(orderId.ToString()));
        }
    }
}