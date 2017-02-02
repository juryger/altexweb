using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Altech.WebSite.Utilities
{
    internal sealed class CookieHandler
    {
        internal static T GetCookieValue<T>(HttpCookieCollection container, HttpResponseBase response, string name, T defaultValue, DateTime expires)
        {
            var cookie = container[name];

            // Если в Cookie нет идентификатора, сгенерировать новый и сохранить новое значение в Cookie
            if (cookie == null || String.IsNullOrWhiteSpace(cookie.Value))
            {
                response.SetCookie(new HttpCookie(name, Convert.ToString(defaultValue)) { Expires = expires, Path = "/" });
                return defaultValue;
            }

            return (T)Convert.ChangeType(cookie.Value, typeof(T));
        }

        internal static void SetCookieValue<T>(HttpResponseBase response, string name, T value, DateTime expires)
        {
            response.SetCookie(new HttpCookie(name, Convert.ToString(value)) { Expires = expires, Path = "/" });
        }
    }
}