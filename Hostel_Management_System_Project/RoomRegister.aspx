<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="RoomRegister.aspx.cs" Inherits="Hostel_Management_System_Project.RoomRegister" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Add Room Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <main>
        <div class="container-fluid px-4">
            <%-- Add Room Details --%>
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container py-3">
                        <div class="row justify-content-center">
                            <div class="col-lg-7">
                                <div class="card shadow-lg border-0 rounded-lg mt-2">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Add Room Details</h3></div>
                                    <div class="card-body">
                                        <div class="row mb-2">
                                            <div class="col-md-12">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <asp:TextBox ID="tb_RoomNo" runat="server" CssClass="form-control" placeholder="Enter room number"></asp:TextBox>
                                                    <label for="tb_RoomNo">Room Number
                                                        <asp:RequiredFieldValidator ID="rfv_RoomNo" runat="server" ControlToValidate="tb_RoomNo" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>                     
                                                    </label>
                                                    <asp:RegularExpressionValidator ID="rev_RoomNo" runat="server" ControlToValidate="tb_RoomNo" ErrorMessage="Invalid Room Number!" Font-Size="Small" ForeColor="Red" style="font-weight: 700" ValidationExpression="^[A-Za-z0-9\s]+$"></asp:RegularExpressionValidator>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="row mb-2">
                                            <div class="col-md-12">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <asp:TextBox ID="tb_RoomDesc" runat="server" CssClass="form-control" placeholder="Enter room description" MaxLength="255"></asp:TextBox>
                                                    <label for="tb_RoomDesc">Room Description
                                                        <asp:RequiredFieldValidator ID="rfv_RoomDesc" runat="server" ControlToValidate="tb_RoomDesc" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>                     
                                                    </label>
                                                    <asp:RegularExpressionValidator ID="rev_RoomDesc" runat="server" ControlToValidate="tb_RoomDesc" ErrorMessage="Invalid Room Description!" Font-Size="Small" ForeColor="Red" style="font-weight: 700" ValidationExpression="^[A-Za-z0-9\s.,'-]+$"></asp:RegularExpressionValidator>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <div class="col-md-12">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <asp:DropDownList ID="ddl_RoomStatus" runat="server" CssClass="form-control dropdown-icon">
                                                        <asp:ListItem Text="Vacant" Value="Vacant"></asp:ListItem>
                                                        <asp:ListItem Text="Occupied" Value="Occupied"></asp:ListItem>
                                                        <%--<asp:ListItem Text="Under Maintenance" Value="Under Maintenance"></asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                    <label for="ddl_RoomStatus">Room Status</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <div class="d-grid">
                                                <asp:Button ID="btn_Register" CssClass="btn btn-primary btn-block" runat="server" Text="Register Room Facility" OnClick="btn_Register_Click" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer text-center py-3">
                                        <div class="small"><a href="ViewRoomFacilitiesList.aspx">View Rooms Details</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
                                             
                          
        </div>
    </main>

    <%-- function to show alerts on successful & failed registration --%>

    <script type="text/javascript">
        function ShowSuccessAlert() {
            Swal.fire({
                icon: 'success',
                title: 'Room Registration Successful',
                text: 'Your room has been created successfully!',
                showConfirmButton: false,
                timer: 2000
            });
            setTimeout(function () {
                console.log("Redirecting to Room Facilities List Page ...");
                window.location.href = 'ViewRoomFacilitiesList.aspx';
            }, 2000);
        }

        function ShowErrorAlert() {
            Swal.fire({
                icon: 'error',
                title: 'Room Registration Failed',
                text: 'An error occurred during room registration. Please try again later.',
            });
        }
    </script>


</asp:Content>
