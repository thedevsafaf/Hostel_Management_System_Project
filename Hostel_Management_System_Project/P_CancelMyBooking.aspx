<%@ Page Title="" Language="C#" MasterPageFile="~/ParentSite.Master" AutoEventWireup="true" CodeBehind="P_CancelMyBooking.aspx.cs" Inherits="Hostel_Management_System_Project.P_CancelMyBooking" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Cancel Parent Room Booking
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

            <%--attendance table data--%>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    Cancel Student <%= Session["name"] %>'s Room Booking
                </div>
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <asp:Repeater ID="BookingRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Sl No</th>
                                            <th>Booking ID</th>
                                            <th>Booking Date</th>
                                            <th>Room No</th>
                                            <th>Room Description</th>
                                            <th>Booking Status</th>
                                            <th>Actions</th>
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
                                    <td><%# Eval("room_desc") %></td>
                                    <td><%# Eval("booking_status") %></td>
                                    <td>
                                        <asp:Button ID="btn_Cancel" runat="server" CssClass="btn btn-danger" Text="CANCEL"  CommandArgument='<%# Eval("booking_id") %>' OnClick="btn_Cancel_Click" />
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
