﻿<%@ Page Title="" Language="C#" MasterPageFile="~/ParentSite.Master" AutoEventWireup="true" CodeBehind="P_ViewChildComplaintsList.aspx.cs" Inherits="Hostel_Management_System_Project.P_ViewChildComplaintsList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Zafe HMS - My Child Complaints List
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <%-- Table Information --%>

        <div class="container-fluid px-4">
            <%-- greet label --%>
            <h3 class="mt-4 text-light">Welcome, <%= Session["name"] %></h3>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Parent Dashboard</li>
            </ol>

            <%--complaints table data--%>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-table me-1"></i>
                    My Child Complaints
                </div>
                <div class="card-body bg-dark">
                    <div class="table-responsive">
                        <asp:Repeater ID="ComplaintRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped table-dark" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Sl No</th>
                                            <th>Cmp No</th>
                                            <th>Name</th>
                                            <th>Phone</th>
                                            <th>Complaint</th>
                                            <th>Status</th>
                                            <th>Reply</th>
                                            <th>Created At</th>
                                         
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("sl_no") %></td>
                                    <td><%# Eval("complaint_id") %></td>
                                    <td><%# Eval("st_name") %></td>
                                    <td><%# Eval("st_phone") %></td>
                                    <td><%# Eval("complaint") %></td>
                                    <td><%# Eval("complaint_status") %></td>
                                    <td <%# Eval("reply") == DBNull.Value ? "style='color: cadetblue;'" : "" %>><b><%# Eval("reply") != DBNull.Value ? Eval("reply") : "Awaiting Admin reply" %></b></td>
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
