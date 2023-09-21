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
    public partial class ApprovalStudentsList : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                DisplayStudentsList();
            }
        }

        protected string GetStatusCssClass(string status)
        {
            switch (status)
            {
                case "Approved":
                    return "status-approved";
                case "Rejected":
                    return "status-rejected";
                case "Pending":
                    return "status-pending";
                case "Inactive":
                    return "status-inactive";
                default:
                    return string.Empty; // No specific class for other values
            }
        }

        void DisplayStudentsList()
        {
            con.Open();
            string query = @"
                SELECT 
                    ROW_NUMBER() OVER (ORDER BY student_id) AS sl_no, student_id, login_id, name, email, phone_number, status, created_at 
                FROM 
                    student_table 
                WHERE 
                    status in ('Approved', 'Pending', 'Rejected')";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                StudentRepeater.DataSource = dt;
                StudentRepeater.DataBind();
            }
            else
            {
                Response.Write("No data found!");
            }
        }

        private void UpdateStudentStatus(int student_id, string newStatus)
        {
            con.Open();
            string query = "update student_table set status = @newStatus where student_id = @student_id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@newStatus", newStatus);
            cmd.Parameters.AddWithValue("@student_id", student_id);
            cmd.ExecuteNonQuery();
            con.Close();

        }

        protected void btn_Approve_Click(object sender, EventArgs e)
        {
            int student_id = Convert.ToInt32((sender as Button).CommandArgument);

            // Check the current status of the student
            string currentStatus = GetStudentStatus(student_id);

            // If the current status is not "Approved," update it to "Approved"
            if (currentStatus != "Approved")
            {
                UpdateStudentStatus(student_id, "Approved");
            }

            // Reload the student data
            DisplayStudentsList();
        }

        protected void btn_Reject_Click(object sender, EventArgs e)
        {
            int student_id = Convert.ToInt32((sender as Button).CommandArgument);

            // Check the current status of the student
            string currentStatus = GetStudentStatus(student_id);

            // If the current status is not "Rejected," update it to "Rejected"
            if (currentStatus != "Rejected")
            {
                UpdateStudentStatus(student_id, "Rejected");
            }

            // Reload the student data
            DisplayStudentsList();
        }

        private string GetStudentStatus(int student_id)
        {
            string status = string.Empty;
            con.Open();
            string query = "SELECT status FROM student_table WHERE student_id = @student_id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@student_id", student_id);

            // Execute the query and retrieve the status
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                status = reader["status"].ToString();
            }
            con.Close();
            return status;

        }

        //protected void btn_Approve_Click(object sender, EventArgs e)
        //{
        //    int student_id = Convert.ToInt32((sender as Button).CommandArgument);

        //    // Update the student's status to "Approved" in the database
        //    UpdateStudentStatus(student_id, "Approved");
        //    // Reload the student data
        //    DisplayStudentsList();
        //}

        //protected void btn_Reject_Click(object sender, EventArgs e)
        //{
        //    int student_id = Convert.ToInt32((sender as Button).CommandArgument);
        //    // Update the student's status to "Approved" in the database
        //    UpdateStudentStatus(student_id, "Rejected");
        //    // Reload the student data
        //    DisplayStudentsList();
        //}

    }
}