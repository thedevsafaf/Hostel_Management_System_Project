using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class AddHostel : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Manually Entering hostel details
                string name = "Bunker Boys Hostels";
                string address = "121 2nd Street, Kondotty";
                string water = "Yes";
                string bathroom = "Shared";

                InsertHostelDetails(name, address, water, bathroom);
                InsertHostelPhoto("https://images.unsplash.com/photo-1623625434462-e5e42318ae49?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1471&q=80");
                InsertHostelPhoto("https://images.unsplash.com/photo-1608198399988-341f712c3711?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80");
                InsertHostelPhoto("https://images.unsplash.com/photo-1521783593447-5702b9bfd267?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1504&q=80");
                InsertHostelPhoto("https://images.unsplash.com/photo-1557367184-663fba4b8b91?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80");

            }
        }

        private void InsertHostelDetails(string name, string address, string water, string bathroom)
        {   
            con.Open();
            string query = "INSERT INTO hostel_table(name, address, water, bathroom, created_at) VALUES(@name, @address, @water, @bathroom, GETDATE())";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@address", address);
            cmd.Parameters.AddWithValue("@water", water);
            cmd.Parameters.AddWithValue("@bathroom", bathroom);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        private void InsertHostelPhoto(string photoUrl)
        {
            con.Open();
            string query = "INSERT INTO hostel_photos(photo_url, created_at) VALUES(@photoUrl, GETDATE())";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@photoUrl", photoUrl);
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}