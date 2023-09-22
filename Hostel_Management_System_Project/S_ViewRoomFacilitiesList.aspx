<%@ Page Title="" Language="C#" MasterPageFile="~/StudentSite.Master" AutoEventWireup="true" CodeBehind="S_ViewRoomFacilitiesList.aspx.cs" Inherits="Hostel_Management_System_Project.S_ViewRoomFacilitiesList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Room Facilities List
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <main>
        <div class="container-fluid px-4">
                        
            <%-- greet label --%>
            <h3 class="mt-4 text-light">Welcome, <%= Session["name"] %></h3>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Student Dashboard</li>
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
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("sl_no") %></td>
                                    <td>
                                        <asp:HyperLink ID="lnk_RoomDetails" runat="server" NavigateUrl='<%# "S_RoomDetails.aspx?roomId=" + Eval("room_id") %>' Text='<%# Eval("room_no") %>' />
                                    </td>
                                    <td width="70%">
                                        <%# Eval("room_desc") %>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_Status" runat="server" Text='<%# Eval("room_status") %>' CssClass='<%# GetStatusCssClass(Eval("room_status").ToString())+ " bold-status" %>'></asp:Label>
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
</asp:Content>
