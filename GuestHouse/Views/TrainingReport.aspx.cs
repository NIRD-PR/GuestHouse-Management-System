using GuestHouse.Models;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GuestHouse.Views
{
    public partial class TrainingReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool isLoggedIn = (Session["user"] == null ? false : true);
            if (!isLoggedIn)
            {
                Response.Redirect("logout.aspx");
            }

            LoginUser user = Session["user"] as LoginUser;

            if (!user.HasPrimaryRole("admin"))
            {
                Response.Redirect("logout.aspx");
            }
            if (!this.IsPostBack)
            {
                this.BindReport();
            }
        }

        private void BindReport()
        {
            ReportViewer1.ProcessingMode = ProcessingMode.Local;
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/TrainingReport.rdlc");

            Reports.TrainingReport dsBookings = GetData(programName.text());
            ReportDataSource datasource = new ReportDataSource("GeneralReport", dsBookings.Tables[0]);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(datasource);
        }

        private Reports.TrainingReport GetData(string programName)
        {
            string conString = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.Bookings WHERE BookingFrom>=@Start AND BookingFrom<=@End+1"))
            {
                using (SqlConnection con = new SqlConnection(conString))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        cmd.Parameters.AddWithValue("@Start", start);
                        cmd.Parameters.AddWithValue("@End", end);
                        using (Reports.GeneralReport dsBookings = new Reports.GeneralReport())
                        {
                            try
                            {
                                sda.Fill(dsBookings, "Bookings");
                                return dsBookings;
                            }
                            catch (Exception ex)
                            {
                                throw ex;
                            }
                        }
                    }
                }
            }
        }
    }
}