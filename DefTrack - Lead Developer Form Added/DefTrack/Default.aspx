<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DefTrack._Default" %>

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
            <h2>Work Queue</h2>
            <p>
                Access your individual work queue.
            </p>
            <div class="buttonholder">
                <a class="btn btn-default" href="WorkQueue.aspx">Access Work &raquo;</a>
            </div>
        </div>
        <div class="col-md-4">
            <h2>Administration</h2>
            <p>
                System and user administration.
            </p>
            <div class="buttonholder">
                <a class="btn btn-default" href="#">Access Console &raquo;</a>
            </div>
        </div>
    </div>


</asp:Content>
