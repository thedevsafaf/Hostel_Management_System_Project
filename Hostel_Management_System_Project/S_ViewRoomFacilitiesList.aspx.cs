﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class S_ViewRoomFacilitiesList : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            DisplayRoomsList();
        }

        protected string GetStatusCssClass(string status)
        {
            switch (status)
            {
                case "Vacant":
                    return "status-vacant";
                case "Occupied":
                    return "status-occupied";
                default:
                    return string.Empty; // No specific class for other values
            }
        }

        void DisplayRoomsList()
        {
            con.Open();
            string query = "SELECT ROW_NUMBER() OVER (ORDER BY room_id) AS sl_no, * FROM room_facilities where room_status in ('Vacant', 'Occupied')";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                RoomRepeater.DataSource = dt;
                RoomRepeater.DataBind();
            }
            else
            {
                Response.Write("No data found!");
            }
        }

        protected void FilterButton_Click(object sender, EventArgs e)
        {
            string selectedStatus = statusFilter.SelectedValue;
            BindRoomData(selectedStatus, searchInput.Text);
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            string selectedStatus = statusFilter.SelectedValue;
            string searchQuery = searchInput.Text;
            BindRoomData(selectedStatus, searchQuery);
        }

        private void BindRoomData(string selectedStatus, string searchQuery)
        {
            con.Open();
            string query = "SELECT ROW_NUMBER() OVER (ORDER BY room_id) AS sl_no,room_id, room_no, room_desc, room_status, created_at FROM room_facilities WHERE 1=1 AND room_status IN ('Vacant', 'Occupied')";

            // Add conditions based on the selected status and search query
            if (!string.IsNullOrEmpty(selectedStatus))
            {
                query += " AND room_status = @selectedStatus";
            }

            if (!string.IsNullOrEmpty(searchQuery))
            {
                query += " AND (room_no LIKE @searchQuery)";
            }

            SqlCommand cmd = new SqlCommand(query, con);

            // Set parameters if needed (use SqlParameter to prevent SQL injection)
            if (!string.IsNullOrEmpty(selectedStatus))
            {
                cmd.Parameters.AddWithValue("@selectedStatus", selectedStatus);
            }

            if (!string.IsNullOrEmpty(searchQuery))
            {
                cmd.Parameters.AddWithValue("@searchQuery", "%" + searchQuery + "%");
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();

            if (dt.Rows.Count > 0)
            {
                RoomRepeater.DataSource = dt;
                RoomRepeater.DataBind();
                noResultsMessage.Visible = false; // Hide the no results message
            }
            else
            {
                RoomRepeater.DataSource = null; // Clear the repeater
                RoomRepeater.DataBind();
                noResultsMessage.Visible = true; // Show the no results message
            }
        }
    }
}