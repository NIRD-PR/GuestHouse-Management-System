<%@ Page Title="Current Management" Language="C#" MasterPageFile="~/Views/admin.Master" AutoEventWireup="true" CodeBehind="CurrentManagement.aspx.cs" Inherits="GuestHouse.Views.CurrentManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../js/CurrentManagement.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainBody" runat="server">
    <main>
	<div class="container-fluid">
        <div class="mb-4">
			<h2 class="mt-4">Current Management</h2>
            <br />
          <div class="table-responsive">
            <table class="table table-striped" id="managementTable" width="100%" cellspacing="0">
              <thead class="grey lighten-2">
                <tr>
                    <th>Name</th>
                    <th>Mobile No.</th>
			        <th>ID</th>
                    <th>Email</th>
                    <th>Primary Role</th>
                    <th hidden>Primary Role</th>
                    <th>Secondary Role</th>
                    <th hidden>Secondary Role</th>
                    <th>Actions</th>
                    <th hidden>Actions</th>
                </tr>
              </thead>
              <tbody id="managementinfo">
				  <tr>
                    <td>lorem ipsum</td>
                    <td>lorem ipsum</td>
                    <td>lorem ipsum</td>
                    <td name="email">lorem ipsum</td>
                    <td name="displayPrimaryRole"><span class="displayPrimaryRole">Admin</span></td>
                    <td name="selectPrimaryRole" class="required" hidden>
                        <select class="btn btn-light btn-sm roles">
                            <option value=""><--Select--></option>
                            <option value="Admin">Admin</option>
                            <option value="User">User</option>
                        </select>
                    </td>
                    <td name="displaySecondaryRole">User</td>
                    <td name="selectSecondaryRole" hidden>
                        <select class="btn btn-light btn-sm roles">
                            <option value=""><--Select--></option>
                            <option value="Admin">Admin</option>
                            <option value="User">User</option>
                        </select>
                    </td>                    
                    <td name="defaultAction">
                        <i class="fa fa-edit alert-success" onclick="editRowfxn(this)"></i>
                        &nbsp
                        <i class="fa fa-trash alert-danger" onclick="deleteRowfxn(this)"></i>
                    </td>
                    <td name="editAction" hidden>
                        <i class="fa fa-check alert-success" onclick="acceptfxn(this)"></i>
                        &nbsp
                        <i class="fa fa-close alert-danger" onclick="canclefxn(this)"></i>
                    </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
    </div>
    </main>
</asp:Content>
