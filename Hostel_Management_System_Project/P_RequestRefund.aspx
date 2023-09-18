<%@ Page Title="" Language="C#" MasterPageFile="~/ParentSite.Master" AutoEventWireup="true" CodeBehind="P_RequestRefund.aspx.cs" Inherits="Hostel_Management_System_Project.P_RequestRefund" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Parent Request Refund
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
                No refunds available.
            </asp:Panel>

            <%--refund table data--%>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    Parent <%= Session["name"] %>'s Cancelled Payments
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
                                            <th>Date Booked</th>
                                            <th>Booking Status</th>
                                            <th>Date Paid</th>
                                            <th>Payment Status</th>
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
                                    <td><%# Eval("booking_date", "{0:dd-MM-yyyy}") %></td>
                                    <td><%# Eval("booking_status") %></td>
                                    <td><%# Eval("payment_date", "{0:dd-MM-yyyy}") %></td>
                                    <td><%# Eval("payment_status") %></td>
                                    <td>
                                        <asp:Button ID="btn_Refund" runat="server" CssClass="btn btn-success" Text="REFUND"  CommandArgument='<%# Eval("payment_id") %>' OnClick="btn_Refund_Click" ToolTip="You will get your money back within 2 Bank Working Days" />
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
