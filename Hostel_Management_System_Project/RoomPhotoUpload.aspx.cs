using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class RoomPhotoUpload : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-JRHVVPL\SQLEXPRESS;Initial Catalog=hostel_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Populate the dropdown with available rooms from the database
                PopulateRoomDropdown();
            }
        }

        private void PopulateRoomDropdown()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("select room_id, room_no from room_facilities", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddl_Rooms.DataSource = dt;
            ddl_Rooms.DataTextField = "room_no";
            ddl_Rooms.DataValueField = "room_id";
            ddl_Rooms.DataBind();
            con.Close();
        }

        protected void btnUploadPhoto_Click(object sender, EventArgs e)
        {
            try
            {
                // Check if a file is selected for upload
                if (file_RoomPhoto.HasFile)
                {
                    // Get the selected room and file details
                    int roomId = Convert.ToInt32(ddl_Rooms.SelectedValue);
                    string fileName = Path.GetFileName(file_RoomPhoto.FileName);
                    string fileExtension = Path.GetExtension(fileName);

                    // Define allowed file extensions (e.g., .jpg, .png)
                    string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };

                    // Check if the file extension is allowed
                    if (Array.IndexOf(allowedExtensions, fileExtension.ToLower()) >= 0)
                    {
                        // Generate a unique filename to avoid conflicts
                        string uniqueFileName = Guid.NewGuid().ToString() + fileExtension;

                        // Specify the directory where you want to save the uploaded photos
                        string uploadDirectory = Server.MapPath("~/RoomPhotos/");

                        // Combine the directory and filename to get the full path
                        string filePath = Path.Combine(uploadDirectory, uniqueFileName);

                        // Save the file to the server
                        file_RoomPhoto.SaveAs(filePath);

                        // Insert the photo record into the database
                        InsertPhotoIntoDatabase(roomId, uniqueFileName);


                        // Show a SweetAlert for successful photo upload
                        ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessAlert", "ShowSuccessAlert();", true);

                    }
                    else
                    {
                        // File extension not allowed
                        //Response.Write("Only JPG, JPEG, PNG, and GIF files are allowed.");
                        ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorAlert", "ShowErrorAlert('Only JPG, JPEG, PNG, and GIF files are allowed.');", true);
                    }
                }
                else
                {
                    // No file selected for upload
                    //Response.Write("Please select a file to upload.");
                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorAlert", "ShowErrorAlert('Please select a file to upload.');", true);
                }
            }
            // Handle any exception that occurred during photo upload
            catch (Exception exc)
            {   
                string errorMessage = exc.Message;
                // Show a SweetAlert for the error
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowErrorAlert", "ShowErrorAlert('" + errorMessage + "');", true);
            }
        }


        private void InsertPhotoIntoDatabase(int roomId, string fileName)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("insert into room_photos(room_id, photo_url, created_at) VALUES(@roomId, @fileName, GETDATE())", con);
            cmd.Parameters.AddWithValue("@roomId", roomId);
            cmd.Parameters.AddWithValue("@fileName", fileName);
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}