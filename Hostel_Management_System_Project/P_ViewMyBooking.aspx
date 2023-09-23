<%@ Page Title="" Language="C#" MasterPageFile="~/ParentSite.Master" AutoEventWireup="true" CodeBehind="P_ViewMyBooking.aspx.cs" Inherits="Hostel_Management_System_Project.P_ViewMyBooking" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
     Zafe HMS -  <%= Session["name"] %>'s Room Booking
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <%-- Table Information --%>

        <div class="container-fluid px-4">
            <%-- greet label --%>
            <h3 class="mt-4 text-light">Welcome, <%= Session["name"] %></h3>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Parent Dashboard</li>
            </ol>

             <%-- no data found error msg alert --%>
            <asp:Panel ID="noResultsMessage" runat="server" CssClass="alert alert-warning" Visible="false">
                No result found.
            </asp:Panel>

            <%--room booking table data--%>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    Parent <%= Session["name"] %>'s and Child Room Booking
                </div>
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <asp:Repeater ID="BookingRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Sl No</th>
                                            <th>Booking No</th>
                                            <th>Booking Date</th>
                                            <th>Room No</th>
                                            <th>Room Description</th>
                                            <th>Payment Actions</th>
                                            <th>Booked By</th>
                                            <th>Booking Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("SerialNumber") %></td>
                                    <td><%# Eval("booking_id") %></td>
                                    <td><%# Eval("booking_date", "{0:dd-MM-yyyy}") %></td>
                                    <td><%# Eval("room_no") %></td>
                                    <td><%# Eval("room_desc").ToString().Length > 60 ? Eval("room_desc").ToString().Substring(0, 60) + "..." : Eval("room_desc") %></td>
                                     <td>
                                         <%# Eval("booking_status").ToString() == "Auto Cancelled" ? "Not Paid" :
                                             Eval("booking_status").ToString() == "Cancelled" || Eval("booking_status").ToString() == "Cancelled by Admin" ? "Refundable" :
                                             Eval("booking_status").ToString() == "Confirmed" ? "Paid" : "-" %>
                                    </td>
                                    <td><%# Eval("booked_by") %></td>
                                    <td><asp:Label ID="lbl_Status" runat="server" Text='<%# Eval("booking_status") %>' CssClass='<%# GetStatusCssClass(Eval("booking_status").ToString())+ " bold-status" %>'></asp:Label></td>
                                   
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
