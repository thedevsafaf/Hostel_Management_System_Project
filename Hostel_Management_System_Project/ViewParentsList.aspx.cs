using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace Hostel_Management_System_Project
{
    public partial class ViewParentsList : System.Web.UI.Page
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
            string query = "SELECT parent_table.parent_id, parent_table.login_id, parent_table.name, parent_table.email, parent_table.phone_number, parent_table.student_id, student_table.name as student_name, parent_table.status, parent_table.created_at FROM parent_table inner join student_table on student_table.student_id = parent_table.student_id where parent_table.status in ('Approved', 'Pending', 'Rejected')"; ;
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

        protected void FilterButton_Click(object sender, EventArgs e)
        {
            string selectedStatus = statusFilter.SelectedValue;
            BindParentData(selectedStatus, searchInput.Text);
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            string selectedStatus = statusFilter.SelectedValue;
            string searchQuery = searchInput.Text;
            BindParentData(selectedStatus, searchQuery);
        }

        private void BindParentData(string selectedStatus, string searchQuery)
        {
            con.Open();
            string query = "SELECT parent_table.parent_id, parent_table.login_id, parent_table.name, parent_table.email, parent_table.phone_number, parent_table.student_id, student_table.name as student_name, parent_table.status, parent_table.created_at FROM parent_table inner join student_table on student_table.student_id = parent_table.student_id WHERE 1=1 AND parent_table.status IN ('Approved', 'Rejected', 'Pending')";

            // Add conditions based on the selected status and search query
            if (!string.IsNullOrEmpty(selectedStatus))
            {
                query += " AND parent_table.status = @selectedStatus";
            }

            if (!string.IsNullOrEmpty(searchQuery))
            {
                query += " AND (parent_table.name LIKE @searchQuery OR parent_table.email LIKE @searchQuery OR parent_table.phone_number LIKE @searchQuery OR student_table.name LIKE @searchQuery)";
            }

            SqlCommand cmd = new SqlCommand(query, con);

            // Set parameters if needed (use SqlParameter to prevent SQL injection)
            if (!string.IsNullOrEmpty(selectedStatus))
            {
                cmd.Parameters.AddWithValue("@selectedStatus", selectedStatus);
            }

            if (!string.IsNullOrEmpty(searchQuery))
            {
                cmd.Parameters.AddWithValue("@searchQuery", "%" + searchQuery + "%");
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();

            if (dt.Rows.Count > 0)
            {
                ParentRepeater.DataSource = dt;
                ParentRepeater.DataBind();
                noResultsMessage.Visible = false; // Hide the no results message
            }
            else
            {
                ParentRepeater.DataSource = null; // Clear the repeater
                ParentRepeater.DataBind();
                noResultsMessage.Visible = true; // Show the no results message
            }
        }



        protected void EditParent_Click(object sender, EventArgs e)
        {
            int parent_id = Convert.ToInt32((sender as Button).CommandArgument);
            Session["parent_id"] = parent_id;
            Response.Redirect("UpdateParent.aspx");
        }

        //for delete button action
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        [WebMethod]
        public static string DeleteParent(int parentId)
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();

                // Update the status of the parent to "inactive" instead of deleting the record
                string updateParentQuery = "update parent_table set status = 'Inactive' where parent_id = @parent_id";
                SqlCommand cmd = new SqlCommand(updateParentQuery, con);
                cmd.Parameters.AddWithValue("@parent_id", parentId);
                int rowsAffected = cmd.ExecuteNonQuery();

                con.Close();

                if (rowsAffected > 0)
                {
                    return "success";
                }
                else
                {
                    return "error";
                }
            }
        }



    }
}