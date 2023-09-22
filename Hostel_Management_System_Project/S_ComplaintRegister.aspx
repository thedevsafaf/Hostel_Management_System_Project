<%@ Page Title="" Language="C#" MasterPageFile="~/StudentSite.Master" AutoEventWireup="true" CodeBehind="S_ComplaintRegister.aspx.cs" Inherits="Hostel_Management_System_Project.S_ComplaintRegister" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Register Student Complaint
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="card shadow-lg border-0 rounded-lg mt-2">
                        <div class="card-header">
                            <h3 class="text-center font-weight-light my-4">Register Complaint</h3>
                        </div>
                        <div class="card-body py-3">
                            <div class="row mb-3">
                                <div class="col-md-12">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_Complaint" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Enter your complaint"></asp:TextBox>
                                        <label for="tb_Complaint">
                                            Complaint
                                        <asp:RequiredFieldValidator ID="rfv_Complaint" runat="server" ControlToValidate="tb_Complaint" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-0">
                                <div class="d-grid">
                                    <asp:Button ID="btn_RegisterComplaint" CssClass="btn btn-primary btn-block" runat="server" Text="Register Complaint" OnClick="btn_RegisterComplaint_Click"  />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <%-- function to show alerts on successful & failed complaint registration --%>

    <script type="text/javascript">
        function ShowSuccessAlert() {
            Swal.fire({
                icon: 'success',
                title: 'Complaint Registration Successful',
                text: 'Your complaint has been registered successfully!',
                showConfirmButton: false,
                timer: 2000
            });
            setTimeout(function () {
                console.log("Redirecting to Complaint Status Page ...");
                window.location.href = 'S_ComplaintStatus.aspx';
            }, 2000);
        }

        function ShowErrorAlert(errorMessage) {
            Swal.fire({
                icon: 'error',
                title: 'Complaint Registration Failed',
                text: errorMessage,
            });
        }
    </script>

</asp:Content>
