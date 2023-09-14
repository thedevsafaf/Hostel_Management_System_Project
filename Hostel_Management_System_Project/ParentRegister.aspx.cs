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
    public partial class ParentRegister : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { }
        }

        void clear()
        {
            tb_Name.Text = "";
            tb_Email.Text = "";
            tb_Phone.Text = "";
            tb_StudentID.Text = "";
            tb_Password.Text = "";
            tb_ConfirmPassword.Text = "";
        }

        protected void btn_Signup_Click(object sender, EventArgs e)
        {
            con.Open();

            try
            {
                // Execute the stored procedure to insert the parent into login_table
                SqlCommand cmd1 = new SqlCommand("sp_insert_parent_login_table", con);
                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Parameters.AddWithValue("@username", tb_Email.Text);
                cmd1.Parameters.AddWithValue("@password", tb_Password.Text);
                cmd1.ExecuteNonQuery();

                // Now, query for the login_id based on the inserted username (email)
                SqlCommand cmdGetLoginID = new SqlCommand("SELECT login_id FROM login_table WHERE username = @username", con);
                cmdGetLoginID.Parameters.AddWithValue("@username", tb_Email.Text);
                int loginID = Convert.ToInt32(cmdGetLoginID.ExecuteScalar());

                SqlCommand cmd2 = new SqlCommand("sp_parent_table_registration", con);
                cmd2.CommandType = CommandType.StoredProcedure;
                cmd2.Parameters.AddWithValue("@login_id", loginID);
                cmd2.Parameters.AddWithValue("@name", tb_Name.Text);
                cmd2.Parameters.AddWithValue("@email", tb_Email.Text);
                cmd2.Parameters.AddWithValue("@phone_number", tb_Phone.Text);
                cmd2.Parameters.AddWithValue("@student_id", Convert.ToInt32(tb_StudentID.Text));
                cmd2.Parameters.AddWithValue("@status", "Pending"); // Set the initial status as "PENDING"
                cmd2.Parameters.AddWithValue("@created_at", DateTime.Now);
                cmd2.ExecuteNonQuery();

                con.Close();

                clear();


                // Show a SweetAlert for successful registration
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessAlert", "ShowSuccessAlert();", true);


            }
            catch(Exception exc)
            {
                // Get the error message from the exception
                string errorMessage = exc.Message;

                // You can also show a SweetAlert for the failed registration
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorAlert", "ShowErrorAlert('" + errorMessage + "');", true);
            }
            
           
        }
    }
}