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
    public partial class P_ViewMyBooking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate attendance list
                PopulateMyBookingList();
            }
        }

        protected string GetStatusCssClass(string status)
        {
            switch (status)
            {
                case "Confirmed":
                    return "status-confirmed";
                case "Cancelled":
                    return "status-cancelled";
                case "Pending":
                    return "status-pending";
                case "Auto Cancelled":
                    return "status-auto-cancelled";
                case "Cancelled by Admin":
                    return "status-admin-cancelled";
                default:
                    return string.Empty; // No specific class for other values
            }
        }

        private void PopulateMyBookingList()
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                string parent_id = Session["parent_id"].ToString();
                SqlCommand cmd = new SqlCommand("select ROW_NUMBER() OVER (ORDER BY bt.booking_id) AS SerialNumber, bt.booking_id, bt.student_id, pt.parent_id, pt.name as pt_name, bt.booking_date, bt.status as booking_status, rf.room_id, rf.room_no, rf.room_desc from booking_table bt left join room_facilities rf on bt.room_id = rf.room_id inner join parent_table pt on pt.student_id = bt.student_id where pt.parent_id = @parent_id;", con);
                cmd.Parameters.AddWithValue("@parent_id", parent_id);
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
    }
}