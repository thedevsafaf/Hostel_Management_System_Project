using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class UpdateFoodMenuItem : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {

            //loading already registered data for updation
            if (!IsPostBack)
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_foodmenuitem_list", con);
                cmd.CommandType = CommandType.StoredProcedure;
                string meal_id = Session["meal_id"].ToString();
                cmd.Parameters.AddWithValue("@meal_id", meal_id);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    tb_MealName.Text = dt.Rows[0]["meal_name"].ToString();
                    ddl_MealTime.SelectedValue = dt.Rows[0]["meal_time"].ToString();
                    ddl_MealDay.SelectedValue = dt.Rows[0]["meal_day"].ToString();
                    tb_MealDescription.Text = dt.Rows[0]["meal_description"].ToString();
                    tb_MealPrice.Text = dt.Rows[0]["meal_price"].ToString();
                }
                con.Close();
            }
        }

        protected void btn_UpdateFoodMenuItem_Click(object sender, EventArgs e)
        {
            //string meal_id = Session["meal_id"].ToString(); OR
            int mealId = int.Parse(Session["meal_id"].ToString());

            con.Open();

            // Update meal details in food_menu_table
            SqlCommand cmdUpdateRoom = new SqlCommand("sp_update_food_menu_item", con);
            cmdUpdateRoom.CommandType = CommandType.StoredProcedure;
            cmdUpdateRoom.Parameters.AddWithValue("@meal_id", mealId);
            cmdUpdateRoom.Parameters.AddWithValue("@meal_name", tb_MealName.Text);
            cmdUpdateRoom.Parameters.AddWithValue("@meal_time", ddl_MealTime.SelectedValue);
            cmdUpdateRoom.Parameters.AddWithValue("@meal_day", ddl_MealDay.SelectedValue);
            cmdUpdateRoom.Parameters.AddWithValue("@meal_description", tb_MealDescription.Text);
            cmdUpdateRoom.Parameters.AddWithValue("@meal_price", tb_MealPrice.Text);
            cmdUpdateRoom.ExecuteNonQuery();


            con.Close();

            //for navigating to food menu items list page
            Response.Redirect("ViewFoodMenuItemsList.aspx");
        }
    }
}