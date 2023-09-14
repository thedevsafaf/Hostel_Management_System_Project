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
    public partial class SendNotifications : System.Web.UI.Page
    {
        private string connectionString = "Data Source=DESKTOP-JRHVVPL\\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Populate the dropdown list with student data
                PopulateRecipientDropdown();
            }
        }

        private void PopulateRecipientDropdown()
        {
            string query = "SELECT student_id, name FROM student_table";
            DataTable dt = ExecuteQuery(query);

            // Bind the data to the dropdown list
            ddl_Recipient.DataSource = dt;
            ddl_Recipient.DataTextField = "name";
            ddl_Recipient.DataValueField = "student_id";
            ddl_Recipient.DataBind();

            // Add a default "Select" option which is disabled to select
            ListItem selectItem = new ListItem("Select Any Student", "-1");
            selectItem.Attributes["disabled"] = "disabled"; // Add this line to disable the option
            ddl_Recipient.Items.Insert(0, selectItem);

            // Add a "Select All" option
            ddl_Recipient.Items.Insert(1, new ListItem("Select All", "-2"));

        }

        private DataTable ExecuteQuery(string query)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }

        protected void btn_SendNotification_Click(object sender, EventArgs e)
        {
            if (ddl_Recipient.SelectedValue != "-1")
            {
                int selectedStudentId = int.Parse(ddl_Recipient.SelectedValue);
                string message = tb_Message.Text;

                if (selectedStudentId == -2) // Check if "Select All" is selected
                {
                    // Send the notification to all students
                    SendNotificationToAllStudents(message);
                }
                else
                {
                    // Insert the notification into the database
                    SendNotificationToStudent(selectedStudentId, message);
                }
            }
            else
            {
                Response.Write("You cannot opt Select from DD!");
            }
        }

        private void SendNotificationToAllStudents(string message)
        {
            // Create a list to store all student IDs
            List<int> allStudentIds = new List<int>();

            // Retrieve all student IDs from the database
            string query = "SELECT student_id FROM student_table";
            DataTable dt = ExecuteQuery(query);

            foreach (DataRow row in dt.Rows)
            {
                int studentId = Convert.ToInt32(row["student_id"]);
                allStudentIds.Add(studentId);
            }

            // Send the notification to each student using the InsertNotification method
            foreach (int studentId in allStudentIds)
            {
                InsertNotification(studentId, message);
            }
        }



        //For sending to a specific student using selected student_id from DD
        private void SendNotificationToStudent(int studentId, string message)
        {
            // Implement the logic to send the notification to a specific student here
            // Use the studentId to send the notification to the selected student
            InsertNotification(studentId, message);
        }

        private void InsertNotification(int studentId, string message)
        {
            string query = "INSERT INTO notification_table (student_id, message, created_at) VALUES (@student_id, @message, GETDATE())";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@student_id", studentId);
                    cmd.Parameters.AddWithValue("@message", message);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }

}
   