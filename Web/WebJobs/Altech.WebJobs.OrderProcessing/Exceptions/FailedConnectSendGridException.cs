using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.WebJobs.OrderProcessing.Exceptions
{
    /// <summary>
    /// Used to indicate that attempt to send mail has failed.
    /// </summary>
    internal class FailedSendMailException: Exception
    {
        public FailedSendMailException()
        {
        }

        public FailedSendMailException(string message)
            : base(message)
        {
        }

        public FailedSendMailException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}
