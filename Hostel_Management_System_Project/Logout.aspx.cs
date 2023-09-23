using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear the user's session or authentication token (e.g., Forms Authentication)
            Session.Clear(); // This will clear all session variables

            // Sign the user out (if using Forms Authentication)
            FormsAuthentication.SignOut();

            // Redirect the user to the login page
            Response.Redirect("Login.aspx"); // Replace "Login.aspx" with your actual login page URL
        }
    }
}