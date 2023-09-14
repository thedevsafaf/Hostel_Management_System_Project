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
    public partial class AddFoodMenuItem : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { }
        }

        protected void btn_AddFoodMenuItem_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_insert_food_menu_item", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@meal_time", ddl_MealTime.SelectedValue);
                cmd.Parameters.AddWithValue("@meal_day", ddl_MealDay.SelectedValue);
                cmd.Parameters.AddWithValue("@meal_name", tb_MealName.Text);
                cmd.Parameters.AddWithValue("@meal_description", tb_MealDescription.Text);
                cmd.Parameters.AddWithValue("@meal_price", tb_MealPrice.Text);
                cmd.ExecuteNonQuery();

                con.Close();

                // Show a SweetAlert for successful food menu item add
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessAlert", "ShowSuccessAlert();", true);
            }
            // Handle any exception that occurred during food menu item add
            catch (Exception exc)
            {
                // Get the error message from the exception
                string errorMessage = exc.Message;
                // Show a SweetAlert for the error
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorAlert", "ShowErrorAlert('" + errorMessage + "');", true);
            }
        }
    }
}