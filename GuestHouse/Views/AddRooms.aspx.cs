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
    public partial class AddRooms : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DropDownListRoom.DataSource = getData("spGetRoomType", null);
                DropDownListRoom.DataBind();
                ListItem LIRoomType = new ListItem("---Select---", "-1");
                DropDownListRoom.Items.Insert(0, LIRoomType);



                DropDownListGH.DataSource = getData("spGetGuestHouse", null);
                DropDownListGH.DataBind();
                ListItem LIGuestHouse = new ListItem("---Select---", "-1");
                DropDownListGH.Items.Insert(0, LIGuestHouse);

            }
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
        public static object SaveRoomDetails(object roomData)
        {
            System.Diagnostics.Debug.WriteLine("Hello!");
            object o = string.Empty;
            RoomModel r = new JavaScriptSerializer().ConvertToType<RoomModel>(roomData);

            var context = new ValidationContext(r, serviceProvider: null, items: null);
            var results = new List<ValidationResult>();
            var isValid = Validator.TryValidateObject(r, context, results, true);

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
                    SqlCommand sc = new SqlCommand("dbo.spRoomDetailsCRUD", con);
                    sc.CommandType = CommandType.StoredProcedure;
                    // string ImageUniqueName = Guid.NewGuid().ToString();
                    // string ActualImageName = ImageUniqueName + Path.GetExtension(r.InputImage.FileName);
                    //  r.InputImage.SaveAs(HttpContext.Current.Server.MapPath("~/RoomImages/" + ActualImageName));
                    sc.Parameters.AddWithValue("@Action", "INSERT");
                    sc.Parameters.AddWithValue("@RoomNumber", r.RoomNumber.Trim());
                    //sc.Parameters.AddWithValue("@RoomPrice", r.RoomPrice.Trim());
                    //sc.Parameters.AddWithValue("@BookingStatusID", r.BookingStatusID);
                    sc.Parameters.AddWithValue("@RoomTypeID", r.RoomTypeID);
                    sc.Parameters.AddWithValue("@RoomCapacity", r.RoomCapacity);
                    sc.Parameters.AddWithValue("@RoomDescription", r.RoomDescription.Trim());
                    sc.Parameters.AddWithValue("@GuestHouseID", r.GuestHouseID);
                    //sc.Parameters.AddWithValue("@RoomImage", ActualImageName.Trim());
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