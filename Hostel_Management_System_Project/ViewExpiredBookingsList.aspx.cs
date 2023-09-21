using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class ViewExpiredBookingsList : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize the page with expired bookings
                LoadExpiredBookings();
            }
        }

        protected void timerExpiredBookings_Tick(object sender, EventArgs e)
        {
            // Get the current time
            DateTime currentTime = DateTime.Now;

            // Connect to the database (replace with your connection string)
            using (SqlConnection con = new SqlConnection("Data Source=DESKTOP-JRHVVPL\\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();

                // Update expired bookings in booking_table
                SqlCommand bookingCmd = new SqlCommand(
                    "UPDATE booking_table " +
                    "SET status = 'Auto Cancelled' " +
                    "WHERE status = 'Pending' AND created_at < @currentTime", con);

                bookingCmd.Parameters.AddWithValue("@currentTime", currentTime);
                int updatedBookingRows = bookingCmd.ExecuteNonQuery();

                // Update room_facilities table with a join to booking_table for cancelled bookings
                SqlCommand roomCmd = new SqlCommand(
                    "UPDATE rf " +
                    "SET room_status = 'Vacant' " +
                    "FROM room_facilities AS rf " +
                    "INNER JOIN booking_table AS bt ON rf.room_id = bt.room_id " +
                    "WHERE bt.status = 'Auto Cancelled' AND bt.created_at < @currentTime", con);

                roomCmd.Parameters.AddWithValue("@currentTime", currentTime);
                int updatedRoomRows = roomCmd.ExecuteNonQuery();

                // Reload the expired bookings after processing
                if (updatedBookingRows > 0 || updatedRoomRows > 0)
                {
                    LoadExpiredBookings();
                }
            }
        }


        private void LoadExpiredBookings()
        {
            // Fetch and display the list of expired bookings
            DataTable dt = FetchExpiredBookings();

            // Bind the data to the Repeater control
            ExpiredBookingsRepeater.DataSource = dt;
            ExpiredBookingsRepeater.DataBind();
        }

        private DataTable FetchExpiredBookings()
        {
            using (SqlConnection con = new SqlConnection("Data Source=DESKTOP-JRHVVPL\\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                string query = @"
                    SELECT 
                          ROW_NUMBER() OVER (ORDER BY bt.booking_id) AS sl_no,* 
                    FROM 
                          booking_table bt 
                    INNER JOIN 
                          room_facilities rt on rt.room_id = bt.room_id 
                    INNER JOIN 
                          student_table st on st.student_id = bt.student_id 
                    WHERE 
                          bt.status = 'Auto Cancelled'";

                // Fetch expired bookings
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                return dt;
            }
        }

    }
}