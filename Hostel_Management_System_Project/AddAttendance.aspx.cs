using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class AddAttendance : System.Web.UI.Page
    {
        private string connectionString = "Data Source=DESKTOP-JRHVVPL\\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack) 
            {
                // Populate the dropdown list with student data
                PopulateStudentDropdown();
            }
        }

        private void PopulateStudentDropdown()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT student_id, name FROM student_table", con))
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        ddl_Student.DataSource = reader;
                        ddl_Student.DataTextField = "name";
                        ddl_Student.DataValueField = "student_id";
                        ddl_Student.DataBind();
                        ListItem selectItem = ddl_Student.Items.FindByValue("-1");
                        selectItem.Attributes["disabled"] = "disabled";
                        if (selectItem == null)
                        {
                            ddl_Student.Items.Insert(0, new ListItem("Select Student", "-1"));
                            
                        }
                        //ddl_Student.Items.Insert(0, new ListItem("Select Student", "-1"));
                        reader.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions as needed
                string errorMessage = ex.Message;
                Response.Write(errorMessage);
            }
        }

        protected void btn_AddAttendance_Click(object sender, EventArgs e)
        {
            try
            {
                int studentId = int.Parse(ddl_Student.SelectedValue);
                DateTime attendanceDate = DateTime.Parse(tb_AttendanceDate.Text);
                string attendanceStatus = ddl_AttendanceStatus.SelectedValue;

                // Insert the attendance record into the database
                InsertAttendance(studentId, attendanceDate, attendanceStatus);
            }
            catch (Exception ex)
            {
                // Handle exceptions as needed
                string errorMessage = ex.Message;
                Response.Write(errorMessage);
            }
        }

        private void InsertAttendance(int studentId, DateTime date, string status)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO attendance_table(student_id, date, status, created_at) VALUES (@student_id, @date, @status, GETDATE())", con))
                    {
                        cmd.Parameters.AddWithValue("@student_id", studentId);
                        cmd.Parameters.AddWithValue("@date", date);
                        cmd.Parameters.AddWithValue("@status", status);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions as needed
                string errorMessage = ex.Message;
                Response.Write(errorMessage);
            }
        }

    }
}