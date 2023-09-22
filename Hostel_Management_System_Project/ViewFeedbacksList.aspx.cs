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
    public partial class ViewFeedbacksList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate complaints list
                PopulateFeedbacksList();
            }
        }
        private void PopulateFeedbacksList()
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                string query = @"
                    select 
                        ROW_NUMBER() OVER (ORDER BY ft.feedback_id) AS sl_no, ft.feedback_id, ft.student_id, st.name as st_name, st.email as st_email, st.phone_number as st_phone, ft.feedback, ft.created_at 
                    from 
                        feedback_table ft 
                    inner join 
                        student_table st on st.student_id = ft.student_id;";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Bind the DataTable to the Repeater
                FeedbackRepeater.DataSource = dt;
                FeedbackRepeater.DataBind();
            }
        }
    }
}