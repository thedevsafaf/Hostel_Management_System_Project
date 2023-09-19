<%@ Page Title="" Language="C#" MasterPageFile="~/AuthSite.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Hostel_Management_System_Project.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS Portal - Login
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <main>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5">
                    <div class="card shadow-lg border-0 rounded-lg mt-3">
                        <div class="card-header"><h3 class="text-center font-weight-light my-4">Login</h3></div>
                        <div class="card-body">
                            <div class="form-floating mb-3">
                                <asp:TextBox ID="tb_Email" runat="server" CssClass="form-control" placeholder="name@example.com"></asp:TextBox>
                                <label for="tb_Email">Email address&nbsp;
                                    <asp:RequiredFieldValidator ID="rfv_Email" runat="server" ControlToValidate="tb_Email" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                </label>
<%--                                &nbsp;<asp:RegularExpressionValidator ID="rev_Email" runat="server" ControlToValidate="tb_Email" ErrorMessage="Invalid Email Address!" Font-Size="Small" ForeColor="Red" style="font-weight: 700" ValidationExpression="^[a-z0-9][-a-z0-9._]+@([-a-z0-9]+.)+[a-z]{2,5}$"></asp:RegularExpressionValidator>
                                &nbsp;--%>
                            </div>
                            <div class="form-floating mb-3">
                                <asp:TextBox ID="tb_Password" runat="server" CssClass="form-control" placeholder="Password" type="password"></asp:TextBox>
                                <label for="tb_Password">Password&nbsp;
                                    <asp:RequiredFieldValidator ID="rfv_Password" runat="server" ControlToValidate="tb_Password" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                </label>
                                &nbsp;<asp:RegularExpressionValidator ID="rev_Password" runat="server" ControlToValidate="tb_Password" ErrorMessage="Password length => 8 or less chars!" Font-Size="Small" ForeColor="Red" style="font-weight: 700" ValidationExpression="^.{1,8}$"></asp:RegularExpressionValidator>
                                &nbsp;
                            </div>
                            <div class="form-check mb-1">
                                <input type="checkbox" id="showPassword" class="form-check-input" />
                                <label for="showPassword" class="form-check-label">Show Password</label>
                            </div>

                                <div class="my-3">
                                <div class="d-grid mb-2"><asp:Button ID="btn_Login" runat="server" Text="Login" class="btn btn-primary" onClick="btn_Login_Click"/></div>
                                    <a class="small" href="Password.aspx">Forgot Password?</a>
                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="card-footer text-center py-3">
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

    <%-- swal for login errors --%>
    <script type="text/javascript">
        function ShowInvalidCredsErrorAlert() {
            Swal.fire({
                icon: 'error',
                title: 'Login Failed',
                text: 'Invalid credentials! Try Again!',
            });
        }
        function ShowApprovalErrorAlert() {
            Swal.fire({
                icon: 'error',
                title: 'Login Failed',
                text: 'Admin Approval Required!',
            });
        }
    </script>


    <%-- function to show or hide the password entered  --%>
    <script>
        document.getElementById("showPassword").addEventListener("change", function () {
            var passwordField = document.getElementById("<%= tb_Password.ClientID %>");

            if (this.checked) {
                passwordField.type = "text";
            } else {
                passwordField.type = "password";
            }
        });
    </script>


</asp:Content>
