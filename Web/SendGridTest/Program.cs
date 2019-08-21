// using SendGrid's C# Library
// https://github.com/sendgrid/sendgrid-csharp
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
            var apiKey = System.Configuration.ConfigurationManager.AppSettings["sg_altexweb"];

            /*            
            dynamic sg = new SendGridAPIClient(apiKey);

            Email from = new Email("test@example.com");
            string subject = "Sending with SendGrid is Fun";
            Email to = new Email("juryger@gmail.com");
            Content content = new Content("text/plain", "and easy to do anywhere, even with C#");
            Mail mail = new Mail(from, subject, to, content);

            dynamic response = await sg.client.mail.send.post(requestBody: mail.Get());
            */

            var client = new SendGridClient(apiKey);

            var subject = "Sending with Twilio SendGrid is Fun";
            var from = new EmailAddress("test@example.com", "Example User");            
            var to = new EmailAddress("juryger@gmail.com");
            var plainTextContent = "and easy to do anywhere, even with C#";
            var htmlContent = "<strong>and easy to do anywhere, even with C#</strong>";

            var msg = MailHelper.CreateSingleEmail(from, to, subject, plainTextContent, htmlContent);

            var response = await client.SendEmailAsync(msg);
        }
    }
}
