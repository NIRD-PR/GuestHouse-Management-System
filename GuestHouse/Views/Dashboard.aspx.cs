using GuestHouse.Models;
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

namespace GuestHouse.Views
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            rptTable.DataSource = Dashboard.GetBookings();
            rptTable.DataBind();
            var dataset = getData("spGetReports", null);
            RoomsAvailable.InnerText = (dataset.Tables[0].Rows[0].ItemArray[0].ToString());//Available Room count
            RoomsBlocked.InnerText = (dataset.Tables[1].Rows[0].ItemArray[0].ToString());//Blocked Room count
            InHouse.InnerText = (dataset.Tables[2].Rows[0].ItemArray[0].ToString());//In-House count
            Revenue.InnerText = (dataset.Tables[3].Rows[0].ItemArray[0].ToString());//Revenue(Last 30 days)
        }

        [WebMethod]
        public static List<object> GetChartData()
        {
            string query = "SELECT B.BookingStatus, COUNT(R.BookingStatusID) TotalBookings";
            query += " FROM dbo.Rooms R JOIN Master.BookingStatus B on B.BookingStatusID=R.BookingStatusID  GROUP BY B.BookingStatus";
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            List<object> chartData = new List<object>();
            chartData.Add(new object[]
            {
        "BookingStatus", "TotalBookings"
            });
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            chartData.Add(new object[]
                            {
                        sdr["BookingStatus"], sdr["TotalBookings"]
                            });
                        }
                    }
                    con.Close();
                    return chartData;
                }
            }
        }

        [WebMethod]
        public static List<GuestHouse.Models.BookingsViewModel> GetBookings()
        {
            List<GuestHouse.Models.BookingsViewModel> bookings = new List<GuestHouse.Models.BookingsViewModel>();
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT ( B.FirstName +' '+ B.LastName) AS Name,G.Name AS GuestHouse ,R.RoomNumber,B.BookingID,R.RoomID,T.BookingType, B.NoOfMembers, B.BookingFrom,B.BookingTo,B.TotalAmount FROM dbo.Bookings B inner join Master.BookingType T on B.BookingTypeID=T.BookingTypeId inner join dbo.Rooms R on R.RoomID=B.AssignRoomID inner join Master.GuestHouseIndex G on G.GuestHouseID=R.GuestHouseID where  B.BookingTo>=GETDATE() and B.BookingFrom<=GETDATE() and B.isActive=1", con))
                {
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            bookings.Add(new GuestHouse.Models.BookingsViewModel
                            {
                                Name = sdr["Name"].ToString(),
                                GuestHouse = sdr["GuestHouse"].ToString(),
                                RoomNumber = sdr["RoomNumber"].ToString(),
                                BookingType = sdr["BookingType"].ToString(),
                                NoOfMembers = Convert.ToInt32(sdr["NoOfMembers"]),
                                BookingFrom = Convert.ToDateTime(sdr["BookingFrom"].ToString()),
                                BookingTo = Convert.ToDateTime(sdr["BookingTo"].ToString()),
                                TotalAmount = Convert.ToDecimal(sdr["TotalAmount"]),
                                BookingID = Convert.ToInt32(sdr["BookingID"]),
                                RoomID = Convert.ToInt32(sdr["RoomID"])
                            });

                        }
                    }
                    con.Close();
                }
            }

            return bookings;
        }

        protected void CheckOut_Click(object sender,EventArgs e)
        {
            LinkButton lb = sender as LinkButton;
            string[] commandArgs = lb.CommandArgument.ToString().Split(new char[] { ',' });
            string RoomID = commandArgs[0];
            string BookingID = commandArgs[1];
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("spBookingDetailsCRUD"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "CHECKOUT");
                    cmd.Parameters.AddWithValue("@AssignRoomID", RoomID);
                    cmd.Parameters.AddWithValue("@BookingID", BookingID);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            rptTable.DataSource = Dashboard.GetBookings();
            rptTable.DataBind();
        }

        protected void ShowExt_Click(object sender, EventArgs e)
        {
            LinkButton lb = sender as LinkButton;
            string[] commandArgs = lb.CommandArgument.ToString().Split(new char[] { ',' });
            string RoomID = commandArgs[0];
            string BookingID = commandArgs[1];                     
            hiddenRoom.Text = RoomID;
            hiddenBooking.Text = BookingID;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
            
            

        }
        protected void OnExtend(object sender, EventArgs e)
        {
            
            int extend = Convert.ToInt32(txtExt.Text.ToString());
            int RoomID = Convert.ToInt32(hiddenRoom.Text.ToString());
            int BookingID = Convert.ToInt32(hiddenBooking.Text.ToString());
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("spBookingDetailsCRUD"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "EXTEND");
                    cmd.Parameters.AddWithValue("@AssignRoomID", RoomID);
                    cmd.Parameters.AddWithValue("@BookingID", BookingID);
                    cmd.Parameters.AddWithValue("@Extend", extend);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            rptTable.DataSource = Dashboard.GetBookings();
            rptTable.DataBind();
            Response.Redirect("Dashboard.aspx", true);
        }

        private DataSet getData(string Proc, SqlParameter Parameter)
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();
                SqlDataAdapter DA = new SqlDataAdapter(Proc, con);
                DA.SelectCommand.CommandType = CommandType.StoredProcedure;
                if (Parameter != null)
                {
                    DA.SelectCommand.Parameters.Add(Parameter);
                }
                DataSet DS = new DataSet();
                DA.Fill(DS);
                return DS;
            }
        }

    }
}