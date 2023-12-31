﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AuthSite.Master" AutoEventWireup="true" CodeBehind="ParentRegister.aspx.cs" Inherits="Hostel_Management_System_Project.ParentRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Parent SignUp
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="card shadow-lg border-0 rounded-lg mt-2">
                        <div class="card-header">
                            <h3 class="text-center font-weight-light my-4">Create Parent Account</h3>
                        </div>
                        <div class="card-body">

                            <div class="row mb-1">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_Name" runat="server" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
                                        <label for="tb_Name">
                                            Full Name
                                                            <asp:RequiredFieldValidator ID="rfv_Name" runat="server" ControlToValidate="tb_Name" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                        </label>
                                        &nbsp;<asp:RegularExpressionValidator ID="rev_Name" runat="server" ControlToValidate="tb_Name" ErrorMessage="Invalid Name!" Font-Size="Small" ForeColor="Red" Style="font-weight: 700" ValidationExpression="^[A-Za-z\s'\-]+$"></asp:RegularExpressionValidator>
                                        &nbsp;
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_Email" runat="server" CssClass="form-control" placeholder="name@example.com"></asp:TextBox>
                                        <label for="tb_Email">
                                            Email Address
                                                             <asp:RequiredFieldValidator ID="rfv_Email" runat="server" ControlToValidate="tb_Email" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                        </label>
                                        &nbsp;<asp:RegularExpressionValidator ID="rev_Email" runat="server" ControlToValidate="tb_Email" ErrorMessage="Invalid Email Address!" Font-Size="Small" ForeColor="Red" Style="font-weight: 700" ValidationExpression="^[a-z0-9][-a-z0-9._]+@([-a-z0-9]+.)+[a-z]{2,5}$"></asp:RegularExpressionValidator>
                                        &nbsp;
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-1">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_Phone" runat="server" CssClass="form-control" placeholder="Enter your phone no"></asp:TextBox>
                                        <label for="tb_Phone">
                                            Phone Number
                                                             <asp:RequiredFieldValidator ID="rfv_Phone" runat="server" ControlToValidate="tb_Phone" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                        </label>
                                        <asp:RegularExpressionValidator ID="rev_Phone" runat="server" ControlToValidate="tb_Phone" ErrorMessage="Invalid Phone Number!" Font-Size="Small" ForeColor="Red" Style="font-weight: 700" ValidationExpression="^[6-9]\d{9}$"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_StudentID" runat="server" CssClass="form-control" placeholder="Enter your Student ID"></asp:TextBox>
                                        <label for="tb_StudentID">
                                            Student Roll No
                                                             <asp:RequiredFieldValidator ID="rfv_StudentID" runat="server" ControlToValidate="tb_StudentID" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                        </label>
                                        <asp:RegularExpressionValidator ID="rev_StudentID" runat="server" ErrorMessage="Invalid Student ID" ControlToValidate="tb_StudentID" Font-Size="Small" ForeColor="Red" Style="font-weight: 700" ValidationExpression="^[0-9]*$"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-1">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_Password" runat="server" CssClass="form-control" placeholder="Create a Password" type="password"></asp:TextBox>
                                        <label for="tb_Password">
                                            Password
                                                             <asp:RequiredFieldValidator ID="rfv_Password" runat="server" ControlToValidate="tb_Password" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                        </label>
                                        &nbsp;<asp:RegularExpressionValidator ID="rev_Password" runat="server" ControlToValidate="tb_Password" ErrorMessage="Password length => 8 or less chars!" Font-Size="Small" ForeColor="Red" Style="font-weight: 700" ValidationExpression="^.{1,8}$"></asp:RegularExpressionValidator>
                                        &nbsp;
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_ConfirmPassword" runat="server" CssClass="form-control" placeholder="Confirm Password" type="password"></asp:TextBox>
                                        <label for="tb_ConfirmPassword">
                                            Confirm Password
                                                             <asp:RequiredFieldValidator ID="rfv_ConfirmPassword" runat="server" ControlToValidate="tb_ConfirmPassword" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                        </label>
                                        &nbsp;<asp:CompareValidator ID="cv_ConfirmPassword" runat="server" ErrorMessage="This should be same as Password field!" ControlToCompare="tb_Password" ControlToValidate="tb_ConfirmPassword" Font-Size="Small" ForeColor="Red" Style="font-weight: 700"></asp:CompareValidator>
                                        &nbsp;
                                    </div>
                                </div>
                            </div>
                            <div class="form-check mb-3">
                                <input type="checkbox" id="showPassword" class="form-check-input" />
                                <label for="showPassword" class="form-check-label">Show Password</label>
                            </div>


                            <div class="mb-0">
                                <div class="d-grid">
                                    <asp:Button ID="btn_Signup" CssClass="btn btn-primary btn-block" runat="server" Text="Create Account" OnClick="btn_Signup_Click" />
                                </div>
                            </div>

                        </div>
                        <div class="card-footer text-center py-3">
                            <div class="small"><a href="Login.aspx">Have an account? Go to login</a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

     <%-- function to show alerts on successful & failed registration --%>

    <script type="text/javascript">
        function ShowSuccessAlert() {
            Swal.fire({
                icon: 'success',
                title: 'Registration Successful',
                text: 'Your account has been created successfully!',
                showConfirmButton: false,
                timer: 2000
            });
            setTimeout(function () {
                console.log("Redirecting to login page...");
                window.location.href = 'Login.aspx';
            }, 2000);
        }

        function ShowErrorAlert() {
            Swal.fire({
                icon: 'error',
                title: 'Registration Failed',
                text: 'An error occurred during registration. Please try again later.',
            });
        }
    </script>

     <script>
            //function to show or hide the password entered 
            document.getElementById("showPassword").addEventListener("change", function () {
                var passwordField = document.getElementById("<%= tb_Password.ClientID %>");
                var confirmPasswordField = document.getElementById("<%= tb_ConfirmPassword.ClientID %>");

                if (this.checked) {
                    passwordField.type = "text";
                    confirmPasswordField.type = "text";
                } else {
                    passwordField.type = "password";
                    confirmPasswordField.type = "password";
                }
            });
     </script>


</asp:Content>
