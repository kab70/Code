<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AssignDefect.aspx.cs" Inherits="DefTrack.AssignDefect" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron2">
                <a class="btn btn-default buttonholder float_right_button" href="WorkQueue.aspx">Return to Work Queue</a>
        <h2>Defect Details:</h2>
        <h4>Defect ID#: <asp:Literal ID="L_DefectID" runat="server" EnableViewState="false" /></h4>              
    </div>

    <asp:Panel ID="AssignDefectPanel" CssClass="formbody" runat="server">
        <asp:Panel ID="DefectPanel" runat="server">
            <table class="defect_layout">
                <tr>
                    <td class="text-right">Summary:</td>
                    <td colspan="3">
                        <asp:Literal ID="L_Summary" runat="server" EnableViewState="false" />
                    </td>
                    <td class="text-right">Platform:</td>
                    <td>
                        <asp:Literal ID="L_Platform" runat="server" EnableViewState="false" />
                    </td>
                </tr>
                <tr>
                    <td class="text-right">Originator:</td>
                    <td colspan="3">
                        <asp:Literal ID="L_Originator" runat="server" EnableViewState="false" />
                    </td>
                    <td class="text-right">Operating System:</td>
                    <td>
                        <asp:Literal ID="L_OS" runat="server" EnableViewState="false" />
                    </td>
                </tr>
                <tr>
                    <td class="text-right">Date Submitted:</td>
                    <td>
                        <asp:Literal ID="L_SubmitDate" runat="server" EnableViewState="false" />
                    </td>
                    <td class="text-right">Severity:</td>
                    <td>
                        <asp:Literal ID="L_Severity" runat="server" EnableViewState="false" />
                    </td>
                    <td class="text-right">Browser:</td>
                    <td>
                        <asp:Literal ID="L_Browser" runat="server" EnableViewState="false" />
                    </td>
                </tr>
                <tr>
                    <td class="text-right">Detail:</td>
                    <td colspan="5">
                        <asp:Literal ID="L_Detail" runat="server" EnableViewState="false" />
                        
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="PMPanel_ViewOnly" runat="server">
            <table class="defect_layout">
                <tr>
                    <td Class="text-right">Status:</td>
                    <td Class="field_color">
                        <asp:Literal ID="L_Status" runat="server" EnableViewState="false" />
                    </td>
                    <td Class="text-right">Assign To:</td>
                    <td Class="field_color">
                        <asp:Literal ID="L_AssignedTo" runat="server" EnableViewState="false" />
                    </td>
                    <td class="text-right">Priority:</td>
                    <td Class="field_color">
                        <asp:Literal ID="L_Priority" runat="server" EnableViewState="false" />
                    </td>
                </tr>
                <tr>
                    <td class="text-right">Management Notes:</td>
                    <td colspan="5" Class="field_color">
                        <asp:Literal ID="L_MgrNotes" runat="server" EnableViewState="false" />
                    </td>
                </tr>
                <tr>
                    <td class="text-right">Lead Developer Notes:</td>
                    <td colspan="5" class="field_color">
                        <asp:Literal ID="L_LDNotes" runat="server" EnableViewState="false" />
                    </td>
                </tr>
            </table> 
        </asp:Panel>
        
        <asp:Panel ID="LeadDeveloper_ViewOnlyPanel" runat="server">
            <table class="defect_layout">
                <tr>
                    <td Class="text-right">Status:</td>
                    <td Class="field_color">
                        <asp:Literal ID="L_LDStatus" runat="server" EnableViewState="false" />
                    </td>
                    <td Class="text-right">Priority:</td>
                    <td Class="field_color">
                        <asp:Literal ID="L_LDPriority" runat="server" EnableViewState="false" />
                    </td>
                    <td class="text-right">Approved By:</td>
                    <td Class="field_color">
                        <asp:Literal ID="L_LDApprovedBy" runat="server" EnableViewState="false" />
                    </td>
                </tr>
                <tr>
                    <td class="text-right">Management Notes:</td>
                    <td colspan="5" Class="field_color">
                        <asp:Literal ID="L_Notes" runat="server" EnableViewState="false" />
                    </td>
                </tr>                
            </table> 
        </asp:Panel>
    </asp:Panel>
    
    <br />

    <asp:Panel ID="PMPanel" CssClass="formbody" runat="server">
        <div class="pm_layout">
            <table style="width: 100%">
                <tr>
                    <td class="width: 33%">Status: &nbsp; &nbsp;
                        <asp:DropDownList ID="DD_Status" runat="server" cssClass="field_color" DataSourceID="getStatus" DataTextField="STATUS_DESCRIPTION" DataValueField="DIMID_STATUS" AppendDataBoundItems="true">
                            <asp:ListItem>Assign Status</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="getStatus" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT * FROM [STATUS]
WHERE STATUS_DESCRIPTION IN ('Approved', 'Rejected', 'Assigned')
ORDER BY STATUS_DESCRIPTION"></asp:SqlDataSource>
                    </td>
                    <td class="width: 33%">Priority: &nbsp; &nbsp;
                        <asp:DropDownList ID="DD_Priority" runat="server" cssClass="field_color" datasourceid="getPriority" DataTextField="PRIORITY_DESCRIPTION" DataValueField="DIMID_PRIORITY" AppendDataBoundItems="true">
                            <asp:ListItem>Define Priority</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="getPriority" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT [DIMID_PRIORITY], [PRIORITY_DESCRIPTION] FROM [PRIORITY]"></asp:SqlDataSource>
                    </td>
                    <td class="width: 33%">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 106px">Management Notes:<br /><asp:TextBox ID="T_Notes" runat="server" cssClass="field_color" TextMode="MultiLine" Rows="5" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Reviewed By:&nbsp;
                        <asp:DropDownList ID="DD_ASSIGNED_BY" runat="server" DataSourceID="getManager" DataTextField="Employee" DataValueField="DIMID_EMPLOYEE" AppendDataBoundItems="True">
                            <asp:ListItem>Select Manager</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="getManager" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT
     E.DIMID_EMPLOYEE,
     E.EMPLOYEE_FIRST_NAME + ' ' + E.EMPLOYEE_LAST_NAME AS Employee
FROM EMPLOYEE E
     INNER JOIN EMPLOYEE_ROLE R
          ON E.DIMID_EMPLOYEE_ROLE = R.DIMID_EMPLOYEE_ROLE
WHERE R.ROLE_DESCRIPTION IN ('Lead Developer', 'Project Manager')"></asp:SqlDataSource>
                    </td>
                    <td><asp:button cssClass="btn btn-default" id="AssignDefect_Button" runat="server" text="Submit" OnClick="AssignDefect_Button_Click" /></td>
                </tr>
            </table> 
        </div>

    </asp:Panel>
    
    <br />

    <asp:Panel ID="LeadDeveloperPanel" CssClass="formbody" runat="server">
        
        <div class="pm_layout">
            <table style="width: 100%">
                <tr>
                    <td class="width: 33%">Update Status: &nbsp;
                        <asp:DropDownList ID="DD_LDStatus" runat="server" DataSourceID="getStatus" DataTextField="STATUS_DESCRIPTION" DataValueField="DIMID_STATUS" AppendDataBoundItems="true">
                            <asp:ListItem>Status</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;
                    </td>
                    <td class="width: 33%">Assign To: &nbsp; &nbsp;
                        <asp:DropDownList ID="DD_LDAssignedTo" runat="server" DataSourceID="getDeveloper" DataTextField="Developer" DataValueField="DIMID_EMPLOYEE" AppendDataBoundItems="True">
                            <asp:ListItem>Select Developer</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="getDeveloper" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT
    E.DIMID_EMPLOYEE,
    E.EMPLOYEE_FIRST_NAME + ' ' + E.EMPLOYEE_LAST_NAME AS Developer
FROM EMPLOYEE E
    INNER JOIN EMPLOYEE_ROLE R
        ON R.DIMID_EMPLOYEE_ROLE = E.DIMID_EMPLOYEE_ROLE
WHERE R.ROLE_DESCRIPTION IN ('Lead Developer','Developer')"></asp:SqlDataSource>
                        </td>
                    <td class="width: 33%">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 106px">Lead Developer Notes:<br /><asp:TextBox ID="T_LeadDeveloperNotes" runat="server" cssClass="field_color" TextMode="MultiLine" Rows="5" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Assigned By:&nbsp;
                        <asp:DropDownList ID="DD_LDAssignedBy" runat="server" DataSourceID="getManager" DataTextField="Employee" DataValueField="DIMID_EMPLOYEE" AppendDataBoundItems="True">
                            <asp:ListItem>Select Manager</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Button cssClass="btn btn-default" ID="Button_LeadDeveloper_Submit" runat="server" Text="Submit" OnClick="Button_LeadDeveloper_Submit_Click" />
                    </td>
                </tr>
            </table> 
        </div>
    </asp:Panel>
    
    <asp:Panel ID="DeveloperPanel" CssClass="formbody" runat="server">
        <asp:Panel ID="DeveloperUpdatePanel" runat="server">            
            <table class="defect_layout">
                <tr>
                    <td colspan="5">Developer Notes:</td>
                </tr>
                <tr>
                    <td colspan="5">
                        <asp:TextBox ID="T_DeveloperNotes" runat="server" cssClass="field_color" TextMode="MultiLine" Rows="5" Width="100%"></asp:TextBox></td>
                </tr>
                <tr><td colspan="5">&nbsp;</td></tr>
                <tr>
                    <td class="text-right">Status Update:</td>
                    <td>
                        <asp:DropDownList ID="DD_StatusUpdate" runat="server" DataSourceID="updateStatus" DataTextField="STATUS_DESCRIPTION" DataValueField="DIMID_STATUS" AppendDataBoundItems="true">
                            <asp:ListItem>Status</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="updateStatus" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT * FROM [STATUS] WHERE 
STATUS_DESCRIPTION IN ('Assigned', 'Resolved', 'Rejected', 'In Process') ORDER BY STATUS_DESCRIPTION">
                        </asp:SqlDataSource>
                    </td>
                    <td class="text-right">Updated By:</td>
                    <td>
                        <asp:DropDownList ID="DD_DevUpdatedBy" runat="server" DataSourceID="UpdatedByDeveloper" DataTextField="Developer" DataValueField="DIMID_EMPLOYEE" AppendDataBoundItems="True">
                            <asp:ListItem>Select Developer</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="UpdatedByDeveloper" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT
    E.DIMID_EMPLOYEE,
    E.EMPLOYEE_FIRST_NAME + ' ' + EMPLOYEE_LAST_NAME AS Developer
FROM EMPLOYEE E
    INNER JOIN EMPLOYEE_ROLE R
        ON E.DIMID_EMPLOYEE_ROLE = R.DIMID_EMPLOYEE_ROLE
WHERE R.ROLE_DESCRIPTION IN ('Developer','Lead Developer','Project Manager','Administrator')
"></asp:SqlDataSource>
                    </td>
                    <td class="text-right">
                        <asp:Button ID="Dev_Update_Button" cssClass="btn btn-default" runat="server" Text="Update" OnClick="Dev_Update_Button_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <asp:Panel ID="DeveloperNotesPanel" cssClass="developerNotes" runat="server">
            <asp:Repeater ID="DeveloperNotesHistory" runat="server">
                <HeaderTemplate>
                    <table style=" border:1px solid #808080; width:100%">
                        <tr style="background-color:#808080; color:White">
                            <td colspan="2"><b>Developer Notes</b></td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <table style="background-color:#EBEFF0;border-top:1px dotted #808080;border-bottom:1px solid #808080; width:100%" >
                                <tr>
                                    <td>Developer: 
                                        <asp:Label ID="LDeveloperName" runat="server" Text='<%#Eval("Developer") %>' /></td>
                                    <td>Created Date:
                                        <asp:Label ID="LDateEntered" runat="server" Text='<%#Eval("Date_Entered") %>' /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="LDeveloperNotes" cssClass="indent" runat="server" Text='<%#Eval("DeveloperNotes") %>' /></td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </asp:Panel>

    </asp:Panel>
    <br />
    <asp:Panel ID="QCPanel" CssClass="formbody" runat="server">
        <asp:Panel ID="FinalizationPanel" runat="server">
            <table style="width: 100%; font-size: 80%">
                <tr>
                    <td>Update Status: &nbsp; &nbsp;   
                        <asp:DropDownList ID="DD_FinalStatus" runat="server" DataSourceID="getFinalStatus" DataTextField="STATUS_DESCRIPTION" DataValueField="DIMID_STATUS" AppendDataBoundItems="True">
                            <asp:ListItem>Status</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="getFinalStatus" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT * FROM [STATUS] WHERE 
                            STATUS_DESCRIPTION IN ('Closed', 'Reopened') ORDER BY STATUS_DESCRIPTION">
                        </asp:SqlDataSource>
                    </td>
                    <td>Project Manager: &nbsp; &nbsp;
                        <asp:DropDownList ID="DD_Manager" runat="server" AppendDataBoundItems="True" DataSourceID="getClosingManager" DataTextField="Manager" DataValueField="DIMID_EMPLOYEE">
                            <asp:ListItem>Select Employee</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="getClosingManager" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT 
                                E.DIMID_EMPLOYEE,
                                E.EMPLOYEE_FIRST_NAME + ' ' + E.EMPLOYEE_LAST_NAME AS Manager
                            FROM EMPLOYEE E
                                INNER JOIN EMPLOYEE_ROLE R
                                    ON E.DIMID_EMPLOYEE_ROLE = R.DIMID_EMPLOYEE_ROLE
                            WHERE R.ROLE_DESCRIPTION IN ('Project Manager', 'Lead Developer')
                            ">
                        </asp:SqlDataSource>
                    </td>
                    <td class="text-right">
                        <asp:Button ID="Finalized_Button" cssClass="btn btn-default" runat="server" Text="Update" OnClick="Finalized_Button_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="QCDataPanel" runat="server">
        <table class="defect_layout">
            <tr>
                <td colspan="5">Test Plan:</td>
            </tr>
            <tr>
                <td colspan="5">
                    <asp:TextBox ID="T_QCTestPlan" runat="server" cssClass="field_color" TextMode="MultiLine" Rows="5" Width="100%"></asp:TextBox></td>
            </tr>
            <tr><td colspan="5">&nbsp;</td></tr>
            <tr>
                <td colspan="5">Attach Test Results: &nbsp; &nbsp; <asp:FileUpload ID="QCFileUpload" runat="server" /></td>
            </tr>
            <tr><td colspan="5">&nbsp;</td></tr><tr>
                <td colspan="5">QC Notes:</td>
            </tr>
            <tr>
                <td colspan="5">
                    <asp:TextBox ID="T_QCNotes" runat="server" cssClass="field_color" TextMode="MultiLine" Rows="5" Width="100%"></asp:TextBox></td>
            </tr>
            <tr><td colspan="5">&nbsp;</td></tr>
            <tr>
                <td class="text-right">Status Update:</td>
                <td>
                    <asp:DropDownList ID="DD_QCStatus" runat="server" DataSourceID="QC_updateStatus" DataTextField="STATUS_DESCRIPTION" DataValueField="DIMID_STATUS" AppendDataBoundItems="true">
                        <asp:ListItem>Status</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="QC_updateStatus" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT * FROM [STATUS] WHERE 
STATUS_DESCRIPTION IN ('Closed', 'Reopened','QC - In Process','Awaiting Customer Acceptance') ORDER BY STATUS_DESCRIPTION">
                    </asp:SqlDataSource>
                </td>
                <td class="text-right">QC Employee:</td>
                <td>
                    <asp:DropDownList ID="DD_QCEmployee" runat="server" DataSourceID="getQCEmployee" DataTextField="Developer" DataValueField="DIMID_EMPLOYEE" AppendDataBoundItems="True">
                        <asp:ListItem>Select Employee</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="getQCEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT
                        E.DIMID_EMPLOYEE,
                        E.EMPLOYEE_FIRST_NAME + ' ' + EMPLOYEE_LAST_NAME AS Developer
                        FROM EMPLOYEE E
                        INNER JOIN EMPLOYEE_ROLE R
                            ON E.DIMID_EMPLOYEE_ROLE = R.DIMID_EMPLOYEE_ROLE
                        WHERE R.ROLE_DESCRIPTION IN ('Quality Control')
                        "></asp:SqlDataSource>
                </td>
                <td class="text-right">
                    <asp:Button ID="QC_Submit_Button" cssClass="btn btn-default" runat="server" Text="Update" OnClick="QC_Update_Button_Click" />
                </td>
            </tr>
        </table>
        </asp:Panel>
        <br />
     
        <asp:Panel ID="QCNotesHistoryPanel" cssClass="developerNotes" runat="server">
            <asp:Repeater ID="QCNotesHistory" runat="server">
                <HeaderTemplate>
                    <table style=" border:1px solid #808080; width:100%">
                        <tr style="background-color:#808080; color:White">
                            <td colspan="2"><b>Quality Control Notes</b></td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <table style="background-color:#EBEFF0;border-top:1px dotted #808080;border-bottom:1px solid #808080; width:100%" >
                                <tr>
                                    <td>QC Employee: 
                                        <asp:Label ID="LQCName" runat="server" Text='<%#Eval("QC_Employee") %>' /></td>
                                    <td>Created Date:
                                        <asp:Label ID="LQCDateEntered" runat="server" Text='<%#Eval("QC_Date_Entered") %>' /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="LDeveloperNotes" cssClass="indent" runat="server" Text='<%#Eval("QCNotes") %>' /></td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </asp:Panel>
        <br />
        <asp:Panel ID="QC_DeveloperHistoricalNotesPanel" cssClass="developerNotes" runat="server">
            <asp:Repeater ID="QC_DeveloperNotes" runat="server">
                <HeaderTemplate>
                    <table style=" border:1px solid #808080; width:100%">
                        <tr style="background-color:#808080; color:White">
                            <td colspan="2"><b>Developer Notes</b></td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <table style="background-color:#EBEFF0;border-top:1px dotted #808080;border-bottom:1px solid #808080; width:100%" >
                                <tr>
                                    <td>Developer: 
                                        <asp:Label ID="LDeveloperName" runat="server" Text='<%#Eval("Developer") %>' /></td>
                                    <td>Created Date:
                                        <asp:Label ID="LDateEntered" runat="server" Text='<%#Eval("Date_Entered") %>' /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="LDeveloperNotes" cssClass="indent" runat="server" Text='<%#Eval("DeveloperNotes") %>' /></td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </asp:Panel>

       
    </asp:Panel>

</asp:Content>
