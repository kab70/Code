<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="DefTrack.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
   <p>Welcome to DefTrack.  System is designed for the management of Software Defect Tracking.</p>
    <p>New software defects are submited to DefTrack which starts the workflow of:</p>
    <ol>
        <li>Defect review by Project Manager and assigned a priority</li>
        <li>Lead Develop reviews defects and assigns to appropriate developer</li>
        <li>Developer manages their work queue and resolves assigned defects</li>
        <li>Quality Control reviews work queues and tests defect fixes</li>
    </ol>

</asp:Content>
