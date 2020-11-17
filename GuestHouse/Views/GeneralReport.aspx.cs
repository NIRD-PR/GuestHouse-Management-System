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
    public partial class GeneralReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/GeneralReport.rdlc");
            Reports.GeneralReport dsBookings = GetData(ddlDays.SelectedItem.Value);
            ReportDataSource datasource = new ReportDataSource("GeneralReport", dsBookings.Tables[0]);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(datasource);
        }

        private Reports.GeneralReport GetData(string date)
        {
            string conString = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.Bookings WHERE BookingFrom >= GETDATE()-@Date"))
            {
                using (SqlConnection con = new SqlConnection(conString))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        cmd.Parameters.AddWithValue("@Date", Convert.ToInt32(date));
                        using (Reports.GeneralReport dsBookings = new Reports.GeneralReport())
                        {
                            try
                            {
                                sda.Fill(dsBookings, "Bookings");
                                return dsBookings;
                            }
                            catch(Exception ex)
                            {
                                throw ex;
                            }
                        }
                    }
                }
            }
        }

        protected void DaysChanged(object sender, EventArgs e)
        {
            this.BindReport();
        }
    }
}