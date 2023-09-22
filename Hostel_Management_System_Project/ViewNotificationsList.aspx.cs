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
    public partial class ViewNotificationsList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate complaints list
                PopulateNotificationsList();
            }
        }

        private void PopulateNotificationsList()
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                string query = @"
                        select 
                               ROW_NUMBER() OVER (ORDER BY nt.notification_id) AS sl_no, nt.notification_id, nt.student_id, st.name as st_name, st.email as st_email, nt.message, nt.created_at, nt.notification_type
                        from 
                                notification_table nt 
                        inner join 
                                student_table st on st.student_id = nt.student_id
                        where 
                                nt.notification_type in ('Parent', 'Student');";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Bind the DataTable to the Repeater
                NotificationRepeater.DataSource = dt;
                NotificationRepeater.DataBind();
            }
        }
    }
}