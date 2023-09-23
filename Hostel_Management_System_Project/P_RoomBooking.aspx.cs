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
    public partial class P_RoomBooking : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                // fetching student id and name for the parent booking
                FetchStudentID();
                // Populate the dropdown with available rooms from the database
                PopulateAvailableRoomDropdown();
            }
        }

        private void FetchStudentID()
        {
            con.Open();
            int parentID = Convert.ToInt32(Session["parent_id"]);
            SqlCommand cmd = new SqlCommand("select pt.student_id,st.name as student_name from parent_table pt inner join student_table st on st.student_id = pt.student_id where parent_id = @parent_id", con);
            cmd.Parameters.AddWithValue("@parent_id", parentID);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                tb_StudentID.Text = dt.Rows[0]["student_id"].ToString();
                tb_StudentName.Text = dt.Rows[0]["student_name"].ToString();
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
                    SqlCommand cmd = new SqlCommand("INSERT INTO booking_table (student_id, room_id, booking_date, status, created_at, booked_by) " +
                                                    "VALUES (@studentId, @roomId, @bookingDate, @bookingStatus, GETDATE(), @booked_by)", con);
                    //set the booking status as needed ("Pending" here)
                    //set the booked_by as "Parent" here
                    int studentId = Convert.ToInt32(tb_StudentID.Text);
                    int selectedRoomId = Convert.ToInt32(ddl_RoomSelection.SelectedValue);
                    DateTime bookingDate = DateTime.Parse(tb_BookingDate.Text);
                    cmd.Parameters.AddWithValue("@studentId", studentId);
                    cmd.Parameters.AddWithValue("@roomId", selectedRoomId);
                    cmd.Parameters.AddWithValue("@bookingDate", bookingDate);
                    cmd.Parameters.AddWithValue("@bookingStatus", "Pending");
                    cmd.Parameters.AddWithValue("@booked_by", "Parent");

                    cmd.ExecuteNonQuery();

                    // (Booking) Partial => Room Status : Vacant -> On Hold, (After Payment) => Room Status : Occupied
                    UpdateRoomStatus(selectedRoomId, "On Hold");

                    con.Close();

                    //clear();

                    //Response.Redirect("P_RoomBooking.aspx");
                    // Show a SweetAlert for successful room registration
                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessAlert", "ShowSuccessAlert();", true);
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions as needed
                string errorMessage = ex.Message;
                // Show a SweetAlert for the error
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorAlert", "ShowErrorAlert('" + errorMessage + "');", true);
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