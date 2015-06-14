using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace DefTrack
{
    public partial class NewDefect : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack) {
                Successful_Post.Visible = true;
                New_Defect_Panel.Visible = false;

            }
            else
            {
                Successful_Post.Visible = false;
                New_Defect_Panel.Visible = true;                
            }

        }

        protected void NewDefect_Submit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefTrackConnectionString"].ConnectionString);
        
            con.Open();

            DateTime dt = DateTime.Today;
            SqlCommand cmd = new SqlCommand("INSERT INTO DEFECT (DIMID_SEVERITY, DIMID_STATUS, DIMID_ORIGINATOR, DIMID_OS, DIMID_BROWSER, DIMID_PLATFORM, " +
                                               "SUBMIT_DATE, SUMMARY, DETAIL, ATTACHMENT) VALUES ('" + DD_Severity.SelectedValue+ "', '1', '"+
                                               DD_Originator.SelectedValue+"','"+DD_OS.SelectedValue+"','"+DD_Browser.SelectedValue+"','"+
                                               DD_Platform.SelectedValue+"','"+dt+"','"+T_Summary.Text+"','" +T_Details.Text+ "','0')",con);
            cmd.ExecuteNonQuery();
            con.Close();

            T_Details.Text = "";
            T_Summary.Text = "";
        }
    }
}