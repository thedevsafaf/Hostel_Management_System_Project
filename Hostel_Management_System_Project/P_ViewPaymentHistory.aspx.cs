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
    public partial class P_ViewPaymentHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate attendance list
                PopulateMyPaymentHistoryList();
            }
        }

        protected string GetStatusCssClass(string status)
        {
            switch (status)
            {
                case "Paid":
                    return "status-paid";
                case "Cancelled":
                    return "status-cancelled";
                case "Processing Refund":
                    return "status-processing-refund";
                case "Refunded":
                    return "status-refunded";
                default:
                    return string.Empty; // No specific class for other values
            }
        }

        private void PopulateMyPaymentHistoryList()
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                string parent_id = Session["parent_id"].ToString();
                SqlCommand cmd = new SqlCommand("select ROW_NUMBER() OVER (ORDER BY bt.booking_id) AS SerialNumber, bt.booking_id, bt.student_id, prt.parent_id, prt.name as prt_name, bt.booking_date,bt.status as booking_status, rf.room_id as booked_room_id, rf.room_no as booked_room_no, rf.room_desc, rf.room_status,bt.payment_id as payment_id, pt.amount as amount, pt.payment_date as payment_date, pt.payment_status from booking_table bt inner join room_facilities rf on bt.room_id = rf.room_id inner join payment_table pt on bt.payment_id = pt.payment_id inner join parent_table prt on prt.student_id = bt.student_id where prt.parent_id = @parent_id", con);
                cmd.Parameters.AddWithValue("@parent_id", parent_id);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    // Bind the DataTable to the Repeater
                    PaymentRepeater.DataSource = dt;
                    PaymentRepeater.DataBind();
                    noResultsMessage.Visible = false;
                }
                else
                {
                    PaymentRepeater.DataSource = null; // Clear the repeater
                    PaymentRepeater.DataBind();
                    noResultsMessage.Visible = true;
                }

            }
        }
    }
}