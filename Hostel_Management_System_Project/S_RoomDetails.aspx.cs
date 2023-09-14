using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class S_RoomDetails : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["roomId"] != null)
                {
                    int roomId = Convert.ToInt32(Request.QueryString["roomId"]);

                    // Fetch room details and associated photo based on roomId
                    PopulateRoomDetails(roomId);
                }
                else
                {
                    // Handle the case when roomId is not provided in the URL
                    Response.Redirect("500.aspx");
                }
            }
        }

        private void PopulateRoomDetails(int roomId)
        {
            con.Open();
            // Fetch room details
            SqlCommand roomCmd = new SqlCommand("SELECT room_facilities.room_id, room_no, room_desc, room_status, photo_url FROM room_facilities inner join room_photos on room_facilities.room_id = room_photos.room_id where room_facilities.room_id = @roomId", con);
            roomCmd.Parameters.AddWithValue("@roomId", roomId);
            SqlDataReader roomReader = roomCmd.ExecuteReader();
            if (roomReader.Read())
            {
                // Populate room details on the page
                lbl_RoomNo.Text = roomReader["room_no"].ToString();
                lbl_RoomDesc.Text = roomReader["room_desc"].ToString();
                lbl_RoomStatus.Text = roomReader["room_status"].ToString();

                // Display the room photo
                string photoUrl = roomReader["photo_url"].ToString();
                if (!string.IsNullOrEmpty(photoUrl))
                {
                    // Display the room photo
                    img_RoomPhoto.ImageUrl = ResolveUrl("~/RoomPhotos/" + photoUrl);
                }
            }
            else
            {
                // Handle the case when the room is not found
                // For example, you can display an error message or redirect to an error page.
                Response.Redirect("404.aspx");
            }
        }
    }
}