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
    public partial class ApprovalParentsList : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                DisplayParentsList();
            }
        }

        protected string GetStatusCssClass(string status)
        {
            switch (status)
            {
                case "Approved":
                    return "status-approved";
                case "Rejected":
                    return "status-rejected";
                case "Pending":
                    return "status-pending";
                case "Inactive":
                    return "status-inactive";
                default:
                    return string.Empty; // No specific class for other values
            }
        }

        void DisplayParentsList()
        {
            con.Open();
            string query = "SELECT parent_table.parent_id, parent_table.login_id, parent_table.name, parent_table.email, parent_table.phone_number, parent_table.student_id, student_table.name as student_name, parent_table.status, parent_table.created_at FROM parent_table inner join student_table on student_table.student_id = parent_table.student_id where parent_table.status in ('Approved', 'Pending', 'Rejected')";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                ParentRepeater.DataSource = dt;
                ParentRepeater.DataBind();
            }
            else
            {
                Response.Write("No data found!");
            }
        }

        private void UpdateParentStatus(int parent_id, string newStatus)
        {
            con.Open();
            string query = "update parent_table set status = @newStatus where parent_id = @parent_id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@newStatus", newStatus);
            cmd.Parameters.AddWithValue("@parent_id", parent_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void btn_Approve_Click(object sender, EventArgs e)
        {
            int parent_id = Convert.ToInt32((sender as Button).CommandArgument);

            // Check the current status of the parent
            string currentStatus = GetParentStatus(parent_id);

            // If the current status is not "Approved," update it to "Approved"
            if (currentStatus != "Approved")
            {
                UpdateParentStatus(parent_id, "Approved");
            }

            // Reload the parent data
            DisplayParentsList();
        }

        protected void btn_Reject_Click(object sender, EventArgs e)
        {
            int parent_id = Convert.ToInt32((sender as Button).CommandArgument);

            // Check the current status of the parent
            string currentStatus = GetParentStatus(parent_id);

            // If the current status is not "Rejected," update it to "Rejected"
            if (currentStatus != "Rejected")
            {
                UpdateParentStatus(parent_id, "Rejected");
            }

            // Reload the parent data
            DisplayParentsList();
        }

        private string GetParentStatus(int parent_id)
        {
            string status = string.Empty;
            con.Open();
            string query = "SELECT status FROM parent_table WHERE parent_id = @parent_id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@parent_id", parent_id);

            // Execute the query and retrieve the status
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                status = reader["status"].ToString();
            }
            con.Close();
            return status;
        }
    }
}