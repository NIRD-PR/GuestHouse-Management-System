using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Newtonsoft.Json;
using GuestHouse.Models;

namespace GuestHouse.Views
{
    public partial class CurrentManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoginUser user = Session["user"] as LoginUser;

            if (!user.HasPrimaryRole("admin"))
            {
                Response.Redirect("logout.aspx");
            }
        }

        [System.Web.Services.WebMethod]
        public static string GetManagemetnDetails()
        {
            string DBCS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            SqlConnection con = new SqlConnection(DBCS);
            SqlDataAdapter da = new SqlDataAdapter("Select * from Login", con);

            DataSet ds = new DataSet();
            da.Fill(ds);

            string json = JsonConvert.SerializeObject(ds, Formatting.Indented);

            //System.Diagnostics.Debug.WriteLine(json);
            //System.Diagnostics.Debug.WriteLine("function call");

            return json;
        }

        [System.Web.Services.WebMethod]
        public static string GetRoles()
        {
            string DBCS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            SqlConnection con = new SqlConnection(DBCS);
            SqlDataAdapter da = new SqlDataAdapter("Select * from Master.Roles", con);
            DataSet ds = new DataSet();
            da.Fill(ds);

            string json = JsonConvert.SerializeObject(ds, Formatting.Indented);

            System.Diagnostics.Debug.WriteLine(json);
            System.Diagnostics.Debug.WriteLine("function call");

            return json;
        }

        [System.Web.Services.WebMethod]
        public static void UpdateRequest(string email, string primaryRole, string secondaryRole = null) {
            try
            {
                System.Diagnostics.Debug.WriteLine(email);
                System.Diagnostics.Debug.WriteLine(primaryRole);
                System.Diagnostics.Debug.WriteLine(secondaryRole);

                string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
                SqlConnection con = new SqlConnection(constr);
                using (con)
                {
                    SqlCommand sc = new SqlCommand("dbo.spEditManagement", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };

                    sc.Parameters.AddWithValue("@Action", "EDIT");
                    sc.Parameters.AddWithValue("@Email", email);
                    sc.Parameters.AddWithValue("@PrimaryRole", primaryRole);
                    sc.Parameters.AddWithValue("@SecondaryRole", secondaryRole);
                    con.Open();
                    sc.ExecuteNonQuery();
                    con.Close();
                }
            }
            catch (Exception ex)
            {
                System.Web.Services.WebService wsError = new System.Web.Services.WebService();
                wsError.Context.Response.StatusCode = 500;

                wsError.Context.Response.AppendHeader("error", ex.Message);

            }
        }

        [System.Web.Services.WebMethod]
        public static void DeleteRequest(string email)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine(email);

                string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
                SqlConnection con = new SqlConnection(constr);
                using (con)
                {
                    SqlCommand sc = new SqlCommand("dbo.spEditManagement", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };

                    sc.Parameters.AddWithValue("@Action", "DELETE");
                    sc.Parameters.AddWithValue("@Email", email);
                    con.Open();
                    sc.ExecuteNonQuery();
                    con.Close();
                }
            }
            catch (Exception ex)
            {
                System.Web.Services.WebService wsError = new System.Web.Services.WebService();
                wsError.Context.Response.StatusCode = 500;

                wsError.Context.Response.AppendHeader("error", ex.Message);

            }
        }

    }
}