<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ViewClosedComplaintsList.aspx.cs" Inherits="Hostel_Management_System_Project.ViewClosedComplaintsList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Closed Complaints List
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <%-- Table Information --%>

        <div class="container-fluid px-4">
            <%-- greet label --%>
            <h3 class="mt-4 text-light">Welcome, <%= Session["name"] %></h3>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Admin Dashboard</li>
            </ol>

            <%--complaints table data--%>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    Student Closed Complaints
                </div>
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <asp:Repeater ID="ClosedComplaintRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Cmp ID</th>
                                            <th>Name</th>
                                            <th>Phone</th>
                                            <th>Complaint</th>
                                            <th>Status</th>
                                            <th>Reply</th>
                                            <th>Created At</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("complaint_id") %></td>
                                    <td><%# Eval("st_name") %></td>
                                    <td><%# Eval("st_phone") %></td>
                                    <td><%# Eval("complaint") %></td>
                                    <td><%# Eval("complaint_status") %></td>
                                    <td><%# Eval("reply") %></td>
                                    <td><%# Eval("created_at") %></td>
                                     <td>
                                        <asp:Button ID="btn_Reopen" runat="server" CssClass="btn btn-secondary" Text="REOPEN"  CommandArgument='<%# Eval("complaint_id") %>' OnClick="btn_Reopen_Click" />
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
    </main>
</asp:Content>
