﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ViewParentRefundNotifications.aspx.cs" Inherits="Hostel_Management_System_Project.ViewParentRefundNotifications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Parent Refund Request Notifications
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2 class="text-light">Parent Refund Requests</h2>
        <div class="row">
            <asp:Repeater ID="RefundNotificationsRepeater" runat="server">
                <itemtemplate>
                    <div class="col-md-6 mb-1">
                        <div class="card">
                            <div class="card-body">
                                <asp:HiddenField ID="hfPaymentId" runat="server" Value='<%# Eval("payment_id") %>' />
                                <p class="card-title"><b><%# Eval("message") %></b></p>
                                <p class="card-text">Created At: <%# Eval("created_at", "{0:yyyy-MM-dd HH:mm:ss}") %></p>
                                <td>
                                    <asp:Button ID="btn_PayBack" runat="server" CssClass="btn btn-primary"
                                        Text='<%# Eval("payment_status").ToString() == "Refunded" ? "PAID" : "PAY BACK" %>'
                                        OnClick="btn_PayBack_Click" CommandArgument='<%# Eval("payment_id") %>' Enabled='<%# Eval("payment_status").ToString() != "Refunded" %>' />
                                </td>
                            </div>
                        </div>
                    </div>
                </itemtemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
