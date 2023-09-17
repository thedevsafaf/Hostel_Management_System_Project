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
    public partial class S_ViewProfile : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate profile details
                PopulateProfileTableDetails();

                int loginID = Convert.ToInt32(Session["login_id"]);
                PopulateProfileCardDetails(loginID);
            }
        }
        private void PopulateProfileTableDetails()
        {
            int loginID = Convert.ToInt32(Session["login_id"]);
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT student_id, name, email, phone_number, status, created_at FROM student_table WHERE login_id = @login_id", con);
            cmd.Parameters.AddWithValue("@login_id", loginID);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            ProfileRepeater.DataSource = ds;
            ProfileRepeater.DataBind();
            con.Close();
        }

        protected void EditStudent_Click(object sender, EventArgs e)
        {
            int student_id = Convert.ToInt32((sender as Button).CommandArgument);
            Session["student_id"] = student_id;
            Response.Redirect("S_UpdateProfile.aspx");
        }

        private void PopulateProfileCardDetails(int loginID)
        {
            con.Open();
            // Fetch student other details
            SqlCommand cmd = new SqlCommand("SELECT student_table.student_id, student_table.name, student_table.email, student_table.phone_number, student_table.status, parent_table.name as pname, parent_table.email pemail, parent_table.phone_number as pphone from student_table inner join parent_table on student_table.student_id = parent_table.student_id where student_table.login_id = @login_id", con);
            cmd.Parameters.AddWithValue("@login_id", loginID);
            SqlDataReader studentReader = cmd.ExecuteReader();
            if (studentReader.Read())
            {
                // Populate student's parent details on the page
                lbl_ParentName.Text = studentReader["pname"].ToString();
                lbl_ParentEmail.Text = studentReader["pemail"].ToString();
                lbl_ParentPhone.Text = studentReader["pphone"].ToString();
            }
            else
            {
                // Handle the case when the profile is not found
                // For example, you can display an error message or redirect to an error page.
                //Response.Redirect("404.aspx");

                // Populate student's parent details on the page
                lbl_ParentName.Text = "NO DATA";
                lbl_ParentEmail.Text = "NO DATA";
                lbl_ParentPhone.Text = "NO DATA";
            }
        }

    }
}