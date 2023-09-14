<%@ Page Title="" Language="C#" MasterPageFile="~/StudentSite.Master" AutoEventWireup="true" CodeBehind="PaymentSuccess.aspx.cs" Inherits="Hostel_Management_System_Project.PaymentSuccess" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Payment Successful
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main> 
        <div class="success-container py-5 bg-custom-grey">
            <div id="success-message" class="success-message text-success">Success!</div>
            <div id="thanks-message" class="thanks-message text-primary">Thanks for your Payment!</div>
        </div>
    </main>
</asp:Content>
