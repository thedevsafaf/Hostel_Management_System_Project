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
    public partial class S_MakePayment : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        public static int selectedBookingId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Populate the dropdown with available rooms from the database
                PopulateBookedRoomDropdown();
            }
        }

        private void PopulateBookedRoomDropdown()
        {
            con.Open();
            int student_id = Convert.ToInt32(Session["student_id"]);
            string query = @"
                select 
                      bt.booking_id, bt.student_id,bt.booking_date,
                      bt.status as booking_status, bt.booked_by, rf.room_id as booked_room_id,
                      rf.room_no as booked_room_no, rf.room_desc, rf.room_status,
                      bt.payment_id from booking_table bt 
                inner join 
                      room_facilities rf on bt.room_id = rf.room_id 
                where 
                      student_id = @student_id and rf.room_status = 'On Hold' and bt.booked_by = 'Student' and bt.status='Pending';";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@student_id", student_id);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            // Get the booking ID from the first row of the DataTable (assuming there is only one row)
            if (dt.Rows.Count > 0)
            {
                selectedBookingId = Convert.ToInt32(dt.Rows[0]["booking_id"]);
            }

            ddl_BookedRoom.DataSource = dt;
            ddl_BookedRoom.DataTextField = "booked_room_no";
            ddl_BookedRoom.DataValueField = "booked_room_id";
            ddl_BookedRoom.DataBind();
            con.Close();
        }

        protected void btn_Pay_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                int studentId = Convert.ToInt32(Session["student_id"]);
                decimal paymentAmount = decimal.Parse(tb_Amount.Text);
                DateTime paymentDate = DateTime.Parse(tb_PaymentDate.Text);

                // Step 1: Insert payment record into the payment_table
                int paymentId = InsertPaymentRecord(studentId, paymentAmount, paymentDate, "Paid", "Student");

                // Step 2: Update booking status to "Confirmed"
                UpdateBookingStatus(selectedBookingId, "Confirmed", paymentId);

                // Step 3: Update room status to "Occupied"
                UpdateRoomStatus(selectedBookingId);

                // Redirect to a success page or display a success message
                //Response.Redirect("PaymentSuccess.aspx");
                // Show a SweetAlert for successful room registration
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessAlert", "ShowSuccessAlert();", true);
            }
            catch(Exception exc)
            {
                // Handle exceptions as needed
                string errorMessage = exc.Message;
                // Show a SweetAlert for the error
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorAlert", "ShowErrorAlert('" + errorMessage + "');", true);
            }
            finally
            {
                con.Close();
            }
        }

        //Insert Record to Payment Table
        private int InsertPaymentRecord(int studentId, decimal paymentAmount, DateTime paymentDate, string paymentStatus, string paidBy)
        {
            using (SqlCommand cmd = new SqlCommand("INSERT INTO payment_table (student_id, amount, payment_date, payment_status, created_at, paid_by) VALUES (@studentId, @amount, @paymentDate, @paymentStatus, GETDATE(), @paidBy); SELECT SCOPE_IDENTITY();", con))
            {
                cmd.Parameters.AddWithValue("@studentId", studentId);
                cmd.Parameters.AddWithValue("@amount", paymentAmount);
                cmd.Parameters.AddWithValue("@paymentDate", paymentDate);
                cmd.Parameters.AddWithValue("@paymentStatus", paymentStatus);
                cmd.Parameters.AddWithValue("@paidBy", paidBy);

                // ExecuteScalar to get the generated payment_id
                int paymentId = Convert.ToInt32(cmd.ExecuteScalar());

                return paymentId;
            }
        }

        private void UpdateBookingStatus(int bookingId, string status, int paymentId)
        {
            using (SqlCommand cmd = new SqlCommand("UPDATE booking_table SET status = @status, payment_id = @paymentId WHERE booking_id = @bookingId", con))
            {
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@paymentId", paymentId);
                cmd.Parameters.AddWithValue("@bookingId", bookingId);
                cmd.ExecuteNonQuery();
            }
        }

        private void UpdateRoomStatus(int bookingId)
        {
            using (SqlCommand cmd = new SqlCommand("UPDATE room_facilities SET room_status = 'Occupied' WHERE room_id = (SELECT room_id FROM booking_table WHERE booking_id = @bookingId)", con))
            {
                cmd.Parameters.AddWithValue("@bookingId", bookingId);
                cmd.ExecuteNonQuery();
            }
        }

    }
}