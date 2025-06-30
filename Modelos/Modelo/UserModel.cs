using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccess;

namespace Modelos.Modelo
{
    public class UserModel
    {
        private readonly UserDao userDao = new UserDao();

        public bool LoginUser(string usuario, string password)
        {
            return userDao.Login(usuario, password);
        }
    }
}
