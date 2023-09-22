<%@ Page Title="" Language="C#" MasterPageFile="~/StudentSite.Master" AutoEventWireup="true" CodeBehind="S_ViewProfile.aspx.cs" Inherits="Hostel_Management_System_Project.S_ViewProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Student Details |  <%= Session["name"] %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>

        <%-- Table Information --%>

        <div class="container-fluid px-4">
            <%-- greet label --%>
            <h3 class="mt-4 text-light">Welcome, <%= Session["name"] %></h3>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Student Dashboard</li>
            </ol>

            <%--profile table data--%>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    <%= Session["name"] %>'s Profile
                </div>
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <asp:Repeater ID="ProfileRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Roll No</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Status</th>
                                            <th>Created At</th>
                                            <th>Update</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("student_id") %></td>
                                    <td><%# Eval("name") %></td>
                                    <td><%# Eval("email") %></td>
                                    <td><%# Eval("phone_number") %></td>
                                    <td><%# Eval("status") %></td>
                                    <td><%# Eval("created_at") %></td>
                                     <td>
                                        <asp:Button ID="btn_Edit" runat="server" CssClass="btn btn-success" Text="EDIT" OnClick="EditStudent_Click" CommandArgument='<%# Eval("student_id") %>' />
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>

        <%-- Card Information --%>

        <div class="container-fluid px-4 mb-5">
            <!-- Student Details Section -->
            <div class="mt-3 card">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    <%= Session["name"] %>'s Other Details
                </div>

                <div class="card-body bg-dark text-light">

                    <div class="row mb-1">
                        <div class="col-md-6">
                            <p>
                                <strong>Parent Name: </strong>
                                <asp:Label ID="lbl_ParentName" runat="server" Text=""></asp:Label>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p>
                                <strong>Parent Email: </strong>
                                <asp:Label ID="lbl_ParentEmail" runat="server" Text=""></asp:Label>
                            </p>
                        </div>
                    </div>

                    <div class="row mb-1">
                        <div class="col-md-6">
                            <p>
                                <strong>Parent Phone: </strong>
                                <asp:Label ID="lbl_ParentPhone" runat="server" Text=""></asp:Label>
                            </p>                        
                        </div>
                        <!-- Student Photo Section -->
                       <%-- <div class="col-md-6">
                            <p><strong>Student Photo: </strong></p>
                            <asp:Image ID="img_RoomPhoto" runat="server" CssClass="img-fluid room-image" AlternateText="Student Photo" Width="300" Height="200" />
                        </div>--%>
                    </div>
                </div>
            </div>
        </div>

    </main>
</asp:Content>
