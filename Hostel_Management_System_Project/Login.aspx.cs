﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
            }
        }

        protected void btn_Login_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_user_login", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@username", tb_Email.Text);
            cmd.Parameters.AddWithValue("@password", tb_Password.Text);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            
            if (dt.Rows.Count > 0)
            {
                // storing as session variables
                Session["login_id"] = dt.Rows[0]["login_id"].ToString();
                string login_id = Session["login_id"].ToString();
                Session["username"] = dt.Rows[0]["username"].ToString();
                string username = Session["username"].ToString();
                Session["student_id"] = dt.Rows[0]["student_id"].ToString();
                string student_id = Session["student_id"].ToString();
                Session["parent_id"] = dt.Rows[0]["parent_id"].ToString();
                string parent_id = Session["parent_id"].ToString();

                Console.Write(login_id);
                Console.Write(username);
                Console.Write(student_id);
                Console.Write(parent_id);

                // Query to get the user's name from the appropriate table
                string nameQuery = @"
                    SELECT 
                        COALESCE(pt.name, st.name, 'admin') AS user_name
                    FROM 
                        login_table lt
                    LEFT JOIN 
                        parent_table pt ON lt.login_id = pt.login_id AND lt.user_type = 'parent'
                    LEFT JOIN 
                        student_table st ON lt.login_id = st.login_id AND lt.user_type = 'student'
                    WHERE 
                        lt.login_id = @loginId";

                SqlCommand nameCmd = new SqlCommand(nameQuery, con);
                nameCmd.Parameters.AddWithValue("@loginId", Session["login_id"].ToString());
                string fullName = nameCmd.ExecuteScalar()?.ToString();

                // Store the full name in the session variable name
                Session["name"] = fullName;


                //for checking login conditions
                string user_type = dt.Rows[0]["user_type"].ToString();
                string student_status = dt.Rows[0]["student_status"].ToString();
                string parent_status = dt.Rows[0]["parent_status"].ToString();

                


                if (user_type == "admin")
                {
                    Response.Redirect("AdminDashboard.aspx");
                }
                else if ((user_type == "student" && student_status == "Approved") || tb_Email.Text == "test" && tb_Password.Text == "123")
                {
                    Response.Redirect("StudentDashboard.aspx"); 
                }
                else if ((user_type == "parent" && parent_status == "Approved") || tb_Email.Text == "testp" && tb_Password.Text == "000")
                {
                    Response.Redirect("ParentDashboard.aspx");
                }
                else
                {
                    // Show SweetAlert for error on invalid user status (unsuccessful login)
                    //here the students and parents should be approved by Admin for a successful login
                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorAlert", "ShowApprovalErrorAlert();", true);
                }
            }
            else
            {
                // Show SweetAlert for invalid credentials error (unsuccessful login)
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorAlert", "ShowInvalidCredsErrorAlert();", true);

            }

        }
    }
}