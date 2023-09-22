using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class ComplaintReply : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            //loading already complaint data for reply
            if (!IsPostBack)
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_reply_complaint", con);
                cmd.CommandType = CommandType.StoredProcedure;
                string complaint_id = Session["complaint_id"].ToString();
                cmd.Parameters.AddWithValue("@complaint_id", complaint_id);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    // Populate complaint details
                    tb_ComplaintID.Text = dt.Rows[0]["complaint_id"].ToString();
                    tb_StudentName.Text = dt.Rows[0]["st_name"].ToString();
                    tb_StudentPhone.Text = dt.Rows[0]["st_phone"].ToString();
                    ddl_Status.SelectedValue = dt.Rows[0]["complaint_status"].ToString();
                    tb_Complaint.Text = dt.Rows[0]["complaint"].ToString();

                    // Populate existing admin reply (if available)
                    string adminReply = dt.Rows[0]["reply"].ToString();
                    tb_AdminReply.Text = adminReply;
                }
                con.Close();
            }
        }

      

        protected void btnSendReply_Click(object sender, EventArgs e)
        {
            try
            {
                // Get the complaint ID from the session or your control, e.g., tb_ComplaintID
                int complaintId = int.Parse(tb_ComplaintID.Text);


                con.Open();
                SqlCommand cmd = new SqlCommand("UPDATE complaint_table SET status = @status, reply = @adminReply WHERE complaint_id = @complaintId", con);
                cmd.Parameters.AddWithValue("@status", ddl_Status.SelectedValue);
                cmd.Parameters.AddWithValue("@adminReply", tb_AdminReply.Text);
                cmd.Parameters.AddWithValue("@complaintId", complaintId);
                int rowsAffected = cmd.ExecuteNonQuery();
                con.Close();

                if (rowsAffected > 0)
                {
                    // Update successful, you can show a success message or redirect to a confirmation page
                    //Response.Write("Reply sent successfully!");
                    //SuccessReplyMessage.Visible = true;
                    //Response.Redirect("ViewComplaintsList.aspx");
                    // Show a SweetAlert for successful room registration
                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessAlert", "ShowSuccessAlert();", true);
                }
                else
                {
                    // No rows were updated, handle this as needed (display an error message)
                    //Response.Write("Error updating reply.");
                    FailedReplyMessage.Visible = true;
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions that occur during the update
                string errorMessage = ex.Message;
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorAlert", "ShowErrorAlert('" + errorMessage + "');", true);

            }
        }
    }
}