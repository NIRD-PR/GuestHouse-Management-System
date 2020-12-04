<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Dashboard.Master" AutoEventWireup="true" CodeBehind="TrainingReport.aspx.cs" Inherits="GuestHouse.Views.TrainingReport" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
    <div class="row mt-4">
        <div class="col-lg-12">
            <h1 class="page-header">Training Report</h1>
        </div>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <div class="form-row ml-2 mb-4 mt-3">
        <div class="col-md-3">
            <asp:Label runat="server" AssociatedControlID="Programe Name" ID="lblSt">Program Name:</asp:Label>
            <asp:TextBox data-input ClientIDMode="Static" class="form-control" ID="starting_date" runat="server" OnTextChanged="TextChanged" AutoPostBack="true"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" AssociatedControlID="ending_date" ID="LabelEn">End Date:</asp:Label>
            <asp:TextBox data-input ClientIDMode="Static" class="form-control" ID="ending_date" runat="server" OnTextChanged="TextChanged" AutoPostBack="true"></asp:TextBox>
        </div>
    </div>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="500" SizeToReportContent="true">
    </rsweb:ReportViewer>


    <br />


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Scripts" runat="server">
</asp:Content>
