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
    public partial class ViewRefundNotifications : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate the notifications list
                LoadRefundNotifications();
            }
        }

        private void LoadRefundNotifications()
        {
            con.Open();
            string query = "select nt.notification_id, st.student_id,st.name,  nt.notification_type, nt.message, nt.created_at, pt.payment_id, pt.amount, pt.payment_status from payment_table pt inner join student_table st on pt.student_id = st.student_id inner join notification_table nt on nt.student_id = st.student_id where nt.notification_type='Refund' and pt.payment_status IN ('Refunded','Processing Refund') ORDER BY created_at DESC;";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                // Bind the DataTable to the Repeater
                RefundNotificationsRepeater.DataSource = dt;
                RefundNotificationsRepeater.DataBind();
            }
        }

        protected void btn_PayBack_Click(object sender, EventArgs e)
        {

            // Retrieve the payment_id and payment_amount from the data item
            Button btn = (Button)sender;
            HiddenField hfPaymentId = (HiddenField)btn.FindControl("hfPaymentId");
            int paymentId = Convert.ToInt32(hfPaymentId.Value);
            decimal paymentAmount=5000.00m;

            // Update the payment status to 'Refunded' and decrement the amount by 5000.00 in your database
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();

                // Update payment status
                SqlCommand cmdPaymentStatus = new SqlCommand("UPDATE payment_table SET payment_status = 'Refunded', refund_flag = 1 WHERE payment_id = @paymentId", con);
                cmdPaymentStatus.Parameters.AddWithValue("@paymentId", paymentId);
                cmdPaymentStatus.ExecuteNonQuery();

                // Decrement payment amount
                SqlCommand cmdPaymentAmount = new SqlCommand("UPDATE payment_table SET amount = amount - @paymentAmount WHERE payment_id = @paymentId", con);
                cmdPaymentAmount.Parameters.AddWithValue("@paymentId", paymentId);
                cmdPaymentAmount.Parameters.AddWithValue("@paymentAmount", paymentAmount);
                cmdPaymentAmount.ExecuteNonQuery();
            }

            // Disable the button and change its text to 'PAID'
            btn.Enabled = false;
            btn.Text = "PAID";
        }
    }
}