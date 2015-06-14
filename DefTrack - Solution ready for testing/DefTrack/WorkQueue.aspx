<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WorkQueue.aspx.cs" Inherits="DefTrack.WorkQueue" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron2">
        <h2>Active Work Queue:</h2>  
    </div>

    <asp:Panel ID="NewDefectsPanel" cssClass="formbody" runat="server">
        <h4>New Defect Submissions:</h4>
        <asp:GridView ID="GridView1" cssClass="grid_layout" runat="server" AllowSorting="True" OnSorting="GridView1_Sorting">

            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="ID#" DataNavigateUrlFormatString="AssignDefect.aspx?Queue=PM&DEFECT_ID={0}" HeaderText="" Text="Edit" />
            </Columns>

        </asp:GridView>       
    </asp:Panel>
    <br />
    <asp:Panel ID="PriorityDefinedPanel" cssClass="formbody" runat="server">
        <h4>Lead Developer Queue:</h4>
        <asp:GridView ID="GridView4" cssClass="grid_layout" runat="server" AllowSorting="True" OnSorting="GridView4_Sorting">

            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="ID#" DataNavigateUrlFormatString="AssignDefect.aspx?Queue=LD&DEFECT_ID={0}" HeaderText="" Text="Edit" />
            </Columns>

        </asp:GridView>       
    </asp:Panel>
    <br />
    <asp:Panel ID="AssignedDefectsPanel" cssClass="formbody" runat="server">
        <h4>Developers Work Queue:</h4>
        <asp:GridView ID="GridView2" cssClass="grid_layout" runat="server" AllowSorting="True" OnSorting="GridView2_Sorting">

            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="ID#" DataNavigateUrlFormatString="AssignDefect.aspx?Queue=D&DEFECT_ID={0}" HeaderText="" Text="Edit" />
            </Columns>

        </asp:GridView>       
    </asp:Panel>
    
    <br />
    <asp:Panel ID="QualityControlPanel" cssClass="formbody" runat="server">
        <h4>Quality Control Review Queue:</h4>
        <asp:GridView ID="GridView3" cssClass="grid_layout" runat="server" AllowSorting="True" OnSorting="GridView3_Sorting">

            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="ID#" DataNavigateUrlFormatString="AssignDefect.aspx?Queue=QC&DEFECT_ID={0}" HeaderText="" Text="Edit" />
            </Columns>

        </asp:GridView>       
    </asp:Panel>
    <br />
    <asp:Panel ID="AwaitingCustomerPanel" cssClass="formbody" runat="server">
        <h4>Final Review Queue:</h4>
        <asp:GridView ID="GridView5" cssClass="grid_layout" runat="server" AllowSorting="True" OnSorting="GridView5_Sorting">

            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="ID#" DataNavigateUrlFormatString="AssignDefect.aspx?Queue=F&DEFECT_ID={0}" HeaderText="" Text="Edit" />
            </Columns>

        </asp:GridView>       
    </asp:Panel>

    


</asp:Content>
