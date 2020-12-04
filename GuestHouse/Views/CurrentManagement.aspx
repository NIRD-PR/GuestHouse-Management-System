<%@ Page Title="Current Management" Language="C#" MasterPageFile="~/Views/Dashboard.Master" AutoEventWireup="true" CodeBehind="CurrentManagement.aspx.cs" Inherits="GuestHouse.Views.CurrentManagement" %>
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
                 
              </tbody>
            </table>
          </div>
        </div>
    </div>
    </main>
</asp:Content>
