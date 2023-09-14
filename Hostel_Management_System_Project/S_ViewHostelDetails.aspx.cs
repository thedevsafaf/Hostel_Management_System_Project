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
    public partial class S_ViewHostelDetails : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to populate hostel details
                PopulateHostelDetails();

                // Call a method to populate hostel photos
                PopulateHostelPhotos();


                // Call a method to populate hostel photos
                PopulateStaffsDetails();
            }
        }

        private void PopulateHostelDetails()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT name, address, water, bathroom, created_at FROM hostel_table", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            HostelRepeater.DataSource = ds;
            HostelRepeater.DataBind();
            con.Close();
        }

        private void PopulateHostelPhotos()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT photo_url FROM hostel_photos", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            HostelPhotoRepeater.DataSource = ds;
            HostelPhotoRepeater.DataBind();
            con.Close();
        }

        void PopulateStaffsDetails()
        {
            con.Open();
            string query = "SELECT * FROM staff_table";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                StaffRepeater.DataSource = dt;
                StaffRepeater.DataBind();
            }
            else
            {
                Response.Write("No data found!");
            }
        }
    }
}