<%@ Page Title="" Language="C#" MasterPageFile="~/StudentSite.Master" AutoEventWireup="true" CodeBehind="S_RoomBooking.aspx.cs" Inherits="Hostel_Management_System_Project.S_RoomBooking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Room Booking
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container-fluid px-4">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container py-3">
                        <div class="row justify-content-center">
                            <div class="col-lg-7">
                                <div class="card shadow-lg border-0 rounded-lg mt-2">
                                    <div class="card-header">
                                        <h3 class="text-center font-weight-light my-4">Room Booking</h3>
                                        <p class="text-center font-weight-light my-4">You should proceed with a payment for a successful Room booking</p>
                                    </div>
                                    <div class="card-body">
                                        <div class="row mb-5">
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <asp:DropDownList ID="ddl_RoomSelection" runat="server" CssClass="form-control dropdown-icon">
                                                        <asp:ListItem Text="Select Room" Value="drer"></asp:ListItem>
                                                        <%-- Dynamically populate room options based on availability --%>
                                                    </asp:DropDownList>
                                                    <label for="ddl_RoomSelection">
                                                        Select the Vacant Room
                                                            <asp:RequiredFieldValidator ID="rfv_RoomSelection" runat="server" ControlToValidate="ddl_RoomSelection" InitialValue="" ErrorMessage="Please select a room" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <asp:TextBox ID="tb_BookingDate" runat="server" CssClass="form-control" TextMode="Date" placeholder="Select start date"></asp:TextBox>
                                                    <label for="tb_BookingDate">
                                                        Booking Date
                                                            <asp:RequiredFieldValidator ID="rfv_BookingDate" runat="server" ControlToValidate="tb_BookingDate" ErrorMessage="Required field" ForeColor="Red"><b>*</b></asp:RequiredFieldValidator>
                                                        <asp:CompareValidator ID="cv_BookingDate" runat="server" ControlToValidate="tb_BookingDate" Operator="DataTypeCheck" Type="Date" ErrorMessage="Invalid date format" ForeColor="Red"></asp:CompareValidator>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <div class="d-grid">
                                                <asp:Button ID="btn_BookRoom" CssClass="btn btn-primary btn-block" runat="server" Text="Book Room" OnClick="btn_BookRoom_Click" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer text-center py-3">
                                        <div class="small"><a href="S_MakePayment.aspx">Proceed with the Payment</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </main>
</asp:Content>
