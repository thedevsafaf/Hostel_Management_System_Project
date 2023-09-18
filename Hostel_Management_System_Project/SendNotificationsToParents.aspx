<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="SendNotificationsToParents.aspx.cs" Inherits="Hostel_Management_System_Project.SendNotificationsToParents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
       Zafe HMS - Send Notifications to Parents
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="card shadow-lg border-0 rounded-lg mt-2">
                        <div class="card-header">
                            <h3 class="text-center font-weight-light my-4">Send Notifications to Parents</h3>
                        </div>
                        <div class="card-body py-3">
                            <div class="row mb-3">
                                <div class="col-md-12">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_Message" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Enter your notification message"></asp:TextBox>
                                        <label for="tb_Message">
                                            Notification Message
                                                <asp:RequiredFieldValidator ID="rfv_Message" runat="server" ControlToValidate="tb_Message" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-12">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:DropDownList ID="ddl_Recipient" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="All Parents" Value="Select All" />
                                            <asp:ListItem Text="Select Parent" Value="Select Any Parent" />
                                        </asp:DropDownList>
                                        <label for="ddl_Recipient">Select All for (Group Notifications) | Select Parent for (Individual Notifications)</label>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-0">
                                <div class="d-grid">
                                    <asp:Button ID="btn_SendNotification" CssClass="btn btn-primary btn-block" runat="server" Text="Send Notification" OnClick="btn_SendNotification_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
