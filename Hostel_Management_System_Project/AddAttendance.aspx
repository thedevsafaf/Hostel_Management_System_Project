<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="AddAttendance.aspx.cs" Inherits="Hostel_Management_System_Project.AddAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Add Student Attendance
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container-fluid px-4">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container py-5">
                        <div class="row justify-content-center">
                            <div class="col-lg-7">
                                <div class="card shadow-lg border-0 rounded-lg mt-2">
                                    <div class="card-header">
                                        <h3 class="text-center font-weight-light my-4">Add Attendance</h3>
                                    </div>
                                    <div class="card-body">
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <asp:DropDownList ID="ddl_Student" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                                                        <asp:ListItem Text="Select Student" Value="-1" />
                                                    </asp:DropDownList>
                                                    <label for="ddl_Student">Student</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <asp:TextBox ID="tb_AttendanceDate" runat="server" CssClass="form-control" TextMode="Date" placeholder="Select date"></asp:TextBox>
                                                    <label for="tb_AttendanceDate">Attendance Date</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <asp:DropDownList ID="ddl_AttendanceStatus" runat="server" CssClass="form-control">
                                                        <asp:ListItem Text="Present" Value="Present" />
                                                        <asp:ListItem Text="Absent" Value="Absent" />
                                                    </asp:DropDownList>
                                                    <label for="ddl_AttendanceStatus">Attendance Status</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <div class="d-grid">
                                                <%-- OnClick="btn_AddAttendance_Click" --%>
                                                <asp:Button ID="btn_AddAttendance" CssClass="btn btn-primary btn-block" runat="server" Text="Add Attendance" OnClick="btn_AddAttendance_Click"  />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </main>

     <%-- function to show alerts on successful & failed attendance registration --%>

    <script type="text/javascript">
        function ShowSuccessAlert() {
            Swal.fire({
                icon: 'success',
                title: 'Successful Attendance Registration',
                text: 'Added the student attendance successfully!',
                showConfirmButton: false,
                timer: 2000
            });
            setTimeout(function () {
                console.log("Redirecting to Attendance List Page ...");
                window.location.href = 'ViewAttendanceList.aspx';
            }, 2000);
        }

        function ShowErrorAlert(errorMessage) {
            Swal.fire({
                icon: 'error',
                title: 'Attendance Registration Failed',
                text: errorMessage,
            });
        }
    </script>


</asp:Content>
