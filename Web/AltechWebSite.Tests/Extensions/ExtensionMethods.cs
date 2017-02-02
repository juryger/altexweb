using System;
using NSubstitute;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.WebSite.Tests
{
    public static class ExtensionMethods
    {
        public static IDbSet<T> Initialise<T>(this IDbSet<T> dbSet, IQueryable<T> data) where T : class
        {
            dbSet.Provider.Returns(data.Provider);
            dbSet.Expression.Returns(data.Expression);
            dbSet.ElementType.Returns(data.ElementType);
            dbSet.GetEnumerator().Returns(data.GetEnumerator());

            return dbSet;
        }
    }
}
