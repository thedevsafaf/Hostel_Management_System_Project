<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="RoomDetails.aspx.cs" Inherits="Hostel_Management_System_Project.RoomDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Hostel Room Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container-fluid px-5">
            <h1 class="mt-4 text-primary">Room Information</h1>

             <%-- no data found error msg alert --%>
            <asp:Panel ID="noResultsMessage" runat="server" CssClass="alert alert-danger" Visible="false">
                Please upload a room photo to see all the room details.
            </asp:Panel>

            <!-- Room Details Section -->
            <div class="mt-3 card">
                <div class="card-body bg-dark text-light">

                    <div class="row mb-1">
                        <div class="col-md-6">
                            <p>
                                <strong>Room Number: </strong>
                                <asp:Label ID="lbl_RoomNo" runat="server" Text=""></asp:Label>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p>
                                <strong>Room Status: </strong>
                                <asp:Label ID="lbl_RoomStatus" runat="server" Text=""></asp:Label>
                            </p>
                        </div>
                    </div>

                    <div class="row mb-1">
                        <div class="col-md-6">
                            <p><strong>Room Description: </strong></p>
                            <asp:Label ID="lbl_RoomDesc" runat="server" Text=""></asp:Label>
                        </div>
                        <!-- Room Photo Section -->
                        <div class="col-md-6">
                            <p><strong>Room Photo: </strong></p>
                            <asp:Image ID="img_RoomPhoto" runat="server" CssClass="img-fluid room-image" AlternateText="Not Found" Width="300" Height="200" />
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </main>

</asp:Content>
