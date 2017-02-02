using Altech.Core.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.Core
{
    public sealed class GeneralRepositoryFactory
    {
        public static Func<IGeneralRepository> RepositoryBuilder = CreateDefaultRepositoryBuilder;

        public IGeneralRepository BuildRepository()
        {
            return RepositoryBuilder();
        }

        private static IGeneralRepository CreateDefaultRepositoryBuilder()
        {
            throw new ApplicationException("No repository builder specified.");
        }
    }
}
