using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using GuestHouse.Models;
namespace GuestHouse.Views
{
    public partial class Bookings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                DataTable dummy = new DataTable();
                dummy.Columns.Add("FirstName");
                dummy.Columns.Add("LastName");
                dummy.Columns.Add("NoOfMembers");
                dummy.Columns.Add("BookingFrom");
                dummy.Columns.Add("BookingTo");
                dummy.Columns.Add("PhoneNo");
                dummy.Columns.Add("Address");
                dummy.Columns.Add("TotalAmount");
                dummy.Rows.Add();
                gvBookings.DataSource = dummy;
                gvBookings.DataBind();

                //Required for jQuery DataTables to work.
                gvBookings.UseAccessibleHeader = true;
                gvBookings.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        [WebMethod]
        public static List<GuestHouse.Models.Bookings> GetBookings()
        {
            List<GuestHouse.Models.Bookings> bookings = new List<GuestHouse.Models.Bookings>();
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT FirstName, LastName, NoOfMembers, BookingFrom,BookingTo,PhoneNo,Address,TotalAmount FROM dbo.Bookings", con))
                {
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            bookings.Add(new GuestHouse.Models.Bookings
                            {
                                FirstName = sdr["FirstName"].ToString(),
                                LastName = sdr["LastName"].ToString(),
                                NoOfMembers = Convert.ToInt32(sdr["NoOfMembers"]),
                                BookingFrom = Convert.ToDateTime(sdr["BookingFrom"].ToString()),
                                BookingTo = Convert.ToDateTime(sdr["BookingTo"].ToString()),
                                PhoneNo = sdr["PhoneNo"].ToString(),
                                Address = sdr["Address"].ToString(),
                                TotalAmount = Convert.ToDecimal(sdr["TotalAmount"])
                            });
                        }
                    }
                    con.Close();
                }
            }

            return bookings;
        }
    }
}