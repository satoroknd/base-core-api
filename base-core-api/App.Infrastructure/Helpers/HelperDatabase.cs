using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App.Infrastructure.Helpers
{
    public static class HelperDatabase
    {
        public static string PrepareParameters(List<SqlParameter> parameters)
        {
            string paramResponse = "";
            foreach (var item in parameters)
            {
                string prepareParam = "'" + item.Value + "'";
                paramResponse = paramResponse + prepareParam + ",";
            }
            paramResponse = paramResponse.TrimEnd(',');
            return paramResponse;
        }
    }
}
