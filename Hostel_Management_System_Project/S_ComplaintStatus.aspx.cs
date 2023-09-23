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
    public partial class S_ComplaintStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate complaints list
                PopulateComplaintsList();
            }
        }

        private void PopulateComplaintsList()
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                string student_id = Session["student_id"].ToString();
                string query = @"
                          select  ROW_NUMBER() OVER (ORDER BY ct.complaint_id) AS sl_no, 
                          ct.complaint_id, st.student_id as st_id, st.name as st_name, st.email as st_email, 
                          st.phone_number as st_phone, complaint, ct.status as complaint_status, reply, ct.created_at as created_at, ct.complaint_type 
                          from complaint_table ct 
                          inner join student_table st on st.student_id = ct.student_id 
                          where st.student_id = @student_id and ct.complaint_type in ('Student','Parent');";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@student_id", student_id);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Bind the DataTable to the Repeater
                ComplaintRepeater.DataSource = dt;
                ComplaintRepeater.DataBind();
            }
        }
    }
}