<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ViewRoomFacilitiesList.aspx.cs" Inherits="Hostel_Management_System_Project.ViewRoomFacilitiesList" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Room Facilities List
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
                No room found.
            </asp:Panel>
                        
            <%--rooms list table data--%>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                        Rooms List
                </div>
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                       <!-- Search Box & Filter DD -->
                        <div class="row mb-3">
                            <div class="col-md-3">
                                <asp:DropDownList ID="statusFilter" runat="server" CssClass="form-control dropdown-icon">
                                    <asp:ListItem Text="Filter by Status" Value="" />
                                    <asp:ListItem Text="Vacant" Value="Vacant" />
                                    <asp:ListItem Text="Occupied" Value="Occupied" />
                                </asp:DropDownList>
                            </div>
                             <div class="col-md-2">
                                <asp:Button ID="filterButton" runat="server" CssClass="btn btn-primary btn-block" Text="Filter" OnClick="FilterButton_Click" />
                            </div>
                            <div class="col-md-3">
                                <asp:TextBox ID="searchInput" runat="server" CssClass="form-control" placeholder="Search by Room Number" />
                            </div>
                            <div class="col-md-2">
                                <asp:Button ID="searchButton" runat="server" CssClass="btn btn-primary btn-block" Text="Search here" OnClick="SearchButton_Click" />
                            </div>
                        </div>
                        <!-- Search Box & Filter DD -->
                        <asp:Repeater ID="RoomRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Sl No</th>
                                            <th>Room No</th>
                                            <th>Room Description</th>
                                            <th>Room Status</th>
                                            <th>Created At</th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <%# Eval("sl_no") %>
                                    </td>
                                    <td>
                                        <asp:HyperLink ID="lnk_RoomDetails" runat="server" NavigateUrl='<%# "RoomDetails.aspx?roomId=" + Eval("room_id") %>' Text='<%# Eval("room_no") %>' />
                                    </td>
                                    <td>
                                        <%# Eval("room_desc").ToString().Length > 100 ? Eval("room_desc").ToString().Substring(0, 100) + "..." : Eval("room_desc") %>

                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_Status" runat="server" Text='<%# Eval("room_status") %>' CssClass='<%# GetStatusCssClass(Eval("room_status").ToString())+ " bold-status" %>'></asp:Label>
                                    </td>
                                    <td><%# Eval("created_at") %></td>
                                    <td>
                                        <asp:Button ID="btn_Edit" runat="server" CssClass="btn btn-success" Text="EDIT"  CommandArgument='<%# Eval("room_id")  %>' OnClick="EditRoom_Click" />
                                    </td>
                                    <td>
                                        <asp:Button ID="btn_Delete" runat="server" CssClass="btn btn-danger" Text="DELETE" CommandArgument='<%# Eval("room_id") %>' data-room-id='<%# Eval("room_id") %>' OnClientClick="return confirmDelete(this);" />
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
        // function to delete the room with a confirmation alert
        function confirmDelete(button) {
            var roomId = button.getAttribute("data-room-id");

            Swal.fire({
                title: 'Are you sure you want to delete this room?',
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
                        url: "ViewRoomFacilitiesList.aspx/DeleteRoom",
                        data: JSON.stringify({ roomId: roomId }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d === "success") {
                                // Show a success message
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Deleted!',
                                    text: 'The room has been deleted successfully.',
                                    showConfirmButton: false,
                                    timer: 2000
                                });

                                // Redirect to the ViewRoomFacilitiesList.aspx page after a delay (2 seconds)
                                setTimeout(function () {
                                    window.location.href = 'ViewRoomFacilitiesList.aspx';
                                }, 2000);
                            } else {
                                // Show an error message
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error!',
                                    text: 'An error occurred while deleting the room.',
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
