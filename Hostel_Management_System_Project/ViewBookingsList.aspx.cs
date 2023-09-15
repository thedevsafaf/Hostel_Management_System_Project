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
    public partial class ViewBookingsList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate attendance list
                PopulateBookingsList();
            }
        }
        private void PopulateBookingsList()
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                string student_id = Session["student_id"].ToString();
                SqlCommand cmd = new SqlCommand("select ROW_NUMBER() OVER (ORDER BY bt.booking_id) AS SerialNumber, bt.student_id, st.name as st_name, st.phone_number as st_phone, bt.booking_date, bt.status as booking_status, rf.room_id as room_id, rf.room_no as room_no, rf.room_desc as room_desc from booking_table bt inner join room_facilities rf on bt.room_id = rf.room_id inner join student_table st on st.student_id = bt.student_id;", con);
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
    }
}