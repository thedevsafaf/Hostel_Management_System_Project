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
                string query = @"
                    SELECT
                        ROW_NUMBER() OVER (ORDER BY bt.booking_id) AS SerialNumber,
                        bt.student_id,
                        st.name AS st_name,
                        st.phone_number AS st_phone,
                        pt.name AS pt_name,
                        bt.booking_id as booking_id,
                        bt.booking_date,
                        bt.status AS booking_status,
                        rf.room_no AS room_no,
                        bt.booked_by
                    FROM
                        booking_table bt
                    INNER JOIN
                        room_facilities rf ON bt.room_id = rf.room_id
                    INNER JOIN
                        student_table st ON st.student_id = bt.student_id
                    INNER JOIN
                        parent_table pt ON pt.student_id = st.student_id;";
                SqlCommand cmd = new SqlCommand(query, con);
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