using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class UpdateRoom : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            //loading already registered data for updation
            if (!IsPostBack)
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_rooms_list", con);
                cmd.CommandType = CommandType.StoredProcedure;
                string room_id = Session["room_id"].ToString();
                cmd.Parameters.AddWithValue("@room_id", room_id);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    tb_RoomNo.Text = dt.Rows[0][1].ToString();
                    tb_RoomDesc.Text = dt.Rows[0][2].ToString();
                    ddl_RoomStatus.SelectedValue = dt.Rows[0][3].ToString();
                }
                con.Close();
            }
        }

        protected void btn_Update_Click(object sender, EventArgs e)
        {
            //string room_id = Session["room_id"].ToString(); OR
            int roomId = int.Parse(Session["room_id"].ToString());

            con.Open();

            // Update room details in room_table
            SqlCommand cmdUpdateRoom = new SqlCommand("sp_update_room_facility", con);
            cmdUpdateRoom.CommandType = CommandType.StoredProcedure;
            cmdUpdateRoom.Parameters.AddWithValue("@room_id", roomId);
            cmdUpdateRoom.Parameters.AddWithValue("@room_desc", tb_RoomDesc.Text);
            cmdUpdateRoom.Parameters.AddWithValue("@room_status", ddl_RoomStatus.SelectedValue);
            cmdUpdateRoom.ExecuteNonQuery();



            con.Close();

            //for navigating to room list page
            Response.Redirect("ViewRoomFacilitiesList.aspx");
        }

    }
}