<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="DefTrack._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>DefTrack</h1>
        <p class="lead">Software Development Defect Tracking Solution.</p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>New Defect</h2>
            <p>
                Submit a new softwre defect.
            </p>
            <div class="buttonholder">
                <a class="btn btn-default" href="NewDefect.aspx">Submit Defect &raquo;</a>
            </div>
        </div>
        <div class="col-md-4">
            <h2>My Work</h2>
            <p>
                Access your individual work queue.
            </p>
            <div class="buttonholder">
                <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301950">Access Work &raquo;</a>
            </div>
        </div>
        <div class="col-md-4">
            <h2>Dashboard</h2>
            <p>
                Manage all issues, access reports, monitor project.
            </p>
            <div class="buttonholder">
                <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301950">View Dashboard &raquo;</a>
            </div>
        </div>
    </div>

</asp:Content>
