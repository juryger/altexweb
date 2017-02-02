using Altech.WebSite.Consts;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;

namespace Altech.WebSite.Utilities
{
    internal sealed class RequestParametersHandler
    {
        internal static T GetRequestParameter<T>(NameValueCollection collection, string paramName)
        {
            T res = default(T);

            var paramValue = collection[paramName];

            switch (paramName)
            {
                case WebRequestParamNames.SortField:
                    if (String.IsNullOrEmpty(paramValue))
                        paramValue = WebRequestParamDefaults.SortField;
                    break;
                case WebRequestParamNames.SortOrder:
                    if (String.IsNullOrEmpty(paramValue))
                        paramValue = WebRequestParamDefaults.SortOrder;
                    break;
                case WebRequestParamNames.Page:
                    if (String.IsNullOrEmpty(paramValue))
                        paramValue = WebRequestParamDefaults.Page;
                    break;
            }

            res = (T)Convert.ChangeType(paramValue, typeof(T));
            return res;
        }
    }
}