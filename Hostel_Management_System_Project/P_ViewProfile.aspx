<%@ Page Title="" Language="C#" MasterPageFile="~/ParentSite.Master" AutoEventWireup="true" CodeBehind="P_ViewProfile.aspx.cs" Inherits="Hostel_Management_System_Project.P_ViewProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Parent Details |  <%= Session["name"] %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <%-- Card Information --%>

        <div class="container px-5 mb-5">

            <%-- greet label --%>
            <h3 class="mt-4 text-light">Welcome, <%= Session["name"] %></h3>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Parent Dashboard</li>
            </ol>

            <!-- Parent Details Section -->
            <div class="mt-3 card">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    <%= Session["name"] %>'s Details
                </div>

                <div class="card-body bg-dark text-light">

                    <div class="row mb-1">
                        <div class="col-md-3">
                            <p>
                                <strong> Name: </strong>
                                <asp:Label ID="lbl_ParentName" runat="server" Text=""></asp:Label>
                            </p>
                        </div>
                        <div class="col-md-3">
                            <p>
                                <strong> Email: </strong>
                                <asp:Label ID="lbl_ParentEmail" runat="server" Text=""></asp:Label>
                            </p>
                        </div>
                        <div class="col-md-3">
                            <p>
                                <strong>Phone: </strong>
                                <asp:Label ID="lbl_ParentPhone" runat="server" Text=""></asp:Label>
                            </p>                        
                        </div>
                         <div class="col-md-3">
                            <p>
                                <strong>Created At: </strong>
                                <asp:Label ID="lbl_CreatedAt" runat="server" Text=""></asp:Label>
                            </p>                        
                        </div>
                    </div>

                    <div class="row mb-1">
                        <div class="col-md-3">
                            <p>
                                <strong>Student ID: </strong>
                                <asp:Label ID="lbl_StudentID" runat="server" Text=""></asp:Label>
                            </p>
                        </div>
                         <div class="col-md-3">
                            <p>
                                <strong>Student Name: </strong>
                                <asp:Label ID="lbl_StudentName" runat="server" Text=""></asp:Label>
                            </p>
                        </div>
                        <div class="col-md-3">
                            <p>
                                <strong>Student Email: </strong>
                                <asp:Label ID="lbl_StudentEmail" runat="server" Text=""></asp:Label>
                            </p>
                        </div>
                        <div class="col-md-3">
                            <p>
                                <strong>Student Phone: </strong>
                                <asp:Label ID="lbl_StudentPhone" runat="server" Text=""></asp:Label>
                            </p>                        
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
