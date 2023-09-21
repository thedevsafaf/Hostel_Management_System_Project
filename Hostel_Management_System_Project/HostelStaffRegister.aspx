<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="HostelStaffRegister.aspx.cs" Inherits="Hostel_Management_System_Project.HostelStaffRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Staff Register
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="card shadow-lg border-0 rounded-lg mt-2">
                        <div class="card-header">
                            <h3 class="text-center font-weight-light my-4">Staff Registration</h3>
                        </div>
                        <div class="card-body">
                            <div class="row mb-1">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_Name" runat="server" CssClass="form-control" placeholder="Enter staff's full name"></asp:TextBox>
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
                                        <asp:DropDownList ID="ddl_StaffRole" runat="server" CssClass="form-control dropdown-icon">
                                            <asp:ListItem Text="Select Staff Role" Value="" Disabled="disabled" Selected="True" />
                                            <asp:ListItem Text="Warden/Manager" Value="Warden/Manager" />
                                            <asp:ListItem Text="Receptionist" Value="Receptionist" />
                                            <asp:ListItem Text="Cook/Chef" Value="Cook/Chef" />
                                            <asp:ListItem Text="Security Guard" Value="Security Guard" />
                                            <asp:ListItem Text="Housekeeping Staff" Value="Housekeeping Staff" />
                                            <asp:ListItem Text="Maintenance Staff" Value="Maintenance Staff" />
                                            <asp:ListItem Text="Administrative Staff" Value="Administrative Staff" />
                                            <asp:ListItem Text="Medical Staff" Value="Medical Staff" />
                                            <asp:ListItem Text="IT Support" Value="IT Support" />
                                        </asp:DropDownList>
                                        <label for="ddl_StaffRole">Staff Role</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row mb-1">
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
                                <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_Phone" runat="server" CssClass="form-control" placeholder="Enter staff's phone no"></asp:TextBox>
                                        <label for="tb_Phone">
                                            Phone Number
                                                <asp:RequiredFieldValidator ID="rfv_Phone" runat="server" ControlToValidate="tb_Phone" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                        </label>
                                        <asp:RegularExpressionValidator ID="rev_Phone" runat="server" ControlToValidate="tb_Phone" ErrorMessage="Invalid Phone Number!" Font-Size="Small" ForeColor="Red" Style="font-weight: 700" ValidationExpression="^[6-9]\d{9}$"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-0">
                                <div class="d-grid">
                                    <asp:Button ID="btn_Register" CssClass="btn btn-primary btn-block" runat="server" Text="Register" OnClick="btn_Register_Click" />
                                </div>
                            </div>
                        </div>
                        <div class="card-footer text-center py-3">
                            <div class="small"><a href="ViewStaffsList.aspx">View Staffs List</a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

     <%-- function to show alerts on successful & failed staff registration --%>

    <script type="text/javascript">
        function ShowSuccessAlert() {
            Swal.fire({
                icon: 'success',
                title: 'Successful Staff Registration',
                text: 'Added the Hostel staff successfully!',
                showConfirmButton: false,
                timer: 2000
            });
            setTimeout(function () {
                console.log("Redirecting to Staffs List Page ...");
                window.location.href = 'ViewStaffsList.aspx';
            }, 2000);
        }

        function ShowErrorAlert(errorMessage) {
            Swal.fire({
                icon: 'error',
                title: 'Attendance Registration Failed',
                text: errorMessage,
            });
        }
    </script>


</asp:Content>
