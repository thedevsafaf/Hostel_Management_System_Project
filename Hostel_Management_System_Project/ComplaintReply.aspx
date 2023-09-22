<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ComplaintReply.aspx.cs" Inherits="Hostel_Management_System_Project.ComplaintReply" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Reply for Complaint ID : <%= Session["complaint_id"] %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>

        <%-- reply send msg alert if success--%>
        <asp:Panel ID="SuccessReplyMessage" runat="server" CssClass="alert alert-success" Visible="false">
            Reply has been sent successfully!
        </asp:Panel>

         <%-- reply send msg alert if failed--%>
        <asp:Panel ID="FailedReplyMessage" runat="server" CssClass="alert alert-danger" Visible="false">
            Sorry! Something wrong! Try Again!
        </asp:Panel>


        <div class="container py-3">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="card shadow-lg border-0 rounded-lg mt-2">
                        <div class="card-header">
                            <h3 class="text-center font-weight-light my-4">Reply to Complaint</h3>
                        </div>
                        <div class="card-body">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_ComplaintID" runat="server" CssClass="form-control" Enabled="false" placeholder="Complaint ID"></asp:TextBox>
                                        <label for="tb_ComplaintID">Complaint ID</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_StudentName" runat="server" CssClass="form-control" Enabled="false" placeholder="Student Name"></asp:TextBox>
                                        <label for="tb_StudentName">Student Name</label>
                                    </div>
                                </div>
                            </div>
                         
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_StudentPhone" runat="server" CssClass="form-control" Enabled="false" placeholder="Student Phone"></asp:TextBox>
                                        <label for="tb_StudentPhone">Student Phone</label>
                                    </div>
                                </div>
                                 <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                       <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control dropdown-icon">
                                            <asp:ListItem Text="Open" Value="Open" />
                                            <asp:ListItem Text="In Progress" Value="In Progress" />
                                            <asp:ListItem Text="Resolved" Value="Resolved" />
                                            <asp:ListItem Text="Closed" Value="Closed" />
                                            <asp:ListItem Text="Rejected" Value="Rejected" />
                                            <asp:ListItem Text="Pending" Value="Pending" />
                                            <asp:ListItem Text="On Hold" Value="On Hold" />
                                            <asp:ListItem Text="Escalated" Value="Escalated" />
                                        </asp:DropDownList>
                                        <label for="ddl_Status">Complaint Status</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-12">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_Complaint" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" Enabled="false" placeholder="Complaint"></asp:TextBox>
                                        <label for="tb_Complaint">Complaint</label>
                                    </div>
                                </div>
                            </div>
                       
                            <div class="row mb-3">
                                <div class="col-md-12">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <asp:TextBox ID="tb_AdminReply" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Admin Reply"></asp:TextBox>
                                        <label for="tb_AdminReply">Admin Reply</label>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-0">
                                <div class="d-grid">
                                    <asp:Button ID="btnSendReply" CssClass="btn btn-primary btn-block" runat="server" Text="Reply" OnClick="btnSendReply_Click"  />
                                </div>
                            </div>
                        </div>
                        <div class="card-footer text-center py-3">
                            <div class="small"><a href="ViewComplaintsList.aspx">Back to Complaints List</a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

     <%-- function to show alerts on successful & failed reply comments from admin --%>

    <script type="text/javascript">
        function ShowSuccessAlert() {
            Swal.fire({
                icon: 'success',
                title: 'Successful Admin Reply',
                text: 'Your reply has been added successfully!',
                showConfirmButton: false,
                timer: 2000
            });
            setTimeout(function () {
                console.log("Redirecting to Complaints List Page ...");
                window.location.href = 'ViewComplaintsList.aspx';
            }, 2000);
        }

        function ShowErrorAlert(errorMessage) {
            Swal.fire({
                icon: 'error',
                title: 'Admin Reply Failed',
                text: errorMessage,
            });
        }
    </script>


</asp:Content>
