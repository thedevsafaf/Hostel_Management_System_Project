<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ViewExpiredBookingsList.aspx.cs" Inherits="Hostel_Management_System_Project.ViewExpiredBookingsList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Expired Bookings
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div class="container-fluid px-4">

            <%-- greet label --%>
            <h3 class="mt-4 text-light">Welcome, <%= Session["name"] %></h3>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Admin Dashboard</li>
            </ol>

            <asp:Panel ID="userInstructions" runat="server" CssClass="alert alert-primary" Visible="true">
                <h3>Page Refreshes Every 5 Minutes for Expired Bookings</h3>
                <p>Students/parents have a 5-minute payment window after booking a hostel room.</p>
            </asp:Panel>

            <%-- no data found error msg alert --%>
            <asp:Panel ID="noResultsMessage" runat="server" CssClass="alert alert-warning" Visible="false">
                No Item found.
            </asp:Panel>


            <%--bookings list table data--%>

            <asp:Timer ID="timerExpiredBookings" runat="server" Interval="10000" OnTick="timerExpiredBookings_Tick"></asp:Timer>

            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    Expired Bookings List
                </div>
              
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <asp:Repeater ID="ExpiredBookingsRepeater" runat="server">
                            <headertemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Sl No</th>
                                            <th>Booking No</th>
                                            <th>Student</th>
                                            <th>Phone</th>
                                            <th>Room No</th>
                                            <th>Booking Date</th>
                                            <th>Booked By</th>
                                            <th>Created At</th>
                                            <th>Booking Status</th>
                                            <th>Reason</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </headertemplate>
                            <itemtemplate>
                                <tr>
                                    <td><%# Eval("sl_no") %></td>
                                    <td><%# Eval("booking_id") %></td>
                                    <td><%# Eval("name") %></td>
                                    <td><%# Eval("phone_number") %></td>
                                    <td><%# Eval("room_no") %></td>
                                    <td><%# Eval("booking_date", "{0:yyyy-MM-dd}") %></td>
                                    <td><%# Eval("booked_by") %></td>
                                    <td><%# Eval("created_at") %></td>
                                    <td><%# Eval("status") %></td>
                                    <td>Not Paid</td>
                                </tr>
                            </itemtemplate>
                            <footertemplate>
                                </tbody>
                    </table>
                            </footertemplate>
                        </asp:Repeater>

                    </div>

                </div>
            </div>
        </div>
    </main>
</asp:Content>
