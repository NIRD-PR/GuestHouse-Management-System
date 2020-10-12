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
                dummy.Columns.Add("BookingType");
                dummy.Columns.Add("NoOfMembers");
                dummy.Columns.Add("BookingFrom");
                dummy.Columns.Add("BookingTo");
                dummy.Columns.Add("PhoneNo");
                dummy.Columns.Add("Address");
                dummy.Columns.Add("TotalAmount");
                dummy.Columns.Add("TrainingName");
                dummy.Columns.Add("TrainingDirector");
                dummy.Columns.Add("TrainingFrom");
                dummy.Columns.Add("TrainingTo");
                dummy.Columns.Add("PurposeOfVisit");
                dummy.Columns.Add("VisitingWhom");
                dummy.Columns.Add("CenterVisiting");
                dummy.Rows.Add();
                gvBookings.DataSource = dummy;
                gvBookings.DataBind();

                //Required for jQuery DataTables to work.
                gvBookings.UseAccessibleHeader = true;
                gvBookings.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }


        [WebMethod]
        public static List<GuestHouse.Models.BookingsViewModel> GetBookings()
        {
            List<GuestHouse.Models.BookingsViewModel> bookings = new List<GuestHouse.Models.BookingsViewModel>();
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT B.FirstName, B.LastName,T.BookingType, B.NoOfMembers, B.BookingFrom,B.BookingTo,B.PhoneNo,B.Address,B.TotalAmount,B.TrainingName,B.TrainingDirector,B.TrainingFrom,B.TrainingTo,B.PurposeOfVisit,B.VisitingWhom,B.CenterVisiting FROM dbo.Bookings B inner join Master.BookingType T on B.BookingTypeID=T.BookingTypeId", con))
                {
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            bookings.Add(new GuestHouse.Models.BookingsViewModel
                            {
                                FirstName = sdr["FirstName"].ToString(),
                                LastName = sdr["LastName"].ToString(),
                                BookingType=sdr["BookingType"].ToString(),
                                NoOfMembers = Convert.ToInt32(sdr["NoOfMembers"]),
                                BookingFrom = Convert.ToDateTime(sdr["BookingFrom"].ToString()),
                                BookingTo = Convert.ToDateTime(sdr["BookingTo"].ToString()),
                                PhoneNo = sdr["PhoneNo"].ToString(),
                                Address = sdr["Address"].ToString(),
                                TotalAmount = Convert.ToDecimal(sdr["TotalAmount"]),
                                
                                //for training details.
                                TrainingName = sdr["TrainingName"].ToString(),
                                TrainingDirector = sdr["TrainingDirector"].ToString(),
                                TrainingFrom = sdr.IsDBNull(11) ? (DateTime?)null : Convert.ToDateTime(sdr["TrainingFrom"].ToString()),
                                TrainingTo = sdr.IsDBNull(12) ? (DateTime?)null : Convert.ToDateTime(sdr["TrainingTo"].ToString()),

                                //for official visit details.
                                PurposeOfVisit=sdr["PurposeOfVisit"].ToString(),
                                CenterVisiting=sdr["CenterVisiting"].ToString(),
                                VisitingWhom=sdr["VisitingWhom"].ToString()
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