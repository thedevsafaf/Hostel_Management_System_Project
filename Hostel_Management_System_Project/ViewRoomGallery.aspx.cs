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
    public partial class ViewRoomGallery : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Fetch room data from your database
                DataTable roomData = GetRoomDataFromDatabase();

                // Bind room data to the Repeater control
                RoomPhotosRepeater.DataSource = roomData;
                RoomPhotosRepeater.DataBind();
            }
        }
        // Retrieve room data from the database
        private DataTable GetRoomDataFromDatabase()
        {
            var roomData = new DataTable();
            con.Open();
            var query = "SELECT ROW_NUMBER() OVER (ORDER BY room_facilities.room_id) AS sl_no, room_no, room_desc, room_status, photo_url FROM room_facilities inner join room_photos on room_facilities.room_id = room_photos.room_id";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(roomData);
            con.Close();
            return roomData;
        }

        protected string GetStatusCssClass(string status)
        {
            switch (status)
            {
                case "Vacant":
                    return "status-vacant";
                case "Occupied":
                    return "status-occupied";
                case "Inactive":
                    return "status-inactive";
                default:
                    return string.Empty; // No specific class for other values
            }
        }
    }
}