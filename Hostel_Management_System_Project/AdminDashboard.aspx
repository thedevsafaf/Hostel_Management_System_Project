<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="Hostel_Management_System_Project.AdminDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Admin Dashboard
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <main>
        <div class="container-fluid px-4">
            
            <%-- Greet --%>
            <h3 class="mt-4 text-light">Welcome, <%= Session["name"] %></h3>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Admin Dashboard</li>
            </ol>

            <%-- Dashboard Overview --%>

            <%-- Students Card details --%>
            <div class="row">
                <div class="card-title count-label">
                    Student Stats
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-gold text-white mb-4">
                        <div class="card-body">
                            No of Pending Students: <asp:Label ID="lblPendingStudentCount" runat="server" CssClass="count-label"></asp:Label>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link" href="#">View Details</a>
                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-custom-grey text-white mb-4">
                        <div class="card-body">
                            No of Inactive Students: <asp:Label ID="lblInactiveStudentCount" runat="server" CssClass="count-label"></asp:Label>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link" href="#">View Details</a>
                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-success text-white mb-4">
                        <div class="card-body">
                            No of Approved Students: <asp:Label ID="lblApprovedStudentCount" runat="server" CssClass="count-label"></asp:Label>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link" href="#">View Details</a>
                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-danger text-white mb-4">
                        <div class="card-body">
                            No of Rejected Students: <asp:Label ID="lblRejectedStudentCount" runat="server" CssClass="count-label"></asp:Label>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link" href="#">View Details</a>
                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <%--students table data--%>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    Students List
                </div>

                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <asp:Repeater ID="StudentRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Student ID</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Status</th>
                                            <th>Created At</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("student_id") %></td>
                                    <td><%# Eval("name") %></td>
                                    <td><%# Eval("email") %></td>
                                    <td><%# Eval("phone_number") %></td>
                                    <td>
                                        <asp:Label ID="lbl_Status" runat="server" Text='<%# Eval("status") %>' CssClass='<%# GetStatusCssClass(Eval("status").ToString())+ " bold-status" %>'></asp:Label>
                                    </td>
                                    <td><%# Eval("created_at") %></td>
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

            <%-- Parents Card details --%>
            <div class="row">
                <div class="card-title count-label">
                    Parent Stats
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-gold text-white mb-4">
                        <div class="card-body">
                            No of Pending Parents: <asp:Label ID="lblPendingParentCount" runat="server" CssClass="count-label"></asp:Label>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link" href="#">View Details</a>
                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-custom-grey text-white mb-4">
                        <div class="card-body">
                            No of Inactive Parents: <asp:Label ID="lblInactiveParentCount" runat="server" CssClass="count-label"></asp:Label>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link" href="#">View Details</a>
                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-success text-white mb-4">
                        <div class="card-body">
                            No of Approved Parents: <asp:Label ID="lblApprovedParentCount" runat="server" CssClass="count-label"></asp:Label>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link" href="#">View Details</a>
                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-danger text-white mb-4">
                        <div class="card-body">
                            No of Rejected Parents: <asp:Label ID="lblRejectedParentCount" runat="server" CssClass="count-label"></asp:Label>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link" href="#">View Details</a>
                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- parents table data --%>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    Parents List
                </div>
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <asp:Repeater ID="ParentRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Parent ID</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Student Name</th>
                                            <th>Status</th>
                                            <th>Created At</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("parent_id") %></td>
                                    <td><%# Eval("name") %></td>
                                    <td><%# Eval("email") %></td>
                                    <td><%# Eval("phone_number") %></td>
                                    <td><%# Eval("student_name") %></td>
                                        <td>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("status") %>' CssClass='<%# GetStatusCssClass(Eval("status").ToString())+ " bold-status" %>'></asp:Label>
                                    </td>
                                    <td><%# Eval("created_at") %></td>
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


            <%-- Room Card Details --%>
            <div class="row">
                <div class="card-title count-label">
                    Room Stats
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-gold text-white mb-4">
                        <div class="card-body">
                            Maintenance Rooms: <asp:Label ID="lblMaintenanceRoomCount" runat="server" CssClass="count-label"></asp:Label>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link" href="#">View Details</a>
                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-custom-grey text-white mb-4">
                        <div class="card-body">
                            No of Inactive Rooms: <asp:Label ID="lblInactiveRoomCount" runat="server" CssClass="count-label"></asp:Label>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link" href="#">View Details</a>
                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-success text-white mb-4">
                        <div class="card-body">
                            No of Vacant Rooms: <asp:Label ID="lblVacantRoomCount" runat="server" CssClass="count-label"></asp:Label>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link" href="#">View Details</a>
                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-danger text-white mb-4">
                        <div class="card-body">
                            No of Occupied Rooms: <asp:Label ID="lblOccupiedRoomCount" runat="server" CssClass="count-label"></asp:Label>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link" href="#">View Details</a>
                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- room facilities table data --%>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                        Rooms List
                </div>
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <asp:Repeater ID="RoomRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Room ID</th>
                                            <th>Room No</th>
                                            <th>Room Description</th>
                                            <th>Room Status</th>
                                            <th>Created At</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <%# Eval("room_id") %>
                                    </td>
                                    <td>
                                        <asp:HyperLink ID="lnk_RoomDetails" runat="server" NavigateUrl='<%# "RoomDetails.aspx?roomId=" + Eval("room_id") %>' Text='<%# Eval("room_no") %>' />
                                    </td>
                                    <td><%# Eval("room_desc") %></td>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("room_status") %>' CssClass='<%# GetRoomStatusCssClass(Eval("room_status").ToString())+ " bold-status" %>'></asp:Label>
                                    </td>
                                    <td><%# Eval("created_at") %></td>
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
