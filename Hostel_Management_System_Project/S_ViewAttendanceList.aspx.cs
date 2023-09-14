using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace Hostel_Management_System_Project
{
    public partial class S_ViewAttendanceList : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate attendance list
                PopulateAttendanceList();
            }
        }

        private void PopulateAttendanceList()
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                string student_id = Session["student_id"].ToString();
                SqlCommand cmd = new SqlCommand("select ROW_NUMBER() OVER (ORDER BY at.attendance_id) AS SerialNumber, at.student_id, st.name as st_name, at.date, at.status, at.created_at from attendance_table at inner join student_table st on st.student_id = at.student_id where st.student_id = @student_id", con);
                cmd.Parameters.AddWithValue("@student_id", student_id);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    // Bind the DataTable to the Repeater
                    AttendanceRepeater.DataSource = dt;
                    AttendanceRepeater.DataBind();
                    noResultsMessage.Visible = false;
                }
                else
                {
                    AttendanceRepeater.DataSource = null; // Clear the repeater
                    AttendanceRepeater.DataBind();
                    noResultsMessage.Visible = true;
                }
                    
            }
        }

        protected void FilterButton_Click(object sender, EventArgs e)
        {
            string selectedStatus = statusFilter.SelectedValue;
            BindStudentAttendanceData(selectedStatus);
        }

        private void BindStudentAttendanceData(string selectedStatus)
        {
            con.Open();
            string student_id = Session["student_id"].ToString();
            string query = "SELECT ROW_NUMBER() OVER (ORDER BY at.attendance_id) AS SerialNumber, at.student_id, st.name as st_name, at.date, at.status, at.created_at from attendance_table at inner join student_table st on st.student_id = at.student_id WHERE 1=1 AND st.student_id = @student_id";

            // Add conditions based on the selected status and search query
            if (!string.IsNullOrEmpty(selectedStatus))
            {
                query += " AND at.status = @selectedStatus";
            }

            SqlCommand cmd = new SqlCommand(query, con);

            // Set parameters if needed (use SqlParameter to prevent SQL injection)
            if (!string.IsNullOrEmpty(selectedStatus))
            {
                cmd.Parameters.AddWithValue("@selectedStatus", selectedStatus);
            }
            cmd.Parameters.AddWithValue("@student_id", student_id);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();

            if (dt.Rows.Count > 0)
            {
                AttendanceRepeater.DataSource = dt;
                AttendanceRepeater.DataBind();
                noResultsMessage.Visible = false; // Hide the no results message
            }
            else
            {
                AttendanceRepeater.DataSource = null; // Clear the repeater
                AttendanceRepeater.DataBind();
                noResultsMessage.Visible = true; // Show the no results message
            }

        }
    }
}