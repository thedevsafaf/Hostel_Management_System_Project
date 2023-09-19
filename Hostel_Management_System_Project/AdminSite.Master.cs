using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostel_Management_System_Project
{
    public partial class AdminSite : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the username is stored in the session
                if (Session["username"] != null)
                {
                    lbl_LoggedInUser.Text = Session["username"].ToString();
                }
            }
        }
    }
}