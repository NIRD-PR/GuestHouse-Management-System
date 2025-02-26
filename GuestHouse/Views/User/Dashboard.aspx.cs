﻿using GuestHouse.Models;
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

namespace GuestHouse.Views.User
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            rptTable.DataSource =    Dashboard.GetBookings();
            rptTable.DataBind();
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
                using (SqlCommand cmd = new SqlCommand("SELECT ( B.FirstName +' '+ B.LastName) AS Name,G.Name AS GuestHouse ,R.RoomNumber,T.BookingType, B.NoOfMembers, B.BookingFrom,B.BookingTo,B.TotalAmount FROM dbo.Bookings B inner join Master.BookingType T on B.BookingTypeID=T.BookingTypeId inner join dbo.Rooms R on R.RoomID=B.AssignRoomID inner join Master.GuestHouseIndex G on G.GuestHouseID=R.GuestHouseID where  B.BookingTo>=GETDATE()", con))
                {
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            bookings.Add(new GuestHouse.Models.BookingsViewModel
                            {
                                Name = sdr["Name"].ToString(),
                                GuestHouse=sdr["GuestHouse"].ToString(),
                                RoomNumber=sdr["RoomNumber"].ToString(),
                                BookingType = sdr["BookingType"].ToString(),
                                NoOfMembers = Convert.ToInt32(sdr["NoOfMembers"]),
                                BookingFrom = Convert.ToDateTime(sdr["BookingFrom"].ToString()),
                                BookingTo = Convert.ToDateTime(sdr["BookingTo"].ToString()),                                                       
                                TotalAmount = Convert.ToDecimal(sdr["TotalAmount"]),

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