<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="AddFoodMenuItem.aspx.cs" Inherits="Hostel_Management_System_Project.AddFoodMenuItem" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Add Food Menu Item
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container-fluid px-4">
            <%-- Add Food Menu Item --%>
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container py-3">
                        <div class="row justify-content-center">
                            <div class="col-lg-7">
                                <div class="card shadow-lg border-0 rounded-lg mt-2">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Add Food Menu Item</h3></div>
                                    <div class="card-body">
                                        <div class="row mb-2">
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <asp:TextBox ID="tb_MealName" runat="server" CssClass="form-control" placeholder="Enter meal name"></asp:TextBox>
                                                    <label for="tb_MealName">Meal Name
                                                        <asp:RequiredFieldValidator ID="rfv_MealName" runat="server" ControlToValidate="tb_MealName" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                                    </label>
                                                        <asp:RegularExpressionValidator ID="rev_MealName" runat="server" ControlToValidate="tb_MealName" ErrorMessage="Invalid characters in Meal Name!" Font-Size="Small" ForeColor="Red" style="font-weight: 700" ValidationExpression="^[A-Za-z0-9\s]+$"></asp:RegularExpressionValidator>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <asp:DropDownList ID="ddl_MealTime" runat="server" CssClass="form-control dropdown-icon">
                                                        <asp:ListItem Text="Breakfast" Value="Breakfast"></asp:ListItem>
                                                        <asp:ListItem Text="Lunch" Value="Lunch"></asp:ListItem>
                                                        <asp:ListItem Text="Dinner" Value="Dinner"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <label for="ddl_MealTime">Meal Time</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row mb-2">
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <asp:DropDownList ID="ddl_MealDay" runat="server" CssClass="form-control dropdown-icon">
                                                        <asp:ListItem Text="Sunday" Value="Sunday"></asp:ListItem>
                                                        <asp:ListItem Text="Monday" Value="Monday"></asp:ListItem>
                                                        <asp:ListItem Text="Tuesday" Value="Tuesday"></asp:ListItem>
                                                        <asp:ListItem Text="Wednesday" Value="Wednesday"></asp:ListItem>
                                                        <asp:ListItem Text="Thursday" Value="Thursday"></asp:ListItem>
                                                        <asp:ListItem Text="Friday" Value="Friday"></asp:ListItem>
                                                        <asp:ListItem Text="Saturday" Value="Saturday"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <label for="ddl_MealDay">Meal Day</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <asp:TextBox ID="tb_MealDescription" runat="server" CssClass="form-control" placeholder="Enter meal description" MaxLength="255"></asp:TextBox>
                                                    <label for="tb_MealDescription">Meal Description
                                                        <asp:RequiredFieldValidator ID="rfv_MealDescription" runat="server" ControlToValidate="tb_MealDescription" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                                    </label>
                                                    <asp:RegularExpressionValidator ID="rev_MealDescription" runat="server" ControlToValidate="tb_MealDescription" ErrorMessage="Invalid Meal Description!" Font-Size="Small" ForeColor="Red" style="font-weight: 700" ValidationExpression="^[A-Za-z0-9\s.,'-]+$"></asp:RegularExpressionValidator>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <asp:TextBox ID="tb_MealPrice" runat="server" CssClass="form-control" placeholder="Enter meal price"></asp:TextBox>
                                                    <label for="tb_MealPrice">Meal Price
                                                        <asp:RequiredFieldValidator ID="rfv_MealPrice" runat="server" ControlToValidate="tb_MealPrice" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="rev_MealPrice" runat="server" ControlToValidate="tb_MealPrice" ErrorMessage="Invalid Meal Price!" Font-Size="Small" ForeColor="Red" style="font-weight: 700" ValidationExpression="^\d+(\.\d{1,2})?$"></asp:RegularExpressionValidator>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <div class="d-grid">
                                                <asp:Button ID="btn_AddFoodMenuItem" CssClass="btn btn-primary btn-block" runat="server" Text="Add Food Menu Item" OnClick="btn_AddFoodMenuItem_Click" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer text-center py-3">
                                        <div class="small"><a href="ViewFoodMenuItemsList.aspx">View Food Menu Details</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            
        </div>
    </main>

     <%-- function to show alerts on successful & failed on adding food menu --%>

    <script type="text/javascript">
        function ShowSuccessAlert() {
            Swal.fire({
                icon: 'success',
                title: 'Food Menu Item Add Successful',
                text: 'Your food menu item has been added successfully!',
                showConfirmButton: false,
                timer: 2000
            });
            setTimeout(function () {
                console.log("Redirecting to Food Menu Items List Page ...");
                window.location.href = 'ViewFoodMenuItemsList.aspx';
            }, 2000);
        }

        function ShowErrorAlert() {
            Swal.fire({
                icon: 'error',
                title: 'Food Menu Item Add Failed',
                text: 'An error occurred during food menu item add. Please try again later.',
            });
        }
    </script>




</asp:Content>
