using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace Hostel_Management_System_Project
{
    public partial class ViewFoodMenuItemsList : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
                DisplayFoodMenuItemsList();

                // Load all food menu items initially
                BindFoodMenuData("All", "All");
            }
        }

        void DisplayFoodMenuItemsList()
        {
            con.Open();
            string query = "SELECT * FROM food_menu_table";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                FoodMenuItemRepeater.DataSource = dt;
                FoodMenuItemRepeater.DataBind();
            }
            else
            {
                Response.Write("No data found!");
            }
        }
        //FILTER Functionality
        protected void btnFilter_Click(object sender, EventArgs e)
        {
            // Get the selected filter values
            string selectedTime = ddlTimeFilter.SelectedValue;
            string selectedDay = ddlDayFilter.SelectedValue;

            // Rebind the data with the selected filters
            BindFoodMenuData(selectedTime, selectedDay);
        }

        private void BindFoodMenuData(string selectedTime, string selectedDay)
        {
            // Modify your SQL query based on the selected filters
            string query = "SELECT * FROM food_menu_table WHERE 1=1";

            if (selectedTime != "All")
            {
                query += $" AND meal_time = @selectedTime";
            }

            if (selectedDay != "All")
            {
                query += $" AND meal_day = @selectedDay";
            }

            SqlCommand cmd = new SqlCommand(query, con);

            // Set parameters if needed (use SqlParameter to prevent SQL injection)
            if (selectedTime != "All")
            {
                cmd.Parameters.AddWithValue("@selectedTime", selectedTime);
            }

            if (selectedDay != "All")
            {
                cmd.Parameters.AddWithValue("@selectedDay", selectedDay);
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            con.Open();
            da.Fill(dt);
            con.Close();

            FoodMenuItemRepeater.DataSource = dt;
            FoodMenuItemRepeater.DataBind();
        }

        //SEARCH Functionality
        protected void SearchButton_Click(object sender, EventArgs e)
        {
            string searchQuery = searchInput.Text.ToLower();
            // Call a method to filter the data based on the search query
            FilterFoodMenuData(searchQuery);
        }

        private void FilterFoodMenuData(string searchQuery)
        {
            // Modify your SQL query to include the search condition
            string query = "SELECT * FROM food_menu_table WHERE 1=1";

            if (!string.IsNullOrEmpty(searchQuery))
            {
                query += $" AND (meal_name LIKE @searchQuery OR meal_time LIKE @searchQuery OR meal_day LIKE @searchQuery OR meal_price LIKE @searchQuery OR meal_description LIKE @searchQuery)";
            }

            SqlCommand cmd = new SqlCommand(query, con);

            // Set the parameter for the search query
            if (!string.IsNullOrEmpty(searchQuery))
            {
                cmd.Parameters.AddWithValue("@searchQuery", "%" + searchQuery + "%");
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            con.Open();
            da.Fill(dt);
            con.Close();

            if (dt.Rows.Count > 0)
            {
                FoodMenuItemRepeater.DataSource = dt;
                FoodMenuItemRepeater.DataBind();
                noResultsMessage.Visible = false; // Hide the "No results found" panel message
            }
            else
            {
                FoodMenuItemRepeater.DataSource = null; // Clear the Repeater when no results are found
                FoodMenuItemRepeater.DataBind();
                noResultsMessage.Visible = true; // Show the "No results found" panel message
            }

        }

        protected void EditMenu_Click(object sender, EventArgs e)
        {
            int meal_id = Convert.ToInt32((sender as Button).CommandArgument);
            Session["meal_id"] = meal_id;
            Response.Redirect("UpdateFoodMenuItem.aspx");
        }

        //for delete button action
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        [WebMethod]
        public static string DeleteFoodMenuItem(int mealId)
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True"))
            {
                con.Open();

                // CAUTION! USED DIRECT DELETION HERE!
                string updateFoodMenuItemQuery = "delete from food_menu_table where meal_id = @meal_id";
                SqlCommand cmd = new SqlCommand(updateFoodMenuItemQuery, con);
                cmd.Parameters.AddWithValue("@meal_id", mealId);
                int rowsAffected = cmd.ExecuteNonQuery();

                con.Close();

                if (rowsAffected > 0)
                {
                    return "success";
                }
                else
                {
                    return "error";
                }
            }
        }


    }
}