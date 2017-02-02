// using SendGrid's C# Library
// https://github.com/sendgrid/sendgrid-csharp
using System;
using SendGrid;
using SendGrid.Helpers.Mail;
using System.Threading.Tasks;

namespace SendGridTest
{
    class Program
    {
        static void Main(string[] args)
        {
            Execute().Wait();
        }

        static async Task Execute()
        {
            //string apiKey = Environment.GetEnvironmentVariable("NAME_OF_THE_ENVIRONMENT_VARIABLE_FOR_YOUR_SENDGRID_KEY", EnvironmentVariableTarget.User);
            var apiKey = System.Configuration.ConfigurationManager.AppSettings["sg_altexweb"];
            dynamic sg = new SendGridAPIClient(apiKey);

            Email from = new Email("test@example.com");
            string subject = "Sending with SendGrid is Fun";
            Email to = new Email("juryger@gmail.com");
            Content content = new Content("text/plain", "and easy to do anywhere, even with C#");
            Mail mail = new Mail(from, subject, to, content);

            dynamic response = await sg.client.mail.send.post(requestBody: mail.Get());
        }
    }
}
