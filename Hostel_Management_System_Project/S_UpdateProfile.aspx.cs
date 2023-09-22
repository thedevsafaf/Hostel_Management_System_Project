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
    public partial class S_UpdateProfile : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            //loading already registered data for updation
            if (!IsPostBack)
            {
                con.Open();
                string student_id = Session["student_id"].ToString();
                SqlCommand cmd = new SqlCommand("sp_students_list", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@student_id", student_id);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    tb_Name.Text = dt.Rows[0][2].ToString();
                    tb_Email.Text = dt.Rows[0][3].ToString();
                    tb_Phone.Text = dt.Rows[0][4].ToString();
                    tb_Password.Text = dt.Rows[0][6].ToString();
                }
                con.Close();
            }
        }

        void clear()
        {
            tb_Name.Text = "";
            tb_Email.Text = "";
            tb_Phone.Text = "";
            tb_Password.Text = "";
            tb_ConfirmPassword.Text = "";
        }

        protected void btn_Update_Click(object sender, EventArgs e)
        {
            try
            {
                //string student_id = Session["student_id"].ToString(); OR
                int studentId = int.Parse(Session["student_id"].ToString());

                con.Open();

                // Update student details in student_table
                SqlCommand cmdUpdateStudent = new SqlCommand("sp_update_student_table", con);
                cmdUpdateStudent.CommandType = CommandType.StoredProcedure;
                cmdUpdateStudent.Parameters.AddWithValue("@student_id", studentId);
                cmdUpdateStudent.Parameters.AddWithValue("@name", tb_Name.Text);
                cmdUpdateStudent.Parameters.AddWithValue("@email", tb_Email.Text);
                cmdUpdateStudent.Parameters.AddWithValue("@phone_number", tb_Phone.Text);
                cmdUpdateStudent.ExecuteNonQuery();


                // Update login details in login_table
                SqlCommand cmdUpdateLogin = new SqlCommand("sp_update_student_login_table", con);
                cmdUpdateLogin.CommandType = CommandType.StoredProcedure;
                cmdUpdateLogin.Parameters.AddWithValue("@student_id", studentId); // Pass student_id to the stored procedure
                cmdUpdateLogin.Parameters.AddWithValue("@username", tb_Email.Text);
                cmdUpdateLogin.Parameters.AddWithValue("@password", tb_Password.Text);
                cmdUpdateLogin.ExecuteNonQuery();

                clear();

                con.Close();

                //remove this when setting swal
                //  Response.Redirect("S_ViewProfile.aspx");
                // Show a SweetAlert for successful updation
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessAlert", "ShowSuccessAlert();", true);
            }
            catch (Exception exc)
            {
                // Get the error message from the exception
                string errorMessage = exc.Message;

                // You can also show a SweetAlert for the failed updation
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorAlert", "ShowErrorAlert('" + errorMessage + "');", true);
            }

        }


    }
}