<%@ Page Title="" Language="C#" MasterPageFile="~/StudentSite.Master" AutoEventWireup="true" CodeBehind="S_RequestRefund.aspx.cs" Inherits="Hostel_Management_System_Project.S_RequestRefund" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Request Refund
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

             <%-- no data found error msg alert --%>
            <asp:Panel ID="noResultsMessage" runat="server" CssClass="alert alert-warning" Visible="false">
                No refunds available.
            </asp:Panel>

            <%--attendance table data--%>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    Student <%= Session["name"] %>'s Cancelled Payments
                </div>
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <asp:Repeater ID="RefundPaymentRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Sl No</th>
                                            <th>Payment ID</th>
                                            <th>Amount</th>
                                            <th>Booked Room No</th>
                                            <th>Booking Status</th>
                                            <th>Booking Date</th>
                                            <th>Payment Date</th>
                                            <th>Request Refund</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("SerialNumber") %></td>
                                    <td><%# Eval("payment_id") %></td>
                                    <td><%# Eval("amount") %></td>
                                    <td><%# Eval("booked_room_no") %></td>
                                    <td><%# Eval("booking_status") %></td>
                                    <td><%# Eval("payment_date", "{0:dd-MM-yyyy}") %></td>
                                    <td><%# Eval("booking_date", "{0:dd-MM-yyyy}") %></td>
                                    <td>
                                        <asp:Button ID="btn_Refund" runat="server" CssClass="btn btn-success" Text="REFUND"  CommandArgument='<%# Eval("payment_id") %>' OnClick="btn_Refund_Click"  />
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
