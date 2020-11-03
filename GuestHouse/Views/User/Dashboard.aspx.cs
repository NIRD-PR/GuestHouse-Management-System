﻿using System;
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
    }
}