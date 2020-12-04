using GuestHouse.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace GuestHouse.Views
{
    public partial class AddBookings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //bool isLoggedIn = (Session["user"] == null ? false : true);
            //if (!isLoggedIn)
            //{
            //    Response.Redirect("login.aspx");
            //}

            if (!IsPostBack)
            {
                ddlBT.DataSource = getData("spGetBookingType", null);
                ddlBT.DataBind();
                ddlBT.Items.Insert(0, new ListItem("", "0"));

                ddlGH.DataSource = getData("spGetGuestHouse", null);
                ddlGH.DataBind();
                ddlGH.Items.Insert(0, new ListItem("", "0"));


            }
            
        }
        protected void ddlGH_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlRT.Items.Clear();
            ddlRT.Items.Insert(0, new ListItem("", "0"));
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            SqlConnection con = new SqlConnection(CS);
            SqlCommand cmd = new SqlCommand("spGetAvailableRoomTypes", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@GuestHouseID", ddlGH.SelectedItem.Value);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddlRT.DataSource = dt;
            ddlRT.DataBind();
        }

        protected void ddlRT_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlAR.Items.Clear();
            ddlAR.Items.Insert(0, new ListItem("", "0"));
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            SqlConnection con = new SqlConnection(CS);
            SqlCommand cmd = new SqlCommand("spGetAvailableRooms", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@GuestHouseID", ddlGH.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@RoomTypeID", ddlRT.SelectedItem.Value);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddlAR.DataSource = dt;
            ddlAR.DataBind();
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

        [System.Web.Services.WebMethod]
        public static object SaveBookingDetails(object bookingData)
        {
            object o = string.Empty;
            GuestHouse.Models.Bookings b = new JavaScriptSerializer().ConvertToType<GuestHouse.Models.Bookings>(bookingData);

            var context = new ValidationContext(b, serviceProvider: null, items: null);
            var results = new List<ValidationResult>();
            var isValid = Validator.TryValidateObject(b, context, results, true);

            if (!isValid)
            {

                foreach (var validationResult in results)
                {

                    // throw new ArgumentException("Please fill all the mandatory fields.");
                    HttpContext.Current.Response.Write(validationResult.ErrorMessage.ToString());
                }
                return o;
            }
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString))
            {
                try
                {
                    SqlCommand sc = new SqlCommand("dbo.spBookingDetailsCRUD", con);
                    sc.CommandType = CommandType.StoredProcedure;
                    
                    sc.Parameters.AddWithValue("@Action", "INSERT");
                    sc.Parameters.AddWithValue("@AssignRoomID", b.AssignRoomID);
                    sc.Parameters.AddWithValue("@FirstName", b.FirstName.Trim());
                    sc.Parameters.AddWithValue("@LastName", b.LastName.Trim());
                    sc.Parameters.AddWithValue("@BookingTypeID", b.BookingTypeID);
                    sc.Parameters.AddWithValue("@Members", b.NoOfMembers);
                    sc.Parameters.AddWithValue("@PhoneNo", b.PhoneNo.Trim());
                    sc.Parameters.AddWithValue("@BookingTo", Convert.ToDateTime(b.BookingTo));
                    sc.Parameters.AddWithValue("@BookingFrom", Convert.ToDateTime(b.BookingFrom));
                    sc.Parameters.AddWithValue("@Address", b.Address.Trim());
                    
                    //for training details.
                    if(b.BookingTypeID==1)
                    {
                        sc.Parameters.AddWithValue("@trName", b.trName.Trim());
                        sc.Parameters.AddWithValue("@trDirector", b.trDirector.Trim());
                        sc.Parameters.AddWithValue("@trFrom", Convert.ToDateTime(b.trFrom));
                        sc.Parameters.AddWithValue("@trTo", Convert.ToDateTime(b.trTo));
                    }
                    if (b.BookingTypeID == 2)
                    {
                        sc.Parameters.AddWithValue("@purpVis", b.purpVis.Trim());
                        sc.Parameters.AddWithValue("@visWh", b.visWh.Trim());
                        sc.Parameters.AddWithValue("cenVis", b.cenVis.Trim());

                    }
                        con.Open();
                    sc.ExecuteNonQuery(); System.Diagnostics.Debug.WriteLine("Hello2!");
                    con.Close();
                }


                catch (Exception ex)
                {
                    throw ex;
                }
            }

            return o;
        }
    }
}