using Microsoft.Azure.WebJobs;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.WebJobs.ImageResizer
{
    class Program
    {
        const int newHeight = 100, newWidth = 100;

        static void Main(string[] args)
        {
            JobHost host = new JobHost();
            host.RunAndBlock();
        }

        public static void MakeThumbnailImage(
            [BlobTrigger("images/{name}")] Stream input,
            [Blob("thumbnail-images/{name}", FileAccess.Write)] Stream output)
        {
            Image originalImage = new Bitmap(input);
            Image newImage = new Bitmap(newWidth, newHeight);
            using (Graphics graphicsHandle = Graphics.FromImage(newImage))
            {
                graphicsHandle.InterpolationMode = InterpolationMode.HighQualityBicubic;
                graphicsHandle.DrawImage(originalImage, 0, 0, newWidth, newHeight);
            }

            newImage.Save(output, ImageFormat.Jpeg);
        }
    }
}
