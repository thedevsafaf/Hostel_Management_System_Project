<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ViewStaffsList.aspx.cs" Inherits="Hostel_Management_System_Project.ViewStaffsList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Staffs List
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container-fluid px-4">

            <%-- greet label --%>
            <h3 class="mt-4 text-light">Welcome, <%= Session["name"] %></h3>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Admin Dashboard</li>
            </ol>


            <%--staffs table data--%>

            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    StaffsList
                </div>
                <div class="card-body bg-dark">
                    <!-- Search Box & Filter DD -->
                    <%--<div class="row mb-3">
                        <div class="col-md-3">
                            <asp:DropDownList ID="statusFilter" runat="server" CssClass="form-control dropdown-icon">
                                <asp:ListItem Text="Filter by Status" Value="" />
                                <asp:ListItem Text="Approved" Value="Approved" />
                                <asp:ListItem Text="Pending" Value="Pending" />
                                <asp:ListItem Text="Rejected" Value="Rejected" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <asp:Button ID="filterButton" runat="server" CssClass="btn btn-primary btn-block" Text="Filter" OnClick="FilterButton_Click" />
                        </div>
                        <div class="col-md-3">
                            <asp:TextBox ID="searchInput" runat="server" CssClass="form-control" placeholder="Search by Name, Email, Phone" />
                        </div>
                        <div class="col-md-2">
                            <asp:Button ID="searchButton" runat="server" CssClass="btn btn-primary btn-block" Text="Search here" OnClick="SearchButton_Click" />
                        </div>
                    </div>--%>
                    <!-- Search Box & Filter DD -->
                    <div class="table-responsive">
                        <asp:Repeater ID="StaffRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Staff ID</th>
                                            <th>Name</th>
                                            <th>Role</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Created At</th>
                                            <%--<th>Edit</th>
                                            <th>Delete</th>--%>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("staff_id") %></td>
                                    <td><%# Eval("staff_name") %></td>
                                    <td><%# Eval("staff_role") %></td>
                                    <td><%# Eval("staff_email") %></td>
                                    <td><%# Eval("staff_phone_number") %></td>
                                    <td><%# Eval("created_at") %></td>
                                    <%--<td>
                                        <asp:Button ID="btn_Edit" runat="server" CssClass="btn btn-success" Text="EDIT" OnClick="EditStudent_Click" CommandArgument='<%# Eval("student_id") %>' />
                                    </td>
                                    <td>
                                        <asp:Button ID="btn_Delete" runat="server" CssClass="btn btn-danger" Text="DELETE" CommandArgument='<%# Eval("student_id") %>' data-student-id='<%# Eval("student_id") %>' OnClientClick="return confirmDelete(this);" />
                                    </td>--%>
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
