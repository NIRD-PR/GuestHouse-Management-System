using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using GuestHouse.Models;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Web.Services.Protocols;
using System.ComponentModel;
using System.Data.Entity.Core.Metadata.Edm;

namespace GuestHouse.Views
{
    public partial class RoomDetails : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                this.BindRepeater();



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
        public static RoomViewModel GetRoomDetails()
        {
            RoomViewModel room = new RoomViewModel();
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spRoomDetailsCRUD", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "SELECT");
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    room.RoomNumber = rdr["RoomNumber"].ToString();
                    room.RoomPrice = rdr["Rate"].ToString();
                    room.BookingStatus = rdr["BookingStatus"].ToString();
                    room.RoomType = rdr["RoomType"].ToString();
                    room.RoomCapacity = Convert.ToInt32(rdr["RoomCapacity"]);
                    room.RoomDescription = rdr["RoomDescription"].ToString();
                    room.GuestHouse = rdr["Name"].ToString();

                }
            }
            return room;
        }

        protected void RepeaterItemBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DropDownList ddlGH = (e.Item.FindControl("ddlGH") as DropDownList);
                ddlGH.DataSource = getData("spGetGuestHouse", null);
                ddlGH.DataBind();
                ListItem LIGuestHouse = new ListItem("---Select---", "-1");
                ddlGH.Items.Insert(0, LIGuestHouse);
                string selGH = (e.Item.DataItem as DataRowView)["Name"].ToString();
                ddlGH.Items.FindByText(selGH).Selected = true;


                DropDownList ddlBS = (e.Item.FindControl("ddlBS") as DropDownList);
                ddlBS.DataSource = getData("spGetBookingStatus", null);
                ddlBS.DataBind();
                ListItem LIBookingStatus = new ListItem("---Select---", "-1");
                ddlBS.Items.Insert(0, LIBookingStatus);
                string selBS = (e.Item.DataItem as DataRowView)["BookingStatus"].ToString();
                ddlBS.Items.FindByText(selBS).Selected = true;


                DropDownList ddlRT = (e.Item.FindControl("ddlRT") as DropDownList);
                ddlRT.DataSource = getData("spGetRoomType", null);
                ddlRT.DataBind();
                ListItem LIRoomType = new ListItem("---Select---", "-1");
                ddlRT.Items.Insert(0, LIRoomType);
                string selRT = (e.Item.DataItem as DataRowView)["RoomType"].ToString();
                ddlRT.Items.FindByText(selRT).Selected = true;


                // HtmlTableCell td = (HtmlTableCell)e.Item.FindControl("lblIA"); //Where TD1 is the ID of the Table Cell
                /*  bool IsActive = bool.Parse((e.Item.FindControl("lblIA") as Label).Text);
                  HtmlTableRow tr = (HtmlTableRow)e.Item.FindControl("trID");
                  if (IsActive)
                  {
                      //td.Attributes.Add("style", "background-color:Green;");
                      tr.Attributes.Add("style", "background-color:White");

                  }
                  else
                  {
                       tr.Attributes.Add("style", "background-color:Red;");

                  }
                */
            }
        }

        private void BindRepeater()
        {
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                SqlCommand cmd = new SqlCommand("spRoomDetailsCRUD", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "SELECT");
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    RoomTable.DataSource = dt;
                    RoomTable.DataBind();
                }

            }
        }
        public string GetRowColor(string item)
        {
            bool col = bool.Parse(item);
            if (!col)
                return "style='background-color:#ff4d4d'";
            else
                return "style=’background-color:white’";
        }
        protected void OnEdit(object sender, EventArgs e)
        {
            //Find the reference of the Repeater Item.
            RepeaterItem item = (sender as HtmlButton).Parent as RepeaterItem;
            this.ToggleElements(item, true);
            //  this.BindRepeater();

        }

        private void ToggleElements(RepeaterItem item, bool isEdit)
        {
            //Toggle Buttons.
            item.FindControl("btnEdit").Visible = !isEdit;
            item.FindControl("btnUpdate").Visible = isEdit;
            item.FindControl("btnCancel").Visible = isEdit;
            item.FindControl("btnDelete").Visible = !isEdit;

            //Toggle Labels.
            item.FindControl("lblGH").Visible = !isEdit;

            item.FindControl("lblRN").Visible = !isEdit;
            item.FindControl("lblRP").Visible = !isEdit;
            item.FindControl("lblRC").Visible = !isEdit;
            item.FindControl("lblBS").Visible = !isEdit;
            item.FindControl("lblRT").Visible = !isEdit;
            item.FindControl("lblRD").Visible = !isEdit;

            //Toggle TextBoxes.
            item.FindControl("ddlGH").Visible = isEdit;
            //item.FindControl("txtGH").Visible = isEdit;
            item.FindControl("txtRN").Visible = isEdit;
            //  item.FindControl("txtRP").Visible = isEdit;
            item.FindControl("txtRC").Visible = isEdit;
            item.FindControl("ddlBS").Visible = isEdit;
            item.FindControl("ddlRT").Visible = isEdit;
            item.FindControl("txtRD").Visible = isEdit;

        }

        protected void OnUpdate(object sender, EventArgs e)
        {
            RepeaterItem item = (sender as HtmlButton).Parent as RepeaterItem;
            int RoomID = int.Parse((item.FindControl("lblRoomID") as Label).Text);
            string RoomNumber = (item.FindControl("txtRN") as TextBox).Text.Trim();
            // string RoomPrice = (item.FindControl("txtRP") as TextBox).Text.Trim();
            string RoomCapacity = (item.FindControl("txtRC") as TextBox).Text.Trim();
            string RoomDescription = (item.FindControl("txtRD") as TextBox).Text.Trim();
            int GuestHouseID = int.Parse((item.FindControl("ddlGH") as DropDownList).SelectedValue);
            int RoomTypeID = int.Parse((item.FindControl("ddlRT") as DropDownList).SelectedValue);
            int BookingStatusID = int.Parse((item.FindControl("ddlBS") as DropDownList).SelectedValue);

            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("spRoomDetailsCRUD"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "UPDATE");
                    cmd.Parameters.AddWithValue("@RoomID", RoomID);
                    cmd.Parameters.AddWithValue("@RoomNumber", RoomNumber);
                    //cmd.Parameters.AddWithValue("@RoomPrice", RoomPrice);
                    cmd.Parameters.AddWithValue("@RoomCapacity", RoomCapacity);
                    cmd.Parameters.AddWithValue("@RoomDescription", RoomDescription);
                    cmd.Parameters.AddWithValue("@GuestHouseID", GuestHouseID);
                    cmd.Parameters.AddWithValue("@BookingStatusID", BookingStatusID);
                    cmd.Parameters.AddWithValue("@RoomTypeID", RoomTypeID);

                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            this.BindRepeater();


        }




        protected void OnCancel(object sender, EventArgs e)
        {
            //Find the reference of the Repeater Item.
            RepeaterItem item = (sender as HtmlButton).Parent as RepeaterItem;
            this.ToggleElements(item, false);
            // this.BindRepeater();
        }
        protected void OnDelete(object sender, EventArgs e)
        {
            //Find the reference of the Repeater Item.
            RepeaterItem item = (sender as LinkButton).Parent as RepeaterItem;
            int RoomID = int.Parse((item.FindControl("lblRoomID") as Label).Text);


            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("spRoomDetailsCRUD"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "DELETE");
                    cmd.Parameters.AddWithValue("@RoomID", RoomID);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            this.BindRepeater();
        }

        protected void OnBlock(object sender, EventArgs e)
        {
            //Find the reference of the Repeater Item.
            string reason = txtReason.Text.Trim();
            string date = txtDate.Text.Trim();
            int RoomID = Convert.ToInt32(hiddenRoom.Text.ToString());
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("spRoomDetailsCRUD"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "BLOCK");
                    cmd.Parameters.AddWithValue("@RoomID", RoomID);
                    cmd.Parameters.AddWithValue("@Reason", reason);
                    cmd.Parameters.AddWithValue("@ReasonDate", date);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            this.BindRepeater();
        }
        protected void ShowBlock_Click(object sender, EventArgs e)
        {
            LinkButton lb = sender as LinkButton;
            string[] commandArgs = lb.CommandArgument.ToString().Split(new char[] { ',' });
            string RoomID = commandArgs[0];
            bool isActive = Convert.ToBoolean(commandArgs[1]);
            if (isActive)
            {
                hiddenRoom.Text = RoomID;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
            }
            else
            {
                Unblock_Click(RoomID);
            }

        }

        protected void Unblock_Click(string id)
        {
           
            int RoomID = Convert.ToInt32(id.ToString());
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("spRoomDetailsCRUD"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "UNBLOCK");
                    cmd.Parameters.AddWithValue("@RoomID", RoomID);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            this.BindRepeater();
        }
    }

}