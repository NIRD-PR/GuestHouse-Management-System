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
        //HtmlGenericControl input = inputEmailAddress;
        //HtmlGenericControl email = inputEmailAddress;

        protected void Page_Load(object sender, EventArgs e)
        {
            inputEmailAddress.Attributes.Add("type", "email");
            inputEmailAddress.Attributes["type"] = "email";
            //Session.Abandon();
            FormsAuthentication.SignOut();
        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine(inputEmailAddress.Value);
            System.Diagnostics.Debug.WriteLine(inputPassword.Value);

            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            
            SqlCommand cmd = new SqlCommand("dbo.spLogin", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            
            cmd.Parameters.AddWithValue("@Email", inputEmailAddress.Value);
            cmd.Parameters.AddWithValue("@password", inputPassword.Value);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            if (dt.Rows.Count > 0)
            {
                System.Diagnostics.Debug.WriteLine(dt.Rows[0].Field<String>("FirstName"));
                //var convertedList = (from rw in dt.AsEnumerable()
                //                     select new MyObj()
                //                     {
                //                         ID = Convert.ToInt32(rw["ID"]),
                //                         Name = Convert.ToString(rw["Name"])
                //                     }).ToList();

                var rw = dt.Rows[0];
                LoginUser user = new LoginUser();
                user.ID = rw.Field<String>("ID");
                user.FirstName = rw.Field<String>("FirstName");
                user.LastName = rw.Field<String>("LastName");
                user.MobileNo = rw.Field<String>("MobileNo");
                user.Email = rw.Field<String>("Email");
                user.PrimaryRole = rw.Field<String>("PrimaryRole");
                user.SecondaryRole = rw.Field<String>("SecondaryRole");

                Session["user"] = user;
                //System.Diagnostics.Debug.WriteLine(Session["email"]);
                Response.Redirect("Dashboard.aspx", false);
                //Context.ApplicationInstance.CompleteRequest();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Login Successful')", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Your email and password doesn\\'t match')", true);
            }
        }

    }
}