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
    public partial class ViewClosedComplaintsList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate complaints list
                PopulateClosedComplaintsList();
            }
        }

        private void PopulateClosedComplaintsList()
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select ct.complaint_id, st.name as st_name, st.email as st_email, st.phone_number as st_phone, complaint, ct.status as complaint_status, reply, ct.created_at as created_at from complaint_table ct inner join student_table st on st.student_id = ct.student_id where ct.status IN ('Closed');", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Bind the DataTable to the Repeater
                ClosedComplaintRepeater.DataSource = dt;
                ClosedComplaintRepeater.DataBind();
            }
        }

        protected void btn_Reopen_Click(object sender, EventArgs e)
        {
            int complaint_id = Convert.ToInt32((sender as Button).CommandArgument);
            Session["complaint_id"] = complaint_id;
            Response.Redirect("ComplaintReply.aspx");
        }
    }
}