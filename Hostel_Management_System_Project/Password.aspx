<%@ Page Title="" Language="C#" MasterPageFile="~/AuthSite.Master" AutoEventWireup="true" CodeBehind="Password.aspx.cs" Inherits="Hostel_Management_System_Project.Password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Reset Password
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5">
                    <div class="card shadow-lg border-0 rounded-lg mt-5">
                        <div class="card-header"><h3 class="text-center font-weight-light my-4">Password Recovery</h3></div>
                        <div class="card-body">
                            <div class="small mb-3 text-muted">Enter email address, we will send a link to reset your password.</div>
                            <form>
                                <div class="form-floating mb-3">
                                    <input class="form-control" id="inputEmail" type="email" placeholder="name@example.com" />
                                    <label for="inputEmail">Email address</label>
                                </div>
                                <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                    <a class="small" href="Login.aspx">Return to login</a>
                                    <a class="btn btn-primary" href="Login.aspx">Reset Password</a>
                                </div>
                            </form>
                        </div>
                        <div class="card-footer text-center py-3">
                            <%--<div class="small"><a href="StudentRegister.aspx">Sign Up as a Student</a></div>
                            <div class="small"><a href="ParentRegister.aspx">Sign Up as a Parent</a></div>--%>
                                <div class="container">
                                <div class="row">
                                    <div class="col-md-6">
                                        <a href="StudentRegister.aspx" class="btn btn-danger btn-block">Sign Up as a Student</a>
                                    </div>
                                    <div class="col-md-6">
                                        <a href="ParentRegister.aspx" class="btn btn-success btn-block">Sign Up as a Parent</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
