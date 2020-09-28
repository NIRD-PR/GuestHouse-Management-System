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
            Session.Abandon();
            FormsAuthentication.SignOut();
        }

        protected void userLoginButton_Click(object sender, EventArgs e)
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
                Session["email"] = inputEmailAddress.Value;
                System.Diagnostics.Debug.WriteLine(Session["email"]);
                //Response.Redirect("Dashboard.aspx");
                //Response.Redirect("Dashboard.aspx", false);
                //Context.ApplicationInstance.CompleteRequest();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Login Successful')", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Your email and password doesn\\'t match')", true);
            }
        }

        protected void adminLoginButton_Click(object sender, EventArgs e)
        {

        }
    }
}