using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

namespace DefTrack
{
    public partial class AssignDefect : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string queue = Request.QueryString["Queue"];
           
            if (queue == "PM")
            {
                AssignDefectPanel.Visible = true;
                DefectPanel.Visible = true;
                PMPanel_ViewOnly.Visible = false;
                LeadDeveloper_ViewOnlyPanel.Visible = false;
                PMPanel.Visible = true;
                LeadDeveloperPanel.Visible = false;
                DeveloperPanel.Visible = false;
                QCPanel.Visible = false;
            }
            if (queue == "LD")
            {
                AssignDefectPanel.Visible = true;
                DefectPanel.Visible = true;
                PMPanel_ViewOnly.Visible = false;
                LeadDeveloper_ViewOnlyPanel.Visible = true;
                PMPanel.Visible = false;
                LeadDeveloperPanel.Visible = true;
                DeveloperPanel.Visible = false;
                QCPanel.Visible = false;

               LeadDeveloperData();

            }
            if (queue == "D")
            {
                AssignDefectPanel.Visible = true;
                DefectPanel.Visible = true;
                PMPanel_ViewOnly.Visible = true;
                LeadDeveloper_ViewOnlyPanel.Visible = false;
                PMPanel.Visible = false;
                LeadDeveloperPanel.Visible = false;
                DeveloperPanel.Visible = true;
                QCPanel.Visible = false;

                SqlDeveloperData();
            }
            if (queue == "QC")
            {
                AssignDefectPanel.Visible = true;
                DefectPanel.Visible = true;
                PMPanel_ViewOnly.Visible = true;
                LeadDeveloper_ViewOnlyPanel.Visible = false;
                PMPanel.Visible = false;
                LeadDeveloperPanel.Visible = false;
                DeveloperPanel.Visible = false;
                QCPanel.Visible = true;

                SqlDeveloperData();
            }

            SqlDefectData();

        }

        private void SqlDefectData()
        {
            var defectid = Request.QueryString["DEFECT_ID"];
            defectid = defectid.ToString().PadLeft(4,'0');
            L_DefectID.Text = defectid;

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["DefTrackConnectionString"].ToString();
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "SELECT " +
                "cast(DATEPART(MM,D.SUBMIT_DATE) as varCHAR(2))+'/'+cast(DATEPART(DD,D.SUBMIT_DATE) as varCHAR(2))+'/'" +
                "+cast(DATEPART(YYYY,D.SUBMIT_DATE) as varCHAR(4)) AS Submitted, " +
	            "D.SUMMARY AS Summary, E.EMPLOYEE_FIRST_NAME + ' ' + E.EMPLOYEE_LAST_NAME AS Originator, S.SEVERITY_DESCRIPTION as Severity, " +
                "ST.STATUS_DESCRIPTION as [Status], P.PLATFORM_DESCRIPTION AS [Platform], O.OS_DESCRIPTION AS OS, " +
                "B.BROWSER_DESCRIPTION AS BROWSER, D.DETAIL " +
                "FROM DEFECT AS D INNER JOIN SEVERITY S ON D.DIMID_SEVERITY = S.DIMID_SEVERITY " +
	            "INNER JOIN STATUS ST ON D.DIMID_STATUS = ST.DIMID_STATUS INNER JOIN EMPLOYEE E ON D.DIMID_ORIGINATOR = E.DIMID_EMPLOYEE " +
	            "INNER JOIN [PLATFORM] P ON D.DIMID_PLATFORM = P.DIMID_PLATFORM INNER JOIN OPERATING_SYSTEM O ON D.DIMID_OS = O.DIMID_OS " +
	            "INNER JOIN BROWSER B ON D.DIMID_BROWSER = B.DIMID_BROWSER " +
                "WHERE DIMID_DEFECT = '"+defectid+"'";
            cmd.Connection = con;
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    var submitDate = rdr.GetString(0);
                    var Summary = rdr.GetString(1);
                    var Originator = rdr.GetString(2);
                    var Severity = rdr.GetString(3);
                    var Status = rdr.GetString(4);
                    var Platform = rdr.GetString(5);
                    var OS = rdr.GetString(6);
                    var Browser = rdr.GetString(7);
                    var Detail = rdr.GetString(8);
                   

                    L_Summary.Text = Summary;
                    L_SubmitDate.Text = submitDate;
                    L_Originator.Text = Originator;
                    L_Severity.Text = Severity;
                    L_Status.Text = Status;
                    L_Platform.Text = Platform;
                    L_OS.Text = OS;
                    L_Browser.Text = Browser;
                    L_Detail.Text = Detail;

                } 
            }
            
        }

        protected void AssignDefect_Button_Click(object sender, EventArgs e)
        {
            var defectid = Request.QueryString["DEFECT_ID"];
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefTrackConnectionString"].ConnectionString);

            con.Open();

            DateTime dt = DateTime.Today;
            SqlCommand cmd = new SqlCommand("UPDATE DEFECT SET DIMID_STATUS = '"+DD_Status.SelectedValue+"', DIMID_PRIORITY = '"+
                                                DD_Priority.SelectedValue+"' " +
                                                "WHERE DIMID_DEFECT = '"+ defectid +"'", con);
            cmd.ExecuteNonQuery();
            SqlCommand cmd2 = new SqlCommand("INSERT INTO NOTES (DIMID_DEFECT, DIMID_EMPLOYEE, DATE_ENTERED, INITIAL_MANAGER_NOTE, NOTE_DESCRIPTION, DIMID_STATUS) " +
                                                "VALUES ('" + defectid + "', '" + DD_ASSIGNED_BY.SelectedValue + "', '" + dt + "', 'True', '" +
                                                T_Notes.Text + "', '" +DD_Status.SelectedValue+ "')", con);
            cmd2.ExecuteNonQuery();
            con.Close();

            T_Notes.Text = "";

            Response.Redirect("WorkQueue.aspx");
        }

        private void LeadDeveloperData()
        {
            var defectid = Request.QueryString["DEFECT_ID"];
            defectid = defectid.ToString().PadLeft(4, '0');
            L_DefectID.Text = defectid;

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["DefTrackConnectionString"].ToString();
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "SELECT " +
                "ST.STATUS_DESCRIPTION as [Status], " +
                "PR.PRIORITY_DESCRIPTION AS PRIORITY, " +
                "N.NOTE_DESCRIPTION, " +
                "E.EMPLOYEE_FIRST_NAME + ' ' + EMPLOYEE_LAST_NAME AS Approved_By " +
                "FROM DEFECT AS D " +
                "INNER JOIN STATUS ST ON D.DIMID_STATUS = ST.DIMID_STATUS " +
                "LEFT JOIN PRIORITY PR ON D.DIMID_PRIORITY = PR.DIMID_PRIORITY " +
                "LEFT JOIN NOTES N ON D.DIMID_DEFECT = N.DIMID_DEFECT " +
                "LEFT JOIN EMPLOYEE E ON N.DIMID_EMPLOYEE = E.DIMID_EMPLOYEE " +
                "WHERE D.DIMID_DEFECT = '" + defectid + "' " +
                "    AND N.INITIAL_MANAGER_NOTE = 1";
            cmd.Connection = con;
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    var LDStatus = rdr.GetString(0);
                    var LDPriority = rdr.GetString(1);
                    var LDApprovedBy = rdr.GetString(3);
                    var LDNotes = rdr.GetString(2);

                    L_LDStatus.Text = LDStatus;
                    L_LDPriority.Text = LDPriority;
                    L_LDApprovedBy.Text = LDApprovedBy;
                    L_Notes.Text = LDNotes;
                }
            }

            con.Close();
        }


        private void SqlDeveloperData()
        {
            var defectid = Request.QueryString["DEFECT_ID"];
            defectid = defectid.ToString().PadLeft(4,'0');
            L_DefectID.Text = defectid;

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["DefTrackConnectionString"].ToString();
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "SELECT TOP 1" +
                "ST.STATUS_DESCRIPTION as [Status], " +
                "PR.PRIORITY_DESCRIPTION AS PRIORITY, " +
                "A.EMPLOYEE_FIRST_NAME + ' ' + A.EMPLOYEE_LAST_NAME AS Assigned_To, " +
                "N.NOTE_DESCRIPTION " +
                "FROM DEFECT AS D " +
	            "INNER JOIN STATUS ST ON D.DIMID_STATUS = ST.DIMID_STATUS " +
	            "LEFT JOIN PRIORITY PR ON D.DIMID_PRIORITY = PR.DIMID_PRIORITY " +
                "LEFT JOIN EMPLOYEE A ON D.DIMID_ASSIGNED_TO = A.DIMID_EMPLOYEE " +
                "LEFT JOIN NOTES N ON D.DIMID_DEFECT = N.DIMID_DEFECT " +
                "WHERE D.DIMID_DEFECT = '"+defectid+"' " +
                "    AND N.INITIAL_MANAGER_NOTE = 1 " +
                "ORDER BY N.DIMID_NOTES";
            cmd.Connection = con;
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    var Status = rdr.GetString(0);
                    var Priority = rdr.GetString(1);
                    var AssignedTo = rdr.GetString(2);
                    var MgrNotes = rdr.GetString(3);

                    L_Status.Text = Status;
                    L_Priority.Text = Priority;
                    L_AssignedTo.Text = AssignedTo;
                    L_MgrNotes.Text = MgrNotes;
                }
            }

            SqlCommand cmd2 = new SqlCommand();
            cmd2.CommandText = "SELECT TOP 1" +
                "N.NOTE_DESCRIPTION " +
                "FROM NOTES N " +
                "WHERE N.DIMID_DEFECT = '" + defectid + "' " +
                "    AND N.INITIAL_MANAGER_NOTE = 1 " +
                "ORDER BY N.DIMID_NOTES DESC";
            cmd2.Connection = con;
            using (SqlDataReader rdr = cmd2.ExecuteReader())
            {
                while (rdr.Read())
                {
                    var LDNotes = rdr.GetString(0);
                   
                    L_LDNotes.Text = LDNotes;
                }
            }

            if (L_LDNotes.Text == L_MgrNotes.Text)
            {
                L_LDNotes.Text = "";
            }
            con.Close();
        }

        protected void Dev_Update_Button_Click(object sender, EventArgs e)
        {
            var defectid = Request.QueryString["DEFECT_ID"];
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefTrackConnectionString"].ConnectionString);

            con.Open();

            DateTime dt = DateTime.Now;
            SqlCommand cmd = new SqlCommand("UPDATE DEFECT SET DIMID_STATUS = '" + DD_StatusUpdate.SelectedValue + "'" +
                                                " WHERE DIMID_DEFECT = '" + defectid + "'", con);
            cmd.ExecuteNonQuery();
            SqlCommand cmd2 = new SqlCommand("INSERT INTO NOTES (DIMID_DEFECT, DIMID_EMPLOYEE, DATE_ENTERED, INITIAL_MANAGER_NOTE, NOTE_DESCRIPTION, DIMID_STATUS)" +
                                                "VALUES ('" + defectid + "','" + DD_DevUpdatedBy.SelectedValue + "','" + dt + "', 0, '" +
                                                T_DeveloperNotes.Text + "', '" +DD_StatusUpdate.SelectedValue+ "')", con);
            cmd2.ExecuteNonQuery();
            con.Close();

            T_DeveloperNotes.Text = "";

            Response.Redirect("WorkQueue.aspx");
        }

        protected void Button_LeadDeveloper_Submit_Click(object sender, EventArgs e)
        {
            var defectid = Request.QueryString["DEFECT_ID"];
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefTrackConnectionString"].ConnectionString);

            con.Open();

            DateTime dt = DateTime.Now;
            SqlCommand cmd = new SqlCommand("UPDATE DEFECT SET DIMID_STATUS = '" + DD_LDStatus.SelectedValue + "', " +
                                                "DIMID_ASSIGNED_TO = '" + DD_LDAssignedTo.SelectedValue + "', " +
                                                "DIMID_ASSIGNED_BY = '" + DD_LDAssignedBy.SelectedValue + "' " +
                                                "DATE_ASSIGNED = '" + dt + "' " +
                                                "WHERE DIMID_DEFECT = '" + defectid + "'", con);
            cmd.ExecuteNonQuery();
            SqlCommand cmd2 = new SqlCommand("INSERT INTO NOTES (DIMID_DEFECT, DIMID_EMPLOYEE, DATE_ENTERED, INITIAL_MANAGER_NOTE, NOTE_DESCRIPTION, DIMID_STATUS)" +
                                                "VALUES ('" + defectid + "','" + DD_LDAssignedBy.SelectedValue + "','" + dt + "', 'True', '" +
                                                T_LeadDeveloperNotes.Text + "', '" + DD_LDStatus.SelectedValue + "')", con);
            cmd2.ExecuteNonQuery();
            con.Close();

            T_DeveloperNotes.Text = "";

            Response.Redirect("WorkQueue.aspx");
        }

       

       
    }
}