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
    public partial class RoomRegister : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { }
        }

        protected void btn_Register_Click(object sender, EventArgs e)
        {
           
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_insert_room_facility", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@room_no", tb_RoomNo.Text);
                cmd.Parameters.AddWithValue("@room_desc", tb_RoomDesc.Text);
                cmd.Parameters.AddWithValue("@room_status", ddl_RoomStatus.SelectedValue);
                cmd.ExecuteNonQuery();

                con.Close();

                // Show a SweetAlert for successful room registration
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessAlert", "ShowSuccessAlert();", true);

            }
            // Handle any exception that occurred during room registration
            catch (Exception exc)
            {
                // Get the error message from the exception
                string errorMessage = exc.Message;
                // Show a SweetAlert for the error
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorAlert", "ShowErrorAlert('" + errorMessage + "');", true);
            }

        }
           
    }


}
