<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ViewRoomGallery.aspx.cs" Inherits="Hostel_Management_System_Project.ViewRoomGallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Room Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container-fluid px-4">

            <%-- greet label --%>
            <h3 class="mt-4 text-light">Welcome, <%= Session["name"] %></h3>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Admin Dashboard</li>
            </ol>

            <!-- Room Details Section -->
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    Room Details with Photos
                </div>
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <div class="room-gallery">
                            <asp:Repeater ID="RoomPhotosRepeater" runat="server">
                                <HeaderTemplate>
                                    <table class="table table-bordered table-dark" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>Sl No</th>
                                                <th>Room Number</th>
                                                <th>Room Status</th>
                                                <th>Room Photo</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("sl_no") %></td>
                                        <td><%# Eval("room_no") %></td>
                                        <td>
                                            <asp:Label ID="lbl_Status" runat="server" Text='<%# Eval("room_status") %>' CssClass='<%# GetStatusCssClass(Eval("room_status").ToString())+ " bold-status" %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Image ID="img_RoomPhoto" runat="server" ImageUrl='<%# "/RoomPhotos/" + Eval("photo_url") %>' CssClass="img-fluid room-image" AlternateText="Room Photo" Width="300" Height="200" />
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
        </div>
    </main>
</asp:Content>
