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
    public partial class HostelStaffRegister : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { }
        }

        void clear()
        {
            tb_Name.Text = "";
            ddl_StaffRole.SelectedValue = string.Empty;
            tb_Email.Text = "";
            tb_Phone.Text = "";
        }

        protected void btn_Register_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("insert into staff_table(staff_name, staff_role, staff_email, staff_phone_number, created_at) VALUES (@name, @role, @email, @phone_number, GETDATE());", con);
                cmd.Parameters.AddWithValue("@name", tb_Name.Text);
                cmd.Parameters.AddWithValue("@role", ddl_StaffRole.SelectedValue);
                cmd.Parameters.AddWithValue("@email", tb_Email.Text);
                cmd.Parameters.AddWithValue("@phone_number", tb_Phone.Text);
                cmd.ExecuteNonQuery();

                con.Close();

                clear();

                // Show a SweetAlert for successful registration
                //ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessAlert", "ShowSuccessAlert();", true);
                Response.Redirect("ViewStaffsList.aspx");

            }
            catch (Exception exc)
            {
                // Get the error message from the exception
                string errorMessage = exc.Message;
                Response.Write(errorMessage);

                // You can also show a SweetAlert for the failed registration
                //ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorAlert", "ShowErrorAlert('" + errorMessage + "');", true);
            }
        }
    }
}