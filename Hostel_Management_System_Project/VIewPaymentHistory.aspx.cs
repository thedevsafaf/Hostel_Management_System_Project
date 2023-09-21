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
    public partial class VIewPaymentHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate attendance list
                PopulateAllPaymentHistoryList();
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

        private void PopulateAllPaymentHistoryList()
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                string query = @"
                        select 
                              ROW_NUMBER() OVER (ORDER BY pt.payment_id) AS sl_no,*,st.name as st_name, prt.name as prt_name 
                        from 
                              payment_table pt 
                        inner join 
                              booking_table bt on bt.payment_id = pt.payment_id 
                        inner join 
                              room_facilities rf on rf.room_id = bt.room_id 
                        inner join 
                              student_table st on st.student_id = pt.student_id 
                        inner join 
                              parent_table prt on prt.student_id = st.student_id;";
                SqlCommand cmd = new SqlCommand(query, con);
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