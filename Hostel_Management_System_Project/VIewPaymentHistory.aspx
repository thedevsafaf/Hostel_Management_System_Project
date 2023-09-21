<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="VIewPaymentHistory.aspx.cs" Inherits="Hostel_Management_System_Project.VIewPaymentHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Payment History
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

            <%--payment table data--%>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    Payment History
                </div>
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <asp:Repeater ID="PaymentRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <%-- sl no, payment-id, student, parent, amount, payment_date, payment_status, paid_by, booking_id, booking_date, room_no, booking_status, booked_by, payment id,  
 --%>
                                            <th>Sl No</th>
                                            <th>Payment No</th>
                                            <th>Student</th>
                                            <th>Parent</th>
                                            <th>Amount</th>
                                            <th>Booking No</th>
                                            <th>Booked Room</th>
                                            <th>Booking Date</th>
                                            <th>Booking Status</th>
                                            <th>Booked By</th>
                                            <th>Payment Date</th>
                                            <th>Payment Status</th>
                                            <th>Paid By</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("sl_no") %></td>
                                    <td><%# Eval("payment_id") %></td>
                                    <td><%# Eval("st_name") %></td>
                                    <td><%# Eval("prt_name") %></td>
                                    <td>
                                        <b><span style='<%# Eval("amount", "color: " + (Convert.ToInt32(Eval("amount")) == 5000 ? "green" : "grey")) %>'><%# Eval("amount") %></span></b>
                                    </td>
                                    <td><%# Eval("booking_id") %></td>
                                    <td><%# Eval("room_no") %></td>
                                    <td><%# Eval("booking_date", "{0:dd-MM-yyyy}") %></td>
                                    <td><%# Eval("status") %></td>
                                    <td><%# Eval("booked_by") %></td>
                                    <td><%# Eval("payment_date", "{0:dd-MM-yyyy}") %></td>
                                    <td>
                                        <asp:Label ID="lbl_Status" runat="server" Text='<%# Eval("payment_status") %>' CssClass='<%# GetStatusCssClass(Eval("payment_status").ToString())+ " bold-status" %>'></asp:Label>
                                    </td>
                                    <td><%# Eval("paid_by") %></td>
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
