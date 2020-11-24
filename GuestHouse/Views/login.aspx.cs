using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Security;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;
using GuestHouse.Models;

namespace GuestHouse
{
    public partial class login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ClearCache();
                Random _rand = new Random();
                ViewState["KeyGenerator"] = _rand.Next();
                inputEmailAddress.Focus();
            }
            inputEmailAddress.Attributes.Add("type", "email");
            inputEmailAddress.Attributes["type"] = "email";
            //Session.Abandon();
            FormsAuthentication.SignOut();
        }

        public static void ClearCache()
        {
            HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            HttpContext.Current.Response.Cache.SetExpires(DateTime.Now);
            HttpContext.Current.Response.Cache.SetNoServerCaching();
            HttpContext.Current.Response.Cache.SetNoStore();
            HttpContext.Current.Response.Cookies.Clear();
            HttpContext.Current.Request.Cookies.Clear();
        }

        protected void loginAdmin(object sender, EventArgs e, DataTable dt) {
            foreach (DataRow dr in dt.Rows)
            {
                System.Diagnostics.Debug.WriteLine(dr.Field<String>("Name"));

                string myval = FormsAuthentication.HashPasswordForStoringInConfigFile(ViewState["KeyGenerator"].ToString(), "SHA1");
                string password = dr.Field<String>("Password").ToString();
                password = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "SHA1");
                string value = FormsAuthentication.HashPasswordForStoringInConfigFile(password.ToLower() + myval.ToLower(), "SHA1");
                

                if (txtPwdHash.Value == value.ToLower())
                {
                    LoginUser user = new LoginUser();
                    user.ID = dr["UID"].ToString();
                    user.Name = dr["Name"].ToString();
                    user.MobileNo = dr["Mobile"].ToString();
                    user.Email = dr["Email"].ToString();
                    user.PrimaryRole = "Admin";

                    Session["user"] = user;
                    Response.Redirect("Dashboard.aspx", false);
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Login Successful')", true);
                }
                else {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Your email and password doesn\\'t match')", true);
                }
            }
        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            //System.Diagnostics.Debug.WriteLine(inputEmailAddress.Value);
            //System.Diagnostics.Debug.WriteLine(inputPassword.Value);

            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd;
            SqlDataAdapter sda;
            DataTable dt;

            // Check in employee table
            cmd = new SqlCommand("SELECT * FROM dbo.PR_tbl_Employee WHERE Email = @Email", con);
            cmd.Parameters.AddWithValue("@Email", inputEmailAddress.Value);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            if (dt.Rows.Count > 0)
            {
                loginAdmin(sender, e, dt);
            }

            // Check in Project Staff table
            cmd = new SqlCommand("SELECT * FROM dbo.PR_tbl_ProjectStaff WHERE Email = @Email", con);
            cmd.Parameters.AddWithValue("@Email", inputEmailAddress.Value);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            if (dt.Rows.Count > 0)
            {
                loginAdmin(sender, e, dt);
            }

            // Check in the GMS database
            cmd = new SqlCommand("SELECT * FROM dbo.Login WHERE Email=@Email", con);
            cmd.Parameters.AddWithValue("@Email", inputEmailAddress.Value);
            //cmd.Parameters.AddWithValue("@Password", inputPassword.Value);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            if (dt.Rows.Count > 0)
            {
                var dr = dt.Rows[0];
                System.Diagnostics.Debug.WriteLine(dr.Field<String>("FirstName"));

                string myval = FormsAuthentication.HashPasswordForStoringInConfigFile(ViewState["KeyGenerator"].ToString(), "SHA1");
                string password = dr.Field<String>("Password").ToString();
                //password = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "SHA1");
                string value = FormsAuthentication.HashPasswordForStoringInConfigFile(password.ToLower() + myval.ToLower(), "SHA1");


                if (txtPwdHash.Value == value.ToLower())
                {

                    LoginUser user = new LoginUser();
                    user.ID = dr.Field<String>("ID");
                    user.Name = dr.Field<String>("FirstName") + ' ' + dr.Field<String>("LastName");
                    user.MobileNo = dr.Field<String>("MobileNo");
                    user.Email = dr.Field<String>("Email");
                    user.PrimaryRole = dr.Field<String>("PrimaryRole");
                    user.SecondaryRole = dr.Field<String>("SecondaryRole");

                    Session["user"] = user;
                    Response.Redirect("Dashboard.aspx", false);
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Login Successful')", true);
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Your email and password doesn\\'t match')", true);
            }
        }

    }
}