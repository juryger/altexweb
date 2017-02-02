using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Altech.WebSite.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Stand()
        {
            return View();
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult Contacts()
        {
            return View();
        }
    }
}