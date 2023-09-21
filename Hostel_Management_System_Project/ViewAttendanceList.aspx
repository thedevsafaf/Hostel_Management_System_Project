<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ViewAttendanceList.aspx.cs" Inherits="Hostel_Management_System_Project.ViewAttendanceList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Students Attendance List
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

             <%-- no data found error msg alert --%>
            <asp:Panel ID="noResultsMessage" runat="server" CssClass="alert alert-warning" Visible="false">
                No result found.
            </asp:Panel>

            <%--attendance table data--%>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    Students Attendance
                </div>
                <div class="card-body bg-dark">
                     <!-- Search Box & Filter DD -->
                    <div class="row mb-3">
                        <div class="col-md-3">
                            <asp:DropDownList ID="statusFilter" runat="server" CssClass="form-control dropdown-icon">
                                <asp:ListItem Text="Filter by Status" Value="" />
                                <asp:ListItem Text="Present" Value="Present" />
                                <asp:ListItem Text="Absent" Value="Absent" />
                            </asp:DropDownList>
                        </div>
                         <div class="col-md-2">
                            <asp:Button ID="filterButton" runat="server" CssClass="btn btn-primary btn-block" Text="Filter" OnClick="FilterButton_Click" />
                        </div>
                        <div class="col-md-3">
                            <asp:TextBox ID="searchInput" runat="server" CssClass="form-control" placeholder="Search by Student ID or Name" />
                        </div>
                        <div class="col-md-2">
                            <asp:Button ID="searchButton" runat="server" CssClass="btn btn-primary btn-block" Text="Search here" OnClick="SearchButton_Click" />
                        </div>
                    </div>
                    <!-- Search Box & Filter DD -->
                    <div class="table-responsive">
                        <asp:Repeater ID="AttendanceRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Sl No</th>
                                            <th>Student ID</th>
                                            <th>Student Name</th>
                                            <th>Date</th>
                                            <th>Status</th>
                                            <th>Created At</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("SerialNumber") %></td>
                                    <td><%# Eval("student_id") %></td>
                                    <td><%# Eval("st_name") %></td>
                                    <td><%# Eval("date", "{0:dd-MM-yyyy}") %></td>
                                    <td>
                                       <%-- <%# Eval("status") %>--%>
                                        <asp:Label ID="lbl_Status" runat="server" Text='<%# Eval("status") %>' CssClass='<%# GetStatusCssClass(Eval("status").ToString())+ " bold-status" %>'></asp:Label>
                                    </td>
                                    <td><%# Eval("created_at") %></td>
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
