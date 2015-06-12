using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace DefTrack
{
    public partial class WorkQueue : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                bindgridview();
                bindgridview2();
                bindgridview3();
                bindgridview4();
            }
        }

        private void bindgridview()
        {
            var data = getDataTable();
            GridView1.DataSource = data;
            GridView1.DataBind();
        }
       
        private DataTable getDataTable()
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["DefTrackConnectionString"].ToString();
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText="SELECT D.DIMID_DEFECT AS [ID#], " +
                                "cast(DATEPART(MM,D.SUBMIT_DATE) as varCHAR(2))+'/'" +
                                    "+cast(DATEPART(DD,D.SUBMIT_DATE) as varCHAR(2))+'/'"+
                                    "+cast(DATEPART(YYYY,D.SUBMIT_DATE) as varCHAR(4)) AS Submitted, " +
	                            "D.SUMMARY AS Summary, "  +
                                "E.EMPLOYEE_FIRST_NAME + LEFT(E.EMPLOYEE_LAST_NAME,1) AS Originator, "+
	                            "S.SEVERITY_DESCRIPTION as Severity, "+
                                "ST.STATUS_DESCRIPTION as Status, "+
                                "P.PLATFORM_DESCRIPTION AS [Platform] "+    
                            "FROM DEFECT AS D "+
	                            "INNER JOIN SEVERITY S "+
		                        "    ON D.DIMID_SEVERITY = S.DIMID_SEVERITY "+
	                            "INNER JOIN STATUS ST "+
		                        "    ON D.DIMID_STATUS = ST.DIMID_STATUS "+
	                            "INNER JOIN EMPLOYEE E "+
		                        "    ON D.DIMID_ORIGINATOR = E.DIMID_EMPLOYEE "+
	                            "INNER JOIN [PLATFORM] P "+
		                        "    ON D.DIMID_PLATFORM = P.DIMID_PLATFORM " +
                                "WHERE ST.STATUS_DESCRIPTION = 'NEW' " +
                                "    AND D.DIMID_PRIORITY IS NULL " +
                                "ORDER BY DIMID_DEFECT";
            cmd.Connection = con;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            return ds.Tables[0];
        }        

        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExp = e.SortExpression;
            string direction = string.Empty;
            if (SortDir==SortDirection.Ascending)
            {
                SortDir = SortDirection.Descending;
                direction = " DESC";
            }
            else
            {
                SortDir = SortDirection.Ascending;
                direction = " ASC";
            }
            DataTable dt = getDataTable();
            dt.DefaultView.Sort = sortExp + direction;
            GridView1.DataSource = dt;
            GridView1.DataBind();

        }
         

        public SortDirection SortDir
        {
            get
            {
                if(ViewState["SortDir"]==null)
                {
                    ViewState["SortDir"] = SortDirection.Ascending;
                }
                return (SortDirection)ViewState["SortDir"];
            }
            set
            {
                ViewState["SortDir"] = value;
            } 
        }



        private void bindgridview2()
        {
            var data = getDataTable2();
            GridView2.DataSource = data;
            GridView2.DataBind();
        }

        private DataTable getDataTable2()
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["DefTrackConnectionString"].ToString();
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "SELECT D.DIMID_DEFECT AS [ID#], " +
                                "cast(DATEPART(MM,D.SUBMIT_DATE) as varCHAR(2))+'/'" +
                                    "+cast(DATEPART(DD,D.SUBMIT_DATE) as varCHAR(2))+'/'" +
                                    "+cast(DATEPART(YYYY,D.SUBMIT_DATE) as varCHAR(4)) AS Submitted, " +
                                "D.SUMMARY AS Summary, " +
                                "E.EMPLOYEE_FIRST_NAME + LEFT(E.EMPLOYEE_LAST_NAME,1) AS Originator, " +
                                "S.SEVERITY_DESCRIPTION as Severity, " +
                                "ST.STATUS_DESCRIPTION as Status, " +
                                "cast(DATEPART(MM,D.DATE_ASSIGNED) as varCHAR(2))+'/'" +
                                    "+cast(DATEPART(DD,D.DATE_ASSIGNED) as varCHAR(2))+'/'" +
                                    "+cast(DATEPART(YYYY,D.DATE_ASSIGNED) as varCHAR(4)) AS Date_Assigned, " +
                                "EA.EMPLOYEE_FIRST_NAME + LEFT(EA.EMPLOYEE_LAST_NAME,1) AS Assigned_To, " +
                                "P.PRIORITY_DESCRIPTION AS Priority " +
                            "FROM DEFECT AS D " +
                                "INNER JOIN SEVERITY S " +
                                "    ON D.DIMID_SEVERITY = S.DIMID_SEVERITY " +
                                "INNER JOIN STATUS ST " +
                                "    ON D.DIMID_STATUS = ST.DIMID_STATUS " +
                                "INNER JOIN EMPLOYEE E " +
                                "    ON D.DIMID_ORIGINATOR = E.DIMID_EMPLOYEE " +
                                "LEFT JOIN EMPLOYEE EA " +
                                "    ON D.DIMID_ASSIGNED_TO = EA.DIMID_EMPLOYEE " +
                                "LEFT JOIN PRIORITY P " +
                                "    ON D.DIMID_PRIORITY = P.DIMID_PRIORITY " +
                                "WHERE ST.STATUS_DESCRIPTION NOT IN ('New','Resolved','Closed','Verified') " +
                                "ORDER BY DIMID_DEFECT";
            cmd.Connection = con;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            return ds.Tables[0];
        }

        protected void GridView2_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExp = e.SortExpression;
            string direction = string.Empty;
            if (SortDir == SortDirection.Ascending)
            {
                SortDir = SortDirection.Descending;
                direction = " DESC";
            }
            else
            {
                SortDir = SortDirection.Ascending;
                direction = " ASC";
            }
            DataTable dt = getDataTable2();
            dt.DefaultView.Sort = sortExp + direction;
            GridView2.DataSource = dt;
            GridView2.DataBind();

        }

        private void bindgridview3()
        {
            var data = getDataTable3();
            GridView3.DataSource = data;
            GridView3.DataBind();
        }

        private DataTable getDataTable3()
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["DefTrackConnectionString"].ToString();
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "SELECT D.DIMID_DEFECT AS [ID#], " +
                                "cast(DATEPART(MM,D.SUBMIT_DATE) as varCHAR(2))+'/'" +
                                    "+cast(DATEPART(DD,D.SUBMIT_DATE) as varCHAR(2))+'/'" +
                                    "+cast(DATEPART(YYYY,D.SUBMIT_DATE) as varCHAR(4)) AS Submitted, " +
                                "D.SUMMARY AS Summary, " +
                                "E.EMPLOYEE_FIRST_NAME + LEFT(E.EMPLOYEE_LAST_NAME,1) AS Originator, " +
                                "S.SEVERITY_DESCRIPTION as Severity, " +
                                "ST.STATUS_DESCRIPTION as Status, " +
                                "P.PLATFORM_DESCRIPTION AS [Platform] " +
                            "FROM DEFECT AS D " +
                                "INNER JOIN SEVERITY S " +
                                "    ON D.DIMID_SEVERITY = S.DIMID_SEVERITY " +
                                "INNER JOIN STATUS ST " +
                                "    ON D.DIMID_STATUS = ST.DIMID_STATUS " +
                                "INNER JOIN EMPLOYEE E " +
                                "    ON D.DIMID_ORIGINATOR = E.DIMID_EMPLOYEE " +
                                "INNER JOIN [PLATFORM] P " +
                                "    ON D.DIMID_PLATFORM = P.DIMID_PLATFORM " +
                                "WHERE ST.STATUS_DESCRIPTION NOT IN ('New','Assigned','Closed','ReOpened') " +
                                "ORDER BY DIMID_DEFECT";
            cmd.Connection = con;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            return ds.Tables[0];
        }

        protected void GridView3_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExp = e.SortExpression;
            string direction = string.Empty;
            if (SortDir == SortDirection.Ascending)
            {
                SortDir = SortDirection.Descending;
                direction = " DESC";
            }
            else
            {
                SortDir = SortDirection.Ascending;
                direction = " ASC";
            }
            DataTable dt = getDataTable3();
            dt.DefaultView.Sort = sortExp + direction;
            GridView3.DataSource = dt;
            GridView3.DataBind();

        }

        private void bindgridview4()
        {
            var data = getDataTable4();
            GridView4.DataSource = data;
            GridView4.DataBind();
        }

        private DataTable getDataTable4()
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["DefTrackConnectionString"].ToString();
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "SELECT cast('000' + D.DIMID_DEFECT as varchar(4)) as [ID#], " +
                                "cast(DATEPART(MM,D.SUBMIT_DATE) as varCHAR(2))+'/'" +
                                    "+cast(DATEPART(DD,D.SUBMIT_DATE) as varCHAR(2))+'/'" +
                                    "+cast(DATEPART(YYYY,D.SUBMIT_DATE) as varCHAR(4)) AS Submitted, " +
                                "D.SUMMARY AS Summary, " +
                                "E.EMPLOYEE_FIRST_NAME + LEFT(E.EMPLOYEE_LAST_NAME,1) AS Originator, " +
                                "S.SEVERITY_DESCRIPTION as Severity, " +
                                "ST.STATUS_DESCRIPTION as Status, " +
                                "P.PRIORITY_DESCRIPTION AS [Priority] " +
                            "FROM DEFECT AS D " +
                                "INNER JOIN SEVERITY S " +
                                "    ON D.DIMID_SEVERITY = S.DIMID_SEVERITY " +
                                "INNER JOIN STATUS ST " +
                                "    ON D.DIMID_STATUS = ST.DIMID_STATUS " +
                                "INNER JOIN EMPLOYEE E " +
                                "    ON D.DIMID_ORIGINATOR = E.DIMID_EMPLOYEE " +
                                "INNER JOIN [PRIORITY] P " +
                                "    ON D.DIMID_PRIORITY = P.DIMID_PRIORITY " +
                                "WHERE ST.STATUS_DESCRIPTION = 'NEW' " +
                                "    AND D.DIMID_PRIORITY > 0 " +
                                "ORDER BY DIMID_DEFECT";
            cmd.Connection = con;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            return ds.Tables[0];
        }

        protected void GridView4_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExp = e.SortExpression;
            string direction = string.Empty;
            if (SortDir == SortDirection.Ascending)
            {
                SortDir = SortDirection.Descending;
                direction = " DESC";
            }
            else
            {
                SortDir = SortDirection.Ascending;
                direction = " ASC";
            }
            DataTable dt = getDataTable4();
            dt.DefaultView.Sort = sortExp + direction;
            GridView4.DataSource = dt;
            GridView4.DataBind();

        }

    }
}