using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace Hostel_Management_System_Project
{
    public partial class ViewStudentsList : System.Web.UI.Page
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
            string query = "SELECT ROW_NUMBER() OVER (ORDER BY student_id) AS sl_no, student_id, login_id, name, email, phone_number, status, created_at FROM student_table where status in ('Approved', 'Pending', 'Rejected')";
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
        protected void FilterButton_Click(object sender, EventArgs e)
        {
            string selectedStatus = statusFilter.SelectedValue;
            BindStudentData(selectedStatus, searchInput.Text);
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            string selectedStatus = statusFilter.SelectedValue;
            string searchQuery = searchInput.Text;
            BindStudentData(selectedStatus, searchQuery);
        }

        private void BindStudentData(string selectedStatus, string searchQuery)
        {
            con.Open();
            string query = "SELECT student_id, login_id, name, email, phone_number, status, created_at FROM student_table WHERE 1=1 AND status IN ('Approved', 'Rejected', 'Pending')";

            // Add conditions based on the selected status and search query
            if (!string.IsNullOrEmpty(selectedStatus))
            {
                query += " AND status = @selectedStatus";
            }

            if (!string.IsNullOrEmpty(searchQuery))
            {
                query += " AND (name LIKE @searchQuery OR email LIKE @searchQuery OR phone_number LIKE @searchQuery)";
            }

            SqlCommand cmd = new SqlCommand(query, con);

            // Set parameters if needed (use SqlParameter to prevent SQL injection)
            if (!string.IsNullOrEmpty(selectedStatus))
            {
                cmd.Parameters.AddWithValue("@selectedStatus", selectedStatus);
            }

            if (!string.IsNullOrEmpty(searchQuery))
            {
                cmd.Parameters.AddWithValue("@searchQuery", "%" + searchQuery + "%");
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();

            if (dt.Rows.Count > 0)
            {
                StudentRepeater.DataSource = dt;
                StudentRepeater.DataBind();
                noResultsMessage.Visible = false; // Hide the no results message
            }
            else
            {
                StudentRepeater.DataSource = null; // Clear the repeater
                StudentRepeater.DataBind();
                noResultsMessage.Visible = true; // Show the no results message
            }
        }




        protected void EditStudent_Click(object sender, EventArgs e)
        {
            int student_id = Convert.ToInt32((sender as Button).CommandArgument);
            Session["student_id"] = student_id;
            Response.Redirect("UpdateStudent.aspx");
        }

        //button to delete function
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        [WebMethod]
        public static string DeleteStudent(int studentId)
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();

                // Implement your code to delete the student record here
                string updateStudentQuery = "UPDATE student_table SET status = 'Inactive' WHERE student_id = @student_id";
                SqlCommand cmd = new SqlCommand(updateStudentQuery, con);
                cmd.Parameters.AddWithValue("@student_id", studentId);
                int rowsAffected = cmd.ExecuteNonQuery();

                con.Close();

                if (rowsAffected > 0)
                {
                    return "success";
                }
                else
                {
                    return "error";
                }
            }
        }
    }
}