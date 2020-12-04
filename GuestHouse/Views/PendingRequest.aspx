<%@ Page Title="PendingRequest" Language="C#" MasterPageFile="~/Views/Dashboard.Master" AutoEventWireup="true" CodeBehind="PendingRequest.aspx.cs" Inherits="GuestHouse.Views.PendingRequest" %>

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

              </tbody>
            </table>
          </div>
        </div>
    </div>
    </main>
</asp:Content>
