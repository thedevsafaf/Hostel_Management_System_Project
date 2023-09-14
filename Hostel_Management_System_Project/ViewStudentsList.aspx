<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ViewStudentsList.aspx.cs" Inherits="Hostel_Management_System_Project.ViewStudentsList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Students List
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container-fluid px-4">
                        
            <%-- greet label --%>
            <h3 class="mt-4 text-light">Welcome, <%= Session["name"] %></h3>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Admin Dashboard</li>
            </ol>

            <%-- no data found error msg alert --%>
            <asp:Panel ID="noResultsMessage" runat="server" CssClass="alert alert-warning" Visible="false">
                No student found.
            </asp:Panel>
            
            <%--students table data--%>

            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    Students List
                </div>
                <div class="card-body bg-dark">
                    <!-- Search Box & Filter DD -->
                    <div class="row mb-3">
                        <div class="col-md-3">
                            <asp:DropDownList ID="statusFilter" runat="server" CssClass="form-control dropdown-icon">
                                <asp:ListItem Text="Filter by Status" Value="" />
                                <asp:ListItem Text="Approved" Value="Approved" />
                                <asp:ListItem Text="Pending" Value="Pending" />
                                <asp:ListItem Text="Rejected" Value="Rejected" />
                            </asp:DropDownList>
                        </div>
                         <div class="col-md-2">
                            <asp:Button ID="filterButton" runat="server" CssClass="btn btn-primary btn-block" Text="Filter" OnClick="FilterButton_Click" />
                        </div>
                        <div class="col-md-3">
                            <asp:TextBox ID="searchInput" runat="server" CssClass="form-control" placeholder="Search by Name, Email, Phone" />
                        </div>
                        <div class="col-md-2">
                            <asp:Button ID="searchButton" runat="server" CssClass="btn btn-primary btn-block" Text="Search here" OnClick="SearchButton_Click" />
                        </div>
                    </div>
                    <!-- Search Box & Filter DD -->
                    <div class="table-responsive">
                        <asp:Repeater ID="StudentRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Student ID</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Status</th>
                                            <th>Created At</th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("student_id") %></td>
                                    <td><%# Eval("name") %></td>
                                    <td><%# Eval("email") %></td>
                                    <td><%# Eval("phone_number") %></td>
                                        <td>
                                        <asp:Label ID="lbl_Status" runat="server" Text='<%# Eval("status") %>' CssClass='<%# GetStatusCssClass(Eval("status").ToString())+ " bold-status" %>'></asp:Label>
                                    </td>
                                    <td><%# Eval("created_at") %></td>
                                    <td>
                                        <asp:Button ID="btn_Edit" runat="server" CssClass="btn btn-success" Text="EDIT" OnClick="EditStudent_Click" CommandArgument='<%# Eval("student_id") %>' />
                                    </td>
                                    <td>
                                        <asp:Button ID="btn_Delete" runat="server" CssClass="btn btn-danger" Text="DELETE" CommandArgument='<%# Eval("student_id") %>' data-student-id='<%# Eval("student_id") %>' OnClientClick="return confirmDelete(this);" />
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

    <%-- function to delete the student with a confirmation alert --%>
    <script>

        function confirmDelete(button) {
            var studentId = button.getAttribute("data-student-id");

            Swal.fire({
                title: 'Are you sure you want to delete this student?',
                text: 'This action cannot be undone!',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Perform the deletion via AJAX
                    $.ajax({
                        type: "POST",
                        url: "ViewStudentsList.aspx/DeleteStudent", 
                        data: JSON.stringify({ studentId: studentId }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d === "success") {
                                // Show a success message
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Deleted!',
                                    text: 'The student has been deleted successfully.',
                                    showConfirmButton: false,
                                    timer: 2000
                                });

                                // Redirect to the ViewStudentsList.aspx page after a delay (2 seconds)
                                setTimeout(function () {
                                    window.location.href = 'ViewStudentsList.aspx'; 
                                }, 2000);
                            } else {
                                // Show an error message
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error!',
                                    text: 'An error occurred while deleting the student.',
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
