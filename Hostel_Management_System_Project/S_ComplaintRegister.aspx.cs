using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class S_ComplaintRegister : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { }
        }

        private void InsertComplaint(int studentId, string complaintText)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("INSERT INTO complaint_table(student_id, complaint, created_at, status, complaint_type) VALUES (@student_id, @complaint, GETDATE(), @status, @complaint_type)", con);
            cmd.Parameters.AddWithValue("@student_id", studentId);
            cmd.Parameters.AddWithValue("@complaint", complaintText);
            cmd.Parameters.AddWithValue("@status", "Pending");
            cmd.Parameters.AddWithValue("@complaint_type", "Student");
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void btn_RegisterComplaint_Click(object sender, EventArgs e)
        {
            // Check if the student is logged in 
            if (Session["student_id"] != null)
            {
                int studentId = Convert.ToInt32(Session["student_id"]);
                string complaintText = tb_Complaint.Text;

                // Insert the complaint into the complaint_table
                InsertComplaint(studentId, complaintText);

                // Clear the complaint textbox
                tb_Complaint.Text = "";

                // Show a success message or redirect to a success page
                // You can use SweetAlert or any other method you prefer
                //ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessAlert", "ShowSuccessAlert();", true);
                Response.Redirect("StudentDashboard.aspx");
            }
            else
            {
                // Handle the case where the student is not logged in
                // You can redirect them to the login page or display an error message
                Response.Redirect("Login.aspx");
            }
        }
    }
}