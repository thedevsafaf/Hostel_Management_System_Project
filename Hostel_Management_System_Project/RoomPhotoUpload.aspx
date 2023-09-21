<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="RoomPhotoUpload.aspx.cs" Inherits="Hostel_Management_System_Project.RoomPhotoUpload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Upload Photo Room
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container-fluid px-4">
            <%-- Upload Room Photo --%>
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container py-5">
                        <div class="row justify-content-center">
                            <div class="col-lg-7">
                                <div class="card shadow-lg border-0 rounded-lg mt-10">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Upload Room Photo</h3></div>
                                    <div class="card-body">
                                        
                                            <div class="row mb-4">
                                                <div class="col-md-12">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <asp:FileUpload ID="file_RoomPhoto" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>
                                            </div>
                                        
                                            <div class="row mb-2">
                                                <div class="col-md-12">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <asp:DropDownList ID="ddl_Rooms" runat="server" CssClass="form-control dropdown-icon">
                                                            <%--Populate this dropdown with available rooms--%>
                                                        </asp:DropDownList>
                                                        <label for="ddl_Rooms">Select Room</label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <div class="col-md-12">
                                                    <div class="form-group mt-3">
                                                        <asp:Button ID="btnUploadPhoto" runat="server" Text="Upload Photo" CssClass="btn btn-primary btn-block" OnClick="btnUploadPhoto_Click"  />
                                                    </div>
                                                </div>
                                            </div>                
                                        
                                    </div>
                                    <div class="card-footer text-center p-3">
                                        <div class="small"><a href="ViewRoomGallery.aspx">View Rooms Photos</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
                                             
                          
        </div>
    </main>

    <%-- function to show alerts on successful & failed upload of room photo --%>

    <script type="text/javascript">
        function ShowSuccessAlert() {
            Swal.fire({
                icon: 'success',
                title: 'Room Photo Upload Successful',
                text: 'Your room photo has been uploaded successfully!',
                showConfirmButton: false,
                timer: 2000
            });
            setTimeout(function () {
                console.log("Redirecting to Room Gallery Page ...");
                window.location.href = 'ViewRoomGallery.aspx';
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
