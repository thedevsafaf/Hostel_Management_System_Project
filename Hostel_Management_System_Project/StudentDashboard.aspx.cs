using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class StudentDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack) 
            {
                // Check if the SweetAlert has already been shown
                if (Session["SweetAlertShown"] == null)
                {
                    // After successful login, get the user's full name (e.g., fullName) and show SweetAlert
                    string script = @"
                    <script type='text/javascript'>
                        Swal.fire({
                            icon: 'success',
                            title: 'Login Successful',
                            text: 'Welcome, " + Session["name"] + @"!',
                            showConfirmButton: false,
                            timer: 2000
                        });
                    </script>";

                    ClientScript.RegisterStartupScript(this.GetType(), "ShowSuccessAlert", script);

                    // Set the session variable to indicate that the SweetAlert has been shown
                    Session["SweetAlertShown"] = true;
                }
            }
        }
    }
}