using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class P_ViewProfile : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                int loginID = Convert.ToInt32(Session["login_id"]);
                PopulateProfileCardDetails(loginID);
            }
        }

        private void PopulateProfileCardDetails(int loginID)
        {
            con.Open();
            // Fetch parent details
            SqlCommand cmd = new SqlCommand("SELECT pt.parent_id, pt.login_id, pt.name, pt.email, pt.phone_number, pt.created_at, pt.student_id as st_id, st.name as st_name, st.email as st_email, st.phone_number as st_phone_number from parent_table pt inner join student_table st on st.student_id = pt.student_id where pt.login_id = @login_id", con);
            cmd.Parameters.AddWithValue("@login_id", loginID);
            SqlDataReader parentReader = cmd.ExecuteReader();
            if (parentReader.Read())
            {
                // Populate student's parent details on the page
                lbl_ParentName.Text = parentReader["name"].ToString();
                lbl_ParentEmail.Text = parentReader["email"].ToString();
                lbl_ParentPhone.Text = parentReader["phone_number"].ToString();
                lbl_CreatedAt.Text = parentReader["created_at"].ToString();
                lbl_StudentID.Text = parentReader["st_id"].ToString();
                lbl_StudentName.Text = parentReader["st_name"].ToString();
                lbl_StudentEmail.Text = parentReader["st_email"].ToString();
                lbl_StudentPhone.Text = parentReader["st_phone_number"].ToString();
            }
            else
            {
                // Handle the case when the profile is not found
                // For example, you can display an error message or redirect to an error page.
                Response.Redirect("404.aspx");
            }
        }
    }
}