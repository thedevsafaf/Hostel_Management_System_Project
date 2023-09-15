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
    public partial class S_RequestRefund : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate attendance list
                PopulateMyRefundPaymentsList();
            }
        }

        private void PopulateMyRefundPaymentsList()
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                string student_id = Session["student_id"].ToString();
                SqlCommand cmd = new SqlCommand("select ROW_NUMBER() OVER (ORDER BY bt.booking_id) AS SerialNumber, bt.booking_id, bt.student_id,bt.booking_date,bt.status as booking_status, rf.room_id as booked_room_id, rf.room_no as booked_room_no, rf.room_desc, rf.room_status,bt.payment_id as payment_id, pt.amount as amount, pt.payment_date as payment_date from booking_table bt inner join room_facilities rf on bt.room_id = rf.room_id inner join payment_table pt on bt.payment_id = pt.payment_id where bt.student_id = @student_id AND bt.status = 'Cancelled';", con);
                cmd.Parameters.AddWithValue("@student_id", student_id);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    // Bind the DataTable to the Repeater
                    RefundPaymentRepeater.DataSource = dt;
                    RefundPaymentRepeater.DataBind();
                    noResultsMessage.Visible = false;
                }
                else
                {
                    RefundPaymentRepeater.DataSource = null; // Clear the repeater
                    RefundPaymentRepeater.DataBind();
                    noResultsMessage.Visible = true;
                }

            }
        }

        protected void btn_Refund_Click(object sender, EventArgs e)
        {
            int paymentId = Convert.ToInt32(((Button)sender).CommandArgument);
            string studentName;
            decimal paymentAmount;
            DateTime paymentDate, bookingDate;
            string roomNo;

            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_for_refund_notifications", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@payment_Id", paymentId);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    studentName = reader["name"].ToString();
                    paymentAmount = Convert.ToDecimal(reader["payment_amount"]);
                    paymentDate = Convert.ToDateTime(reader["payment_date"]);
                    bookingDate = Convert.ToDateTime(reader["booking_date"]);
                    roomNo = reader["room_no"].ToString();
                }
                else
                {
                    //display an error message to Handle the case where no data is found for the payment ID
                    Response.Write("No such payment ID ");
                    return;
                }

                // Create the notification message
                string message = $"Refund requested for\nPayment ID: {paymentId}\nStudent Name: {studentName}\nPayment Amount: {paymentAmount:C}\nPayment Date: {paymentDate:dd-MM-yyyy}\nBooking Date: {bookingDate:dd-MM-yyyy}\nRoom Number: {roomNo}";
                


                // Insert the notification message into the notification_table (assuming you have a method for this)
                InsertNotificationMessage(studentName, message);

                // Redirect or display a confirmation message
                Response.Write("RefundConfirmation.aspx");
            }
        }

        private void InsertNotificationMessage(string studentName, string message)
        {
            // to insert the notification message into the notification_table
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                string insertQuery = "INSERT INTO notification_table (student_id, message, notification_type, created_at) " +
                                     "VALUES (@studentId, @message, @notification_type, GETDATE())";
                SqlCommand cmd = new SqlCommand(insertQuery, con);
                int studentId = int.Parse(Session["student_id"].ToString());
                cmd.Parameters.AddWithValue("@studentId", studentId);
                cmd.Parameters.AddWithValue("@message", message);
                cmd.Parameters.AddWithValue("@notification_type", "Refund");
                cmd.ExecuteNonQuery();
            }
        }

    }
}