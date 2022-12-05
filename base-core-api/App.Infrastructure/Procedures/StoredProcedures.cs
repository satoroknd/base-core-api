using App.Common.Classes.DTO;
using System.Data;
using System.Data.SqlClient;
using System.Dynamic;

namespace App.Infrastructure.Procedures
{
    //Dynamic
    public static partial class StoredProcedures
    {

        public static void ExecuteNonQuery(string query, List<SqlParameter> parameters = null, string connectionString = null)
        {
            using (SqlConnection connection = GetSqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection) { CommandTimeout = connection.ConnectionTimeout })
                {
                    command.CommandType = parameters != null ? CommandType.StoredProcedure : CommandType.Text;
                    if (parameters != null && parameters.Count > 0)
                        command.Parameters.AddRange(parameters.ToArray());
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public static IEnumerable<dynamic> Execute(string query, List<SqlParameter> parameters = null, string connectionString = null)
        {
            using (SqlConnection connection = GetSqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection) { CommandTimeout = connection.ConnectionTimeout })
                {
                    command.CommandType = parameters != null ? CommandType.StoredProcedure : CommandType.Text;
                    if (parameters != null && parameters.Count > 0)
                        command.Parameters.AddRange(parameters.ToArray());
                    connection.Open();

                    using (SqlDataReader rdr = command.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        return rdr.Cast<IDataRecord>().Select(record =>
                        {
                            ExpandoObject expando = new ExpandoObject();
                            IDictionary<string, object> dictionary = expando as IDictionary<string, object>;
                            for (int i = 0; i < record.FieldCount; i++)
                                dictionary[record.GetName(i) ?? string.Empty] = record.GetValue(i) is DBNull ? null : record.GetValue(i);
                            return (dynamic)expando;
                        }).ToArray();
                    }
                }
            }
        }

        public static void ExecuteListParams(List<OrderForSaveContract> details, string connectionString)
        {
            using (SqlConnection connection = GetSqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand cmd = new SqlCommand("exec Add_Order @details", connection))
                {
                    using (var table = new DataTable())
                    {
                        table.Columns.Add("ProductID", typeof(int));
                        table.Columns.Add("ProductCode", typeof(string));
                        table.Columns.Add("ProductDescription", typeof(string));
                        table.Columns.Add("Quantity", typeof(int));
                        table.Columns.Add("UnitValue", typeof(int));
                        table.Columns.Add("CustomerDNI", typeof(string));
                        table.Columns.Add("CustomerAddress", typeof(string));

                        foreach (var item in details)
                        {
                            table.Rows.Add(item.ProductID, item.ProductCode, item.ProductDescription, item.Quantity, item.UnitValue, item.CustomerDNI, item.CustomerAddress);
                        }


                        var pList = new SqlParameter("@details", SqlDbType.Structured);
                        pList.TypeName = "dbo.OrderForSaveContract";
                        pList.Value = table;

                        cmd.Parameters.Add(pList);

                        using (var dr = cmd.ExecuteReader())
                        {

                        }
                    }
                }
            }
        }


        public static SqlConnection GetSqlConnection(string connectionString)
        {
            SqlConnection conn = new SqlConnection(connectionString);
            return conn;
        }


    }
}
