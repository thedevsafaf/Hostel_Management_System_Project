﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ApprovalParentsList.aspx.cs" Inherits="Hostel_Management_System_Project.ApprovalParentsList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - Parents Approval
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <div class="container-fluid px-4">
                        
            <%-- greet label --%>
            <h3 class="mt-4 text-light">Welcome, <%= Session["name"] %></h3>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Admin Dashboard</li>
            </ol>
                        
            <%--parents table data--%>

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
                                            <th>Sl No</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Student</th>
                                            <th>Status</th>
                                            <th>Created At</th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("sl_no") %></td>
                                    <td><%# Eval("name") %></td>
                                    <td><%# Eval("email") %></td>
                                    <td><%# Eval("phone_number") %></td>
                                    <td><%# Eval("student_name") %></td>
                                    <td>
                                        <asp:Label ID="lbl_Status" runat="server" Text='<%# Eval("status") %>' CssClass='<%# GetStatusCssClass(Eval("status").ToString())+ " bold-status" %>'></asp:Label>
                                    </td>
                                    <td><%# Eval("created_at") %></td>
                                        <td>
                                        <asp:Button ID="btn_Approve" runat="server" CssClass="btn btn-success" Text="APPROVE"
                                            OnClick="btn_Approve_Click" CommandArgument='<%# Eval("parent_id") %>'
                                            Enabled='<%# Eval("status").ToString() != "Approved" %>' />
                                    </td>
                                    <td>
                                        <asp:Button ID="btn_Reject" runat="server" CssClass="btn btn-danger" Text="REJECT"
                                            OnClick="btn_Reject_Click" CommandArgument='<%# Eval("parent_id") %>'
                                            Enabled='<%# Eval("status").ToString() != "Rejected" %>' />
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
