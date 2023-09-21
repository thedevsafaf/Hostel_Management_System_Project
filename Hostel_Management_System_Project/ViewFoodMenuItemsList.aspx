<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ViewFoodMenuItemsList.aspx.cs" Inherits="Hostel_Management_System_Project.ViewFoodMenuItemsList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Food Items List
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
                No Item found.
            </asp:Panel>

      
            <%--food menu items list table data--%>

            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    Food Menu Items List
                 </div>
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <%-- FILTERS --%>                 
                        <div class="row mb-3 d-flex">
                            <div class="col-md-3">
                                <!-- Meal Time Filter Dropdown -->
                                <%-- OnSelectedIndexChanged="ddlTimeFilter_SelectedIndexChanged" --%>
                                <asp:DropDownList ID="ddlTimeFilter" runat="server" CssClass="form-control dropdown-icon" AutoPostBack="true" >
                                    <asp:ListItem Text="All Times" Value="All" />
                                    <asp:ListItem Text="Breakfast" Value="Breakfast" />
                                    <asp:ListItem Text="Lunch" Value="Lunch" />
                                    <asp:ListItem Text="Dinner" Value="Dinner" />
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3">
                                <!-- Meal Day Filter Dropdown -->
                                <%-- OnSelectedIndexChanged="ddlDayFilter_SelectedIndexChanged" --%>
                                <asp:DropDownList ID="ddlDayFilter" runat="server" CssClass="form-control dropdown-icon" AutoPostBack="true" >
                                    <asp:ListItem Text="All Days" Value="All" />
                                    <asp:ListItem Text="Sunday" Value="Sunday" />
                                    <asp:ListItem Text="Monday" Value="Monday" />
                                    <asp:ListItem Text="Tuesday" Value="Tuesday" />
                                    <asp:ListItem Text="Wednesday" Value="Wednesday" />
                                    <asp:ListItem Text="Thursday" Value="Thursday" />
                                    <asp:ListItem Text="Friday" Value="Friday" />
                                    <asp:ListItem Text="Saturday" Value="Saturday" />
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-2">
                                <!-- Filter Button -->
                                <asp:Button ID="btnFilter" runat="server" CssClass="btn btn-primary" Text="Apply Filter" OnClick="btnFilter_Click" />
                            </div>
                        </div>
                        <div class="row mb-3 d-flex">
                            <div class="col-md-6">
                                <!-- Search Box -->
                                <asp:TextBox ID="searchInput" runat="server" CssClass="form-control" placeholder="Search by Name, Time, Day, Price, or Description" />
                            </div>
                            <div class="col-md-2">
                                <asp:Button ID="searchButton" runat="server" CssClass="btn btn-primary" Text="Search here" OnClick="SearchButton_Click" />
                            </div>
                        </div>
                        

                            <asp:Repeater ID="FoodMenuItemRepeater" runat="server">
                                <HeaderTemplate>
                                    <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>Meal ID</th>
                                                <th>Name</th>
                                                <th>Meal Time</th>
                                                <th>Day</th>
                                                <th>Price</th>
                                                <th>Description</th>
                                                <th>Created At</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("meal_id") %></td>
                                        <td><%# Eval("meal_name") %></td>
                                        <td><%# Eval("meal_time") %></td>
                                        <td><%# Eval("meal_day") %></td>
                                        <td><%# Eval("meal_price") %></td>
                                        <td><%# Eval("meal_description") %></td>
                                        <td><%# Eval("created_at") %></td>
                                         <td>
                                            <asp:Button ID="btn_Edit" runat="server" CssClass="btn btn-success" Text="EDIT" OnClick="EditMenu_Click" CommandArgument='<%# Eval("meal_id") %>' />
                                        </td>
                                        <td>
                                            <asp:Button ID="btn_Delete" runat="server" CssClass="btn btn-danger" Text="DELETE" CommandArgument='<%# Eval("meal_id") %>' data-meal-id='<%# Eval("meal_id") %>' OnClientClick="return confirmDelete(this);" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                        </tbody>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>

                            <%-- PAGINATOR --%>
                            <div class="row">
                                <div class="col-md-12">
                                    <ul id="pagination" class="pagination justify-content-center"></ul>
                                </div>
                            </div>
                            
                        </div>

                    </div>
                </div>                                               
        </div>
    </main>

    <script>
        // function to delete the foodmenuitem with a confirmation alert
        function confirmDelete(button) {
            var mealId = button.getAttribute("data-meal-id");

            Swal.fire({
                title: 'Are you sure you want to delete this food menu item?',
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
                        url: "ViewFoodMenuItemsList.aspx/DeleteFoodMenuItem",
                        data: JSON.stringify({ mealId: mealId }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d === "success") {
                                // Show a success message
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Deleted!',
                                    text: 'The food menu item has been deleted successfully.',
                                    showConfirmButton: false,
                                    timer: 2000
                                });

                                // Redirect to the ViewFoodMenuItemsList.aspx page after a delay (2 seconds)
                                setTimeout(function () {
                                    window.location.href = 'ViewFoodMenuItemsList.aspx';
                                }, 2000);
                            } else {
                                // Show an error message
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error!',
                                    text: 'An error occurred while deleting the food menu item.',
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




    <%-- pagination jquery custom function --%>

    <script>
        var pageSize = 10; // Number of rows to show per page
        var currentPage = 1; // Current page number

        // Function to show/hide rows based on the current page
        function showPage(page) {
            $("#dataTable tbody tr").hide(); // Hide all rows
            var startIndex = (page - 1) * pageSize;
            var endIndex = startIndex + pageSize;
            $("#dataTable tbody tr").slice(startIndex, endIndex).show(); // Show rows for the current page
        }

        // Function to generate pagination links
        function generatePagination() {
            var pageCount = Math.ceil($("#dataTable tbody tr").length / pageSize);
            var pagination = $("#pagination");
            pagination.empty(); // Clear existing pagination links

            // Add "Previous" link
            if (currentPage > 1) {
                pagination.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (currentPage - 1) + '">Previous</a></li>');
            }

            // Add page number links
            for (var i = 1; i <= pageCount; i++) {
                pagination.append('<li class="page-item' + (i === currentPage ? ' active' : '') + '"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>');
            }

            // Add "Next" link
            if (currentPage < pageCount) {
                pagination.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (currentPage + 1) + '">Next</a></li>');
            }

            // Attach click event handler to page links
            pagination.find("a").click(function () {
                var page = parseInt($(this).data("page"));
                currentPage = page;
                showPage(currentPage);
                generatePagination();
            });
        }

        $(document).ready(function () {
            showPage(currentPage);
            generatePagination();

            $("#searchButton").click(function () {
                currentPage = 1; // Reset to the first page when searching
                showPage(currentPage);
                generatePagination();
                // Rest of your search logic here
            });
        });
    </script>


</asp:Content>
