using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace Hostel_Management_System_Project
{
    public partial class S_CancelMyBooking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate attendance list
                PopulateMyBookingList();
            }
        }
        private void PopulateMyBookingList()
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                string student_id = Session["student_id"].ToString();
                SqlCommand cmd = new SqlCommand("select ROW_NUMBER() OVER (ORDER BY bt.booking_id) AS SerialNumber, bt.booking_id, bt.student_id, bt.booking_date, bt.status as booking_status, rf.room_id, rf.room_no, rf.room_desc from booking_table bt full join room_facilities rf on bt.room_id = rf.room_id where bt.student_id = @student_id and bt.status = 'Confirmed';", con);
                cmd.Parameters.AddWithValue("@student_id", student_id);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    // Bind the DataTable to the Repeater
                    BookingRepeater.DataSource = dt;
                    BookingRepeater.DataBind();
                    noResultsMessage.Visible = false;
                }
                else
                {
                    BookingRepeater.DataSource = null; // Clear the repeater
                    BookingRepeater.DataBind();
                    noResultsMessage.Visible = true;
                }

            }
        }

        protected void btn_Cancel_Click(object sender, EventArgs e)
        {
            // Get the booking_id from the clicked button's CommandArgument
            Button btn = (Button)sender;
            int bookingId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                // Update booking_table status to 'Cancelled' for the specific booking_id
                SqlCommand updateBookingCmd = new SqlCommand("UPDATE booking_table SET status = 'Cancelled' WHERE booking_id = @bookingId", con);
                updateBookingCmd.Parameters.AddWithValue("@bookingId", bookingId);
                updateBookingCmd.ExecuteNonQuery();

                // Get the room_id associated with the cancelled booking
                SqlCommand getRoomIdCmd = new SqlCommand("SELECT room_id FROM booking_table WHERE booking_id = @bookingId", con);
                getRoomIdCmd.Parameters.AddWithValue("@bookingId", bookingId);
                int roomId = Convert.ToInt32(getRoomIdCmd.ExecuteScalar());

                // Update room_facilities room_status to 'Vacant' for the specific room_id
                SqlCommand updateRoomCmd = new SqlCommand("UPDATE room_facilities SET room_status = 'Vacant' WHERE room_id = @roomId", con);
                updateRoomCmd.Parameters.AddWithValue("@roomId", roomId);
                updateRoomCmd.ExecuteNonQuery();

                // Get the payment ID associated with the canceled booking
                SqlCommand getPaymentIdCmd = new SqlCommand("SELECT payment_id FROM booking_table WHERE booking_id = @bookingId", con);
                getPaymentIdCmd.Parameters.AddWithValue("@bookingId", bookingId);
                int paymentId = Convert.ToInt32(getPaymentIdCmd.ExecuteScalar());

                // Update the payment table to mark the payment as 'Cancelled' or 'Refunded' (cancelled for now)
                SqlCommand updatePaymentCmd = new SqlCommand("UPDATE payment_table SET payment_status = 'Cancelled' WHERE payment_id = @paymentId", con);
                updatePaymentCmd.Parameters.AddWithValue("@paymentId", paymentId);
                updatePaymentCmd.ExecuteNonQuery();
            }

            // After the update, rebind the Repeater to show the updated data
            PopulateMyBookingList();

        }

    }
}