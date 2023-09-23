<%@ Page Title="" Language="C#" MasterPageFile="~/StudentSite.Master" AutoEventWireup="true" CodeBehind="S_MakePayment.aspx.cs" Inherits="Hostel_Management_System_Project.S_MakePayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Make Room Payment
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <div id="layoutAuthentication_content">
            <main>
                <div class="container py-3">
                    <div class="row justify-content-center">
                        <div class="col-lg-7">
                            <div class="card shadow-lg border-0 rounded-lg mt-2">
                                <div class="card-header">
                                    <h3 class="text-center font-weight-light my-4">Make Payment</h3>
                                </div>
                                <div class="card-body">
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <asp:DropDownList ID="ddl_BookedRoom" runat="server" CssClass="form-control dropdown-icon">
                                                    <asp:ListItem Text="Select Room" Value="drer"></asp:ListItem>
                                                    <%-- Dynamically populate room options based on availability --%>
                                                </asp:DropDownList>
                                                <label for="ddl_BookedRoom">
                                                    Select the Booked Room
                                                        <asp:RequiredFieldValidator ID="rfv_BookedRoom" runat="server" ControlToValidate="ddl_BookedRoom" InitialValue="" ErrorMessage="Please select a room" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <asp:TextBox ID="tb_Amount" runat="server" CssClass="form-control" placeholder="Enter amount" Text="5000" Enabled="false"></asp:TextBox>
                                                <label for="tb_Amount">Payment Amount</label>
                                                <asp:RequiredFieldValidator ID="rfv_Amount" runat="server" ControlToValidate="tb_Amount" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="rev_Amount" runat="server" ControlToValidate="tb_Amount" ErrorMessage="Invalid amount format" ForeColor="Red" ValidationExpression="^\d+(\.\d{1,2})?$"></asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <asp:TextBox ID="tb_PaymentDate" runat="server" CssClass="form-control" TextMode="Date" placeholder="Select start date"></asp:TextBox>
                                                <label for="tb_PaymentDate">
                                                    Payment Date
                                                    <asp:RequiredFieldValidator ID="rfv_PaymentDate" runat="server" ControlToValidate="tb_PaymentDate" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                                    <asp:CompareValidator ID="cv_PaymentDate" runat="server" ControlToValidate="tb_PaymentDate" Operator="DataTypeCheck" Type="Date" ErrorMessage="Invalid date format" ForeColor="Red"></asp:CompareValidator>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <div class="d-grid">
                                            <asp:Button ID="btn_Pay" CssClass="btn btn-primary btn-block" runat="server" Text="Make Payment" OnClick="btn_Pay_Click"  />
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer text-center py-3">
                                    <div class="small"><a href="S_ViewMyBooking.aspx">View My Bookings</a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

     <%-- function to show alerts on successful & failed payment --%>

    <script type="text/javascript">
        function ShowSuccessAlert() {
            Swal.fire({
                icon: 'success',
                title: 'Payment Successful',
                text: 'Your payment has been done successfully!',
                showConfirmButton: false,
                timer: 2000
            });
            setTimeout(function () {
                console.log("Redirecting to Student Payment History Page ...");
                window.location.href = 'S_ViewPaymentHistory.aspx';
            }, 2000);
        }

        function ShowErrorAlert(errorMessage) {
            Swal.fire({
                icon: 'error',
                title: 'Payment Failed',
                text: errorMessage,
            });
        }
    </script>


</asp:Content>
