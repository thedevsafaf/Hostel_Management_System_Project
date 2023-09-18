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
    public partial class P_ViewChildNotificationsList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate notifications list
                PopulateChildNotificationsList();
            }
        }
        private void PopulateChildNotificationsList()
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                string parent_id = Session["parent_id"].ToString();
                SqlCommand cmd = new SqlCommand("select nt.notification_id, nt.student_id, st.name as st_name, st.email as st_email, st.phone_number as st_phone, pt.parent_id as parent_id, pt.name as pt_name, pt.email as pt_email, pt.phone_number as pt_phone, nt.message, nt.created_at from notification_table nt inner join student_table st on st.student_id = nt.student_id inner join parent_table pt on st.student_id = pt.student_id where pt.parent_id = @parent_id and nt.notification_type = 'Student'", con);
                cmd.Parameters.AddWithValue("@parent_id", parent_id);
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