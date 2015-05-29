<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="NewDefect.aspx.vb" Inherits="DefTrack.NewDefect" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    &nbsp;<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="nocsql08v"></asp:SqlDataSource>

    <div class="jumbotron2">
        <h2>Record New Defect</h2>
        <h4>Defect ID# xxxx</h4>
    </div>

    <div class="formbody">


        &nbsp;<asp:Label ID="Label5" runat="server" Text="Originator:"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label4" runat="server" Text="Submit Date:"></asp:Label>
&nbsp;<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Summary:"></asp:Label>
&nbsp;<asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label2" runat="server" Text="Severity:"></asp:Label>
&nbsp;<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="getSeverity" DataTextField="SEVERITY_DESCRIPTION" DataValueField="SEVERITY_DESCRIPTION">
        </asp:DropDownList>
        <asp:SqlDataSource ID="getSeverity" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT [SEVERITY_DESCRIPTION], [VALUE] FROM [SEVERITY]"></asp:SqlDataSource>
        <asp:Label ID="Label1" runat="server" Text="Product:"></asp:Label>
        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="getProduct" DataTextField="PRODUCT_NAME" DataValueField="PRODUCT_NAME">
        </asp:DropDownList>
        <asp:SqlDataSource ID="getProduct" runat="server" ConnectionString="<%$ ConnectionStrings:DefTrackConnectionString %>" SelectCommand="SELECT [PRODUCT_NAME], [DIMID_PRODUCT] FROM [PRODUCT]"></asp:SqlDataSource>
        <asp:Label ID="Label6" runat="server" Text="Version:"></asp:Label>
        <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label7" runat="server" Text="Platform:"></asp:Label>
        <asp:DropDownList ID="DropDownList3" runat="server">
            <asp:ListItem Value="0">Select Platform</asp:ListItem>
            <asp:ListItem>PC</asp:ListItem>
            <asp:ListItem>MAC</asp:ListItem>
            <asp:ListItem>TABLET</asp:ListItem>
            <asp:ListItem>SMART PHONE</asp:ListItem>
        </asp:DropDownList>
        <br />
        <asp:Label ID="Label8" runat="server" Text="Operating System:"></asp:Label>
        <asp:DropDownList ID="DropDownList4" runat="server">
            <asp:ListItem Value="0">Select OS</asp:ListItem>
            <asp:ListItem>Windows</asp:ListItem>
            <asp:ListItem>Mac</asp:ListItem>
            <asp:ListItem>iOS</asp:ListItem>
            <asp:ListItem>Android</asp:ListItem>
        </asp:DropDownList>
        <br />
        <asp:Label ID="Label9" runat="server" Text="Browser:"></asp:Label>
        <asp:DropDownList ID="DropDownList5" runat="server">
            <asp:ListItem Value="0">Select Browser</asp:ListItem>
            <asp:ListItem>Internet Explorer</asp:ListItem>
            <asp:ListItem>FireFox</asp:ListItem>
            <asp:ListItem>Chrome</asp:ListItem>
            <asp:ListItem>Safari</asp:ListItem>
            <asp:ListItem>Other</asp:ListItem>
        </asp:DropDownList>
        <br />


    </div>




</asp:Content>
