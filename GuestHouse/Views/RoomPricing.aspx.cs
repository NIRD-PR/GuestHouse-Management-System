using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using GuestHouse.Models;
namespace GuestHouse.Views
{
    public partial class RoomPricing : System.Web.UI.Page
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
                this.BindGrid();
            }
        }


        private void BindGrid()
        {
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            string query = "SELECT * FROM Master.RoomType";
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(query, con))
                {
                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
            }
        }

        protected void Insert(object sender, EventArgs e)
        {
            string type = txtRT.Text;
            string rate = txtRate.Text;
            txtRT.Text = "";
            txtRate.Text = "";
            string query = "INSERT INTO Master.RoomType VALUES(@RoomType, @Rate)";
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    cmd.Parameters.AddWithValue("@RoomType", type);
                    cmd.Parameters.AddWithValue("@Rate", rate);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            this.BindGrid();
        }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            this.BindGrid();
        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView1.Rows[e.RowIndex];
            int RoomTypeID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string type = (row.FindControl("txtRT") as TextBox).Text;
            string rate = (row.FindControl("txtRate") as TextBox).Text;
            string query = "UPDATE Master.RoomType SET RoomType=@RoomType,Rate=@Rate WHERE RoomTypeID=@RoomTypeID";
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    cmd.Parameters.AddWithValue("@RoomTypeID", RoomTypeID);
                    cmd.Parameters.AddWithValue("@RoomType", type);
                    cmd.Parameters.AddWithValue("@Rate", rate);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            GridView1.EditIndex = -1;
            this.BindGrid();
        }

        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            GridView1.EditIndex = -1;
            this.BindGrid();
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int RoomTypeID= Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string query = "DELETE FROM Master.RoomType WHERE RoomTypeID=@RoomTypeID";
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    cmd.Parameters.AddWithValue("@RoomTypeID", RoomTypeID);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            this.BindGrid();
        }
        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != GridView1.EditIndex)
            {
                (e.Row.Cells[2].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            }
        }

        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            this.BindGrid();
        }
    }
}