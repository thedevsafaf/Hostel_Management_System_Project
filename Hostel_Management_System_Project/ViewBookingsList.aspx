<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ViewBookingsList.aspx.cs" Inherits="Hostel_Management_System_Project.ViewBookingsList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Room Bookings List
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
                     Students Room Booking
                </div>
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <asp:Repeater ID="BookingRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Sl No</th>
                                            <th>Roll No</th>
                                            <th>Student</th>
                                            <th>Parent</th>
                                            <th>Booking No</th>
                                            <th>Booking Date</th>
                                            <th>Booking Status</th>
                                            <th>Room No</th>
                                            <th>Booked By</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("SerialNumber") %></td>
                                    <td><%# Eval("student_id") %></td>
                                    <td><%# Eval("st_name") %></td>
                                    <td><%# Eval("pt_name") %></td>
                                    <td><%# Eval("booking_id") %></td>
                                    <td><%# Eval("booking_date", "{0:dd-MM-yyyy}") %></td>
                                    <td>
                                        <asp:Label ID="lbl_Status" runat="server" Text='<%# Eval("booking_status") %>' CssClass='<%# GetStatusCssClass(Eval("booking_status").ToString())+ " bold-status" %>'></asp:Label>
                                    </td>
                                    <td><%# Eval("room_no") %></td>
                                    <td><%# Eval("booked_by") %></td>
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
