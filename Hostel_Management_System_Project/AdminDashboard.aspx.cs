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
    public partial class AdminDashboard : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the SweetAlert has already been shown
                if (Session["SweetAlertShown"] == null)
                {
                    // After successful login, get the user's full name (e.g., fullName) and show SweetAlert
                    string script = @"
                    <script type='text/javascript'>
                        Swal.fire({
                            icon: 'success',
                            title: 'Login Successful',
                            text: 'Welcome, " + Session["name"] + @"!',
                            showConfirmButton: false,
                            timer: 2000
                        });
                    </script>";

                    ClientScript.RegisterStartupScript(this.GetType(), "ShowSuccessAlert", script);

                    // Set the session variable to indicate that the SweetAlert has been shown
                    Session["SweetAlertShown"] = true;
                }


                // Get and display counts for each student status
                int rejectedStudentCount = GetRejectedStudentCount();
                lblRejectedStudentCount.Text = rejectedStudentCount.ToString();

                int approvedStudentCount = GetApprovedStudentCount();
                lblApprovedStudentCount.Text = approvedStudentCount.ToString();

                int pendingStudentCount = GetPendingStudentCount();
                lblPendingStudentCount.Text = pendingStudentCount.ToString();

                int inactiveStudentCount = GetInactiveStudentCount();
                lblInactiveStudentCount.Text = inactiveStudentCount.ToString();

                // Get and display counts for each parent status
                int rejectedParentCount = GetRejectedParentCount();
                lblRejectedParentCount.Text = rejectedParentCount.ToString();

                int approvedParentCount = GetApprovedParentCount();
                lblApprovedParentCount.Text = approvedParentCount.ToString();

                int pendingParentCount = GetPendingParentCount();
                lblPendingParentCount.Text = pendingParentCount.ToString();

                int inactiveParentCount = GetInactiveParentCount();
                lblInactiveParentCount.Text = inactiveParentCount.ToString();

                // Get and display counts for each room status
                int vacantRoomCount = GetVacantRoomCount();
                lblVacantRoomCount.Text = vacantRoomCount.ToString();

                int occupiedRoomCount = GetOccupiedRoomCount();
                lblOccupiedRoomCount.Text = occupiedRoomCount.ToString();

                int maintenanceRoomCount = GetMaintenanceRoomCount();
                lblMaintenanceRoomCount.Text = maintenanceRoomCount.ToString();

                int inactiveRoomCount = GetInactiveRoomCount();
                lblInactiveRoomCount.Text = inactiveRoomCount.ToString();

                DisplayStudentsList();
                DisplayParentsList();
                DisplayRoomFacilitiesList();
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

        protected string GetRoomStatusCssClass(string status)
        {
            switch (status)
            {
                case "Vacant":
                    return "status-vacant";
                case "Occupied":
                    return "status-occupied";
                case "Under Maintenance":
                    return "status-maintenance";
                case "Inactive":
                    return "status-inactive";
                default:
                    return string.Empty; // No specific class for other values
            }
        }

        void DisplayStudentsList()
        {
            con.Open();
            string query = "SELECT student_id, login_id, name, email, phone_number, status, created_at FROM student_table";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                StudentRepeater.DataSource = dt;
                StudentRepeater.DataBind();
            }
            else
            {
                Response.Write("No data found!");
            }
        }

        void DisplayParentsList()
        {
            con.Open();
            string query = "SELECT parent_table.parent_id, parent_table.login_id, parent_table.name, parent_table.email, parent_table.phone_number, parent_table.student_id, student_table.name as student_name, parent_table.status, parent_table.created_at FROM parent_table inner join student_table on student_table.student_id = parent_table.student_id;";
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

        void DisplayRoomFacilitiesList()
        {
            con.Open();
            string query = "SELECT * FROM room_facilities";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                RoomRepeater.DataSource = dt;
                RoomRepeater.DataBind();
            }
            else
            {
                Response.Write("No data found!");
            }
        }

        //Functions for Student Statistics

        private int GetPendingStudentCount()
        {
            int count = 0;
            con.Open();
            string query = "SELECT COUNT(*) AS count FROM student_table WHERE status = 'Pending'";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                count = Convert.ToInt32(reader["count"]);
            }
            con.Close();
            return count;
        }

        private int GetInactiveStudentCount()
        {
            int count = 0;
            con.Open();
            string query = "SELECT COUNT(*) AS count FROM student_table WHERE status = 'Inactive'";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                count = Convert.ToInt32(reader["count"]);
            }
            con.Close();
            return count;
        }

        private int GetApprovedStudentCount()
        {
            int count = 0;
            con.Open();
            string query = "SELECT COUNT(*) AS count FROM student_table WHERE status = 'Approved'";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                count = Convert.ToInt32(reader["count"]);
            }
            con.Close();
            return count;
        }

        private int GetRejectedStudentCount()
        {
            int count = 0;
            con.Open();
            string query = "SELECT COUNT(*) AS count FROM student_table WHERE status = 'Rejected'";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                count = Convert.ToInt32(reader["count"]);
            }
            con.Close();
            return count;
        }

        //Functions for Parent Statistics

        private int GetPendingParentCount()
        {
            int count = 0;
            con.Open();
            string query = "SELECT COUNT(*) AS count FROM parent_table WHERE status = 'Pending'";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                count = Convert.ToInt32(reader["count"]);
            }
            con.Close();
            return count;
        }

        private int GetInactiveParentCount()
        {
            int count = 0;
            con.Open();
            string query = "SELECT COUNT(*) AS count FROM parent_table WHERE status = 'Inactive'";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                count = Convert.ToInt32(reader["count"]);
            }
            con.Close();
            return count;
        }

        private int GetApprovedParentCount()
        {
            int count = 0;
            con.Open();
            string query = "SELECT COUNT(*) AS count FROM parent_table WHERE status = 'Approved'";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                count = Convert.ToInt32(reader["count"]);
            }
            con.Close();
            return count;
        }

        private int GetRejectedParentCount()
        {
            int count = 0;
            con.Open();
            string query = "SELECT COUNT(*) AS count FROM parent_table WHERE status = 'Rejected'";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                count = Convert.ToInt32(reader["count"]);
            }
            con.Close();
            return count;
        }

        //Functions for Room Statistics

        private int GetVacantRoomCount()
        {
            int count = 0;
            con.Open();
            string query = "SELECT COUNT(*) AS count FROM room_facilities WHERE room_status = 'Vacant'";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                count = Convert.ToInt32(reader["count"]);
            }
            con.Close();
            return count;
        }

        private int GetOccupiedRoomCount()
        {
            int count = 0;
            con.Open();
            string query = "SELECT COUNT(*) AS count FROM room_facilities WHERE room_status = 'Occupied'";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                count = Convert.ToInt32(reader["count"]);
            }
            con.Close();
            return count;
        }

        private int GetMaintenanceRoomCount()
        {
            int count = 0;
            con.Open();
            string query = "SELECT COUNT(*) AS count FROM room_facilities WHERE room_status = 'Under Maintenance'";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                count = Convert.ToInt32(reader["count"]);
            }
            con.Close();
            return count;
        }

        private int GetInactiveRoomCount()
        {
            int count = 0;
            con.Open();
            string query = "SELECT COUNT(*) AS count FROM room_facilities WHERE room_status = 'Inactive'";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                count = Convert.ToInt32(reader["count"]);
            }
            con.Close();
            return count;
        }



    }
}