<%@ Page Title="PendingRequest" Language="C#" MasterPageFile="~/Views/admin.Master" AutoEventWireup="true" CodeBehind="PendingRequest.aspx.cs" Inherits="GuestHouse.Views.PendingRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../js/PendingRequest.js" type="text/javascript"></script>    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainBody" runat="server">
    <main>
	<div class="container-fluid">
        <div class="mb-4">
			<h2 class="mt-4">Pending Requests</h2>
            <br />
          <div class="table-responsive">
            <table class="table table-striped" id="requestTable" width="100%" cellspacing="0">
              <thead class="grey lighten-2">
                <tr>
                    <th>Name</th>
                    <th>Mobile No.</th>
			        <th>ID</th>
                    <th>Email</th>
                    <th>Primary Role</th>
                    <th>Secondary Role</th>
                    <th id="action">Actions</th>
                </tr>
              </thead>
              <tbody id="requestinfo">
				  <tr>
                    <td>lorem ipsum</td>
                    <td>lorem ipsum</td>
                    <td>lorem ipsum</td>
                    <td name="email">lorem ipsum</td>
                    <td name="selectPrimaryRole" class="required">
                        <select class="btn btn-light btn-sm roles">
                            <option value=""><--Select--></option>
                            <option value="Admin">Admin</option>
                            <option value="User">User</option>
                        </select>
                    </td>
                    <td name="selectSecondaryRole">
                        <select class="btn btn-light btn-sm roles">
                            <option value=""><--Select--></option>
                            <option value="Admin">Admin</option>
                            <option value="User">User</option>
                        </select>
                    </td>
                    <td headers="action"><i class="fa fa-check alert-success" onclick="acceptRowfxn(this)"></i>&nbsp &nbsp<i class="fa fa-trash alert-danger" onclick="rejectRowfxn(this)"></i></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
    </div>
    </main>
</asp:Content>
