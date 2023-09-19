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
    public partial class ViewParentRefundNotifications : System.Web.UI.Page
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
            string query = "SELECT nt.notification_id, st.student_id, st.name, nt.notification_type, nt.message, nt.created_at, pt.payment_id, pt.amount, pt.payment_status FROM payment_table pt INNER JOIN student_table st ON pt.student_id = st.student_id INNER JOIN notification_table nt ON nt.student_id = st.student_id inner join parent_table prt on prt.student_id = st.student_id WHERE nt.notification_type = 'P_Refund_Req' AND pt.payment_status IN ('Refunded', 'Processing Refund') AND pt.paid_by = 'Parent'  ORDER BY created_at DESC;";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                // Bind the DataTable to the Repeater
                ParentRefundNotificationsRepeater.DataSource = dt;
                ParentRefundNotificationsRepeater.DataBind();
            }
        }

        protected void btn_PayBack_Click(object sender, EventArgs e)
        {

            // Retrieve the payment_id and payment_amount from the data item
            Button btn = (Button)sender;
            HiddenField hfPaymentId = (HiddenField)btn.FindControl("hfPaymentId");
            int paymentId = Convert.ToInt32(hfPaymentId.Value);
            decimal paymentAmount = 5000.00m;

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