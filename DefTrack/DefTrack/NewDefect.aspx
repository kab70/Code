<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewDefect.aspx.cs" Inherits="DefTrack.NewDefect" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    
    <div class="jumbotron2">
        <h2>Record New Defect</h2>        
    </div>

    <asp:Panel ID="New_Defect_Panel" class="formbody" runat="server">
    <div class="formbody">
        <div class="float_left">
            <asp:Label ID="L_Originator" class="label_format" runat="server" Text="Originator:"></asp:Label>
            <asp:TextBox ID="T_Originator" class="field_format" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="L_SubmitDate" class="label_format" runat="server" Text="Submit Date:"></asp:Label>
            <asp:TextBox ID="T_SubmitDate" class="field_format" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="L_Summary" class="label_format" runat="server" Text="Summary:"></asp:Label>
            <asp:TextBox ID="T_Summary" class="field_format_long" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="L_Severity" class="label_format" runat="server" Text="Severity:"></asp:Label>
            <asp:DropDownList ID="DD_Severity" class="field_format" runat="server" DataSourceID="getSeverity" DataTextField="SEVERITY_DESCRIPTION" DataValueField="DIMID_SEVERITY" AppendDataBoundItems="true">
                <asp:ListItem>Select Severity</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="getSeverity" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT [DIMID_SEVERITY], [SEVERITY_DESCRIPTION] FROM [SEVERITY]"></asp:SqlDataSource>      
            <asp:Label ID="L_Attachment" class="label_format" runat="server" Text="Attachment"></asp:Label>
            <asp:FileUpload ID="FU_Attachment" class="field_format" runat="server" />
        </div>        
        
        <div class="float_right">
            <asp:Label ID="L_Product" class="label_format" runat="server" Text="Product:"></asp:Label>
            <asp:DropDownList ID="DD_Product" class="field_format" runat="server" DataSourceID="getProduct" DataTextField="PRODUCT_NAME" DataValueField="PRODUCT_NAME" AppendDataBoundItems="true">
                <asp:ListItem>Select Product</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="getProduct" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT [PRODUCT_NAME], [DIMID_PRODUCT] FROM [PRODUCT]"></asp:SqlDataSource>
            <asp:Label ID="L_Version" class="label_format" runat="server" Text="Version:"></asp:Label>
            <asp:TextBox ID="T_Version" class="field_format" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="L_Platform" class="label_format" runat="server" Text="Platform:"></asp:Label>
            <asp:DropDownList ID="DD_Platform" class="field_format" runat="server" DataSourceID="PlatformDataSource" DataTextField="PLATFORM_DESCRIPTION" DataValueField="DIMID_PLATFORM" AppendDataBoundItems="true">
                <asp:ListItem>Select Platform</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="PlatformDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT [DIMID_PLATFORM], [PLATFORM_DESCRIPTION] FROM [PLATFORM]"></asp:SqlDataSource>
            <br />
            <asp:Label ID="L_OS" class="label_format" runat="server" Text="Operating System:"></asp:Label>
            <asp:DropDownList ID="DD_OS" class="field_format" runat="server" DataSourceID="getOS" DataTextField="OS_DESCRIPTION" DataValueField="DIMID_OS" AppendDataBoundItems="true">
                <asp:ListItem>Select OS</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="getOS" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT * FROM [OPERATING_SYSTEM]"></asp:SqlDataSource>
            <br />
            <asp:Label ID="L_Browser" class="label_format" runat="server" Text="Browser:"></asp:Label>
            <asp:DropDownList ID="DD_Browser" class="field_format" runat="server" DataSourceID="getBrowser" DataTextField="BROWSER_DESCRIPTION" DataValueField="DIMID_BROWSER" AppendDataBoundItems="true">
                <asp:ListItem>Select Browser</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="getBrowser" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT [DIMID_BROWSER], [BROWSER_DESCRIPTION] FROM [BROWSER]"></asp:SqlDataSource>
        </div>

        <br />
        <div class="float_clear">
            <asp:Label ID="L_Details" class="label_format" runat="server" Text="Details:"></asp:Label>
            <asp:TextBox ID="T_Details" TextMode="MultiLine" Rows="5" width="100%" runat="server"></asp:TextBox>
        </div>
        <div class=".text-center">
            <asp:Button ID="NewDefect_Submit" CssClass="btn-default" runat="server" Text="Submit" OnClick="NewDefect_Submit_Click"  />
            <asp:SqlDataSource ID="DefTrackConnectionString" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT * FROM [DEFECT]"></asp:SqlDataSource>
        </div>

    </div>
    </asp:Panel>

    <asp:Panel ID="Successful_Post" class="formbody" runat="server">
        <asp:SqlDataSource ID="getDefectID"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>"
        SelectCommand="SELECT REPLICATE('0',4-LEN(A.DEFECT)) + RTRIM(A.DEFECT) AS DEFECT_ID,
                            A.SUMMARY AS SUMMARY
                        FROM 
                            (                                   
                        SELECT TOP 1 DIMID_DEFECT AS DEFECT,
                            SUMMARY
                        FROM DEFECT
                        ORDER BY DIMID_DEFECT DESC
	                        ) A"></asp:SqlDataSource>


    <div class="Successful">
        <h2>You New Defect was successfully logged.</h2>
        <h4><asp:ListView ID="ListView2" runat="server" DataSourceID="getDefectID">
                <AlternatingItemTemplate>
                    <td runat="server" style="">Defect ID#:
                        <asp:Label ID="DEFECT_IDLabel" runat="server" Text='<%# Eval("DEFECT_ID") %>' />
                        <br />Summary:  <asp:Label ID="DEFECT_SUMMARY_LABEL" runat="server" Text='<%# Eval("SUMMARY") %>' />
                        <br />
                    </td>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <td runat="server" style="">Defect ID#:
                        <asp:TextBox ID="DEFECT_IDTextBox" runat="server" Text='<%# Bind("DEFECT_ID") %>' />
                         <br />Summary:  <asp:Label ID="DEFECT_SUMMARY_LABEL" runat="server" Text='<%# Bind("SUMMARY") %>' />
                        <br />
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                    </td>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table style="">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <td runat="server" style="">Defect ID#:
                        <asp:TextBox ID="DEFECT_IDTextBox" runat="server" Text='<%# Bind("DEFECT_ID") %>' />
                         <br />Summary:  <asp:Label ID="DEFECT_SUMMARY_LABEL" runat="server" Text='<%# Bind("SUMMARY") %>' />
                        <br />
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                    </td>
                </InsertItemTemplate>
                <ItemTemplate>
                    <td runat="server" style="">Defect ID#:
                        <asp:Label ID="DEFECT_IDLabel" runat="server" Text='<%# Eval("DEFECT_ID") %>' />
                        <br />Summary:  <asp:Label ID="DEFECT_SUMMARY_LABEL" runat="server" Text='<%# Bind("SUMMARY") %>' />
                        <br />
                    </td>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server" border="0" style="">
                        <tr id="itemPlaceholderContainer" runat="server">
                            <td id="itemPlaceholder" runat="server"></td>
                        </tr>
                    </table>
                    <div style="">
                    </div>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <td runat="server" style="">DEFECT_ID:
                        <asp:Label ID="DEFECT_IDLabel" runat="server" Text='<%# Eval("DEFECT_ID") %>' />
                        <br />
                    </td>
                </SelectedItemTemplate>
            </asp:ListView> 
        </h4>
    </div>
    </asp:Panel>

</asp:Content>
