<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ViewClosedComplaintsList.aspx.cs" Inherits="Hostel_Management_System_Project.ViewClosedComplaintsList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Closed Complaints List
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <%-- Table Information --%>

        <div class="container-fluid px-4">
            <%-- greet label --%>
            <h3 class="mt-4 text-light">Welcome, <%= Session["name"] %></h3>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Admin Dashboard</li>
            </ol>

            <%--complaints table data--%>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    Student and Parent Closed Complaints
                </div>
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <asp:Repeater ID="ClosedComplaintRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Sl No</th>
                                            <th>Cmp No</th>
                                            <th>Name</th>
                                            <th>Complaint</th>
                                            <th>Reply</th>
                                            <th>Status</th>
                                            <th>Raised By</th>
                                            <th>Created At</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("sl_no") %></td>
                                    <td><%# Eval("complaint_id") %></td>
                                    <td><%# Eval("st_name") %></td>
                                    <td><%# Eval("complaint") %></td>
                                    <td><%# Eval("reply") %></td>
                                    <td><%# Eval("complaint_status") %></td>
                                    <td><%# Eval("complaint_type") %></td>
                                    <td><%# Eval("created_at") %></td>
                                     <td>
                                        <asp:Button ID="btn_Reopen" runat="server" CssClass="btn btn-secondary" Text="REOPEN"  CommandArgument='<%# Eval("complaint_id") %>' data-complaint-id='<%# Eval("complaint_id") %>' OnClientClick="return confirmReopen(this);" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </main>

     <script>
        // function to reopen the complaint ticket with a confirmation alert
        function confirmReopen(button) {
            var complaintId = button.getAttribute("data-complaint-id");

            Swal.fire({
                title: 'Are you sure you want to Reopen this Complaint Ticket?',
                text: 'This action is not fixed?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#6C757D',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Yes, Reopen it!',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Perform the deletion via AJAX
                    $.ajax({
                        type: "POST",
                        url: "ViewClosedComplaintsList.aspx/ReopenComplaint",
                        data: JSON.stringify({ complaintId: complaintId }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d === "success") {
                                // Show a success message
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Reopened!',
                                    text: 'The Complaint has been Reopened successfully.',
                                    showConfirmButton: false,
                                    timer: 2000
                                });

                                // Redirect to the ViewComplaintsList.aspx page after a delay (2 seconds)
                                setTimeout(function () {
                                    window.location.href = 'ViewComplaintsList.aspx';
                                }, 2000);
                            } else {
                                // Show an error message
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error!',
                                    text: 'An error occurred while reopening the Complaint.',
                                    showConfirmButton: false,
                                    timer: 2000
                                });
                            }
                        },
                        error: function () {
                            // Show an error message in case of AJAX failure
                            Swal.fire({
                                icon: 'error',
                                title: 'Error!',
                                text: 'An error occurred while communicating with the server.',
                                showConfirmButton: false,
                                timer: 2000
                            });
                        }
                    });
                }
            });

            // Prevent the default postback of the button
            return false;
        }
     </script>

</asp:Content>
