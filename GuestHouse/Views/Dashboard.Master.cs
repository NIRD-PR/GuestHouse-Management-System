using GuestHouse.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GuestHouse.Views
{
    public partial class Dashboard1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine(Session["user"]);
            bool isLoggedIn = (Session["user"] == null ? false : true);

            if (isLoggedIn)
            {
                LoginUser user = Session["user"] as LoginUser;

                if (user.HasPrimaryRole("Admin"))
                {
                    rdts.Visible = true;
                    rbkg.Visible = true;
                    mgmt.Visible = true;
                    rmpr.Visible = true;
                    report.Visible = true;
                }
                else if (user.HasPrimaryRole("user"))
                {
                    rbkg.Visible = true;
                    if (user.HasSecondaryRole("Admin")) {
                        rdts.Visible = true;
                    }
                }
            }
            else {
                Response.Redirect("Login.aspx");
            }
        }
    }
}