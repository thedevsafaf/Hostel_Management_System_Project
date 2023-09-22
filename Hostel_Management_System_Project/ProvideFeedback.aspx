<%@ Page Title="" Language="C#" MasterPageFile="~/StudentSite.Master" AutoEventWireup="true" CodeBehind="ProvideFeedback.aspx.cs" Inherits="Hostel_Management_System_Project.ProvideFeedback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Provide Feedback
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <main>
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="card shadow-lg border-0 rounded-lg mt-2">
                        <div class="card-header">
                            <h3 class="text-center font-weight-light my-4">Your Valuable Feedback</h3>
                        </div>
                        <div class="card-body py-3">
                            <div class="row mb-3">
                                <div class="col-md-12">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_Feedback" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Enter your feedback"></asp:TextBox>
                                        <label for="tb_Feedback">
                                            Feedback
                                        <asp:RequiredFieldValidator ID="rfv_Feedback" runat="server" ControlToValidate="tb_Feedback" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-0">
                                <div class="d-grid">
                                    <asp:Button ID="btn_SubmitFeedback" runat="server" Text="Submit Feedback" OnClick="btn_SubmitFeedback_Click" CssClass="btn btn-primary" />
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
                title: 'Feedback Submission Successful',
                text: 'Your feedback has been submitted successfully!',
                showConfirmButton: false,
                timer: 2000
            });
            setTimeout(function () {
                console.log("Redirecting to Feedback Success Page ...");
                window.location.href = 'FeedbackSuccess.aspx';
            }, 2000);
        }

        function ShowErrorAlert(errorMessage) {
            Swal.fire({
                icon: 'error',
                title: 'Feedback Submission Failed',
                text: errorMessage,
            });
        }
    </script>

</asp:Content>
