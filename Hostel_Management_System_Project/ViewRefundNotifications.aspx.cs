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
    public partial class ViewRefundNotifications : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate the notifications list
                LoadRefundNotifications();
            }
        }

        private void LoadRefundNotifications()
        {
            con.Open();
            string query = "SELECT message, created_at FROM notification_table WHERE notification_type = 'Refund' ORDER BY created_at DESC";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                // Bind the DataTable to the Repeater
                RefundNotificationsRepeater.DataSource = dt;
                RefundNotificationsRepeater.DataBind();
            }
        }
    }
}