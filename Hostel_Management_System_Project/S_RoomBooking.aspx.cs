using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class S_RoomBooking : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                // Populate the dropdown with available rooms from the database
                PopulateAvailableRoomDropdown();
            }
        }

        private void PopulateAvailableRoomDropdown()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("select room_id, room_no from room_facilities where room_status = 'Vacant'", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddl_RoomSelection.DataSource = dt;
            ddl_RoomSelection.DataTextField = "room_no";
            ddl_RoomSelection.DataValueField = "room_id";
            ddl_RoomSelection.DataBind();
            con.Close();
        }

        protected void btn_BookRoom_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO booking_table (student_id, room_id, booking_date, status, created_at) " +
                                                    "VALUES (@studentId, @roomId, @bookingDate, @bookingStatus, GETDATE())", con);
                    //set the booking status as needed ("Pending" here)
                    int studentId = Convert.ToInt32(Session["student_id"]);
                    int selectedRoomId = Convert.ToInt32(ddl_RoomSelection.SelectedValue);
                    DateTime bookingDate = DateTime.Parse(tb_BookingDate.Text);
                    cmd.Parameters.AddWithValue("@studentId", studentId);
                    cmd.Parameters.AddWithValue("@roomId", selectedRoomId);
                    cmd.Parameters.AddWithValue("@bookingDate", bookingDate);
                    cmd.Parameters.AddWithValue("@bookingStatus", "Pending");

                    cmd.ExecuteNonQuery();

                    // (Booking) Partial => Room Status : Vacant -> On Hold, (After Payment) => Room Status : Occupied
                    UpdateRoomStatus(selectedRoomId, "On Hold");

                    con.Close();

                    //clear();

                    Response.Redirect("S_RoomBooking.aspx");
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions as needed
                string errorMessage = ex.Message;
                Response.Write(errorMessage);
            }

        }


        private void UpdateRoomStatus(int roomId, string status)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("UPDATE room_facilities SET room_status = @status WHERE room_id = @roomId", con);
                    cmd.Parameters.AddWithValue("@status", status);
                    cmd.Parameters.AddWithValue("@roomId", roomId);
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions as needed
                string errorMessage = ex.Message;
                Response.Write(errorMessage);
            }
        }



    }
}