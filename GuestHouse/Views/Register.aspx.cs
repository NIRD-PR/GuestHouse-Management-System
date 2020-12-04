using GuestHouse.Models;
using System;
using System.Diagnostics;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.ComponentModel.DataAnnotations;
using System.Web.Security;

namespace GuestHouse.Views
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
       

        [System.Web.Services.WebMethod]
        public static object SaveUserDetails(object userData)
        {
            object o = string.Empty;
            GuestHouse.Models.User user= new JavaScriptSerializer().ConvertToType<GuestHouse.Models.User>(userData);
            System.Diagnostics.Debug.WriteLine("Hello!");

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString))
                {
                    try
                    {
                        SqlCommand sc = new SqlCommand("dbo.spInsertRegistration", con);
                        sc.CommandType = CommandType.StoredProcedure;
                        
                        sc.Parameters.AddWithValue("@FirstName", user.FirstName.Trim());
                        sc.Parameters.AddWithValue("@LastName", user.LastName.Trim());
                        sc.Parameters.AddWithValue("@Email", user.Email.Trim().ToLower());
                        sc.Parameters.AddWithValue("@MobileNo", user.MobileNo.Trim());
                        sc.Parameters.AddWithValue("@ID", user.ID.Trim());
                        var password = FormsAuthentication.HashPasswordForStoringInConfigFile(user.Password.Trim(), "SHA1");
                        sc.Parameters.AddWithValue("@Password", password);
                        con.Open();
                        sc.ExecuteNonQuery(); System.Diagnostics.Debug.WriteLine("Hello2!");
                        con.Close();
                    }
                    
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
            
            return o;
        }
    }
}