using System.Web;
using System.Web.Optimization;

namespace Altech.WebSite
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-1.10.2.min.js"));

            // add Yandex Counters
            bundles.Add(new ScriptBundle("~/bundles/yandex").Include(
            "~/Scripts/yandex.js"));

            // add JSTree support
            bundles.Add(new ScriptBundle("~/bundles/jstree").Include(
                        "~/Scripts/jstree.min.js"));

            // add Altech support
            bundles.Add(new ScriptBundle("~/bundles/altech").Include(
                        "~/Scripts/altech.js"));

            // add Lightbox support
            bundles.Add(new ScriptBundle("~/bundles/lightbox").Include(
                        "~/Scripts/jquery.lighter.js"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js",
                      "~/Scripts/respond.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/core.css",
                      "~/Content/site.css",
                      "~/Content/altech.css",
                      "~/Content/jstree.min.css",
                      "~/Content/jquery.lighter.css",
                      "~/Content/rouble_style.css"));
        }
    }
}
