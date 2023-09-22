using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class ProvideFeedback : System.Web.UI.Page
    {

        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack) { }
        }

        protected void btn_SubmitFeedback_Click(object sender, EventArgs e)
        {
            try
            {
                string feedbackText = tb_Feedback.Text.Trim();
                int studentId = Convert.ToInt32(Session["student_id"]); 

                // Insert feedback into the feedback_table
                con.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO feedback_table (student_id, feedback, created_at) VALUES (@studentId, @feedback, GETDATE())", con);
                cmd.Parameters.AddWithValue("@studentId", studentId);
                cmd.Parameters.AddWithValue("@feedback", feedbackText);
                cmd.ExecuteNonQuery();
                con.Close();

                // Redirect to a success page or show a success message
                //Response.Redirect("FeedbackSuccess.aspx");
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessAlert", "ShowSuccessAlert();", true);
            }
            catch (Exception ex)
            {
                // Handle any exceptions (e.g., database error)
                string errorMessage = ex.Message;
                // Show a SweetAlert for the error
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorAlert", "ShowErrorAlert('" + errorMessage + "');", true);
            }
        }

    }
}