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
    public partial class P_ComplaintRegister : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { }

            FetchStudentID();
        }

        private void FetchStudentID()
        {
            con.Open();
            int parentID = Convert.ToInt32(Session["parent_id"]);
            SqlCommand cmd = new SqlCommand("select pt.student_id,st.name as student_name from parent_table pt inner join student_table st on st.student_id = pt.student_id where parent_id = @parent_id", con);
            cmd.Parameters.AddWithValue("@parent_id", parentID);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            con.Close();
            if(dt.Rows.Count > 0) 
            {
                tb_StudentID.Text = dt.Rows[0]["student_id"].ToString();
                tb_StudentName.Text = dt.Rows[0]["student_name"].ToString();
            }
        }

        private void InsertParentComplaint(string complaintText)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("INSERT INTO complaint_table(student_id, complaint, created_at, status, complaint_type) VALUES (@student_id, @complaint, GETDATE(), @status, @complaint_type)", con);
            cmd.Parameters.AddWithValue("@student_id", tb_StudentID.Text);
            cmd.Parameters.AddWithValue("@complaint", complaintText);
            cmd.Parameters.AddWithValue("@status", "Pending");
            cmd.Parameters.AddWithValue("@complaint_type", "Parent");
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void btn_RegisterComplaint_Click(object sender, EventArgs e)
        {
            string complaintText = tb_Complaint.Text;

            // Insert the complaint into the complaint_table
            InsertParentComplaint(complaintText);

            // Clear the complaint textbox
            tb_Complaint.Text = "";

            // Show a success message or redirect to a success page
            // You can use SweetAlert or any other method you prefer
            //ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessAlert", "ShowSuccessAlert();", true);
            Response.Redirect("ParentDashboard.aspx");
        }
    }
}