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
    public partial class ViewHostelDetails : System.Web.UI.Page
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

    }
}