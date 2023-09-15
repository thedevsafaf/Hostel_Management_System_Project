<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ViewRefundNotifications.aspx.cs" Inherits="Hostel_Management_System_Project.ViewRefundNotifications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - User Refund Request Notifications
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
    <h2 class="text-primary">Refund Notifications</h2>
    <div class="row">
        <asp:Repeater ID="RefundNotificationsRepeater" runat="server">
            <ItemTemplate>
                <div class="col-md-6 mb-1">
                    <div class="card">
                        <div class="card-body">
                            <p class="card-title"><b><%# Eval("message") %></b></p>
                            <p class="card-text">Created At: <%# Eval("created_at", "{0:yyyy-MM-dd HH:mm:ss}") %></p>
                              <td>
                                  <%--CommandArgument='<%# Eval("payment_id") %>' --%>
                                <asp:Button ID="btn_PayBack" runat="server" CssClass="btn btn-primary" Text="PAY BACK"    />
                            </td>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

</asp:Content>
