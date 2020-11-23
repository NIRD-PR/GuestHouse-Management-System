<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Dashboard.Master" AutoEventWireup="true" CodeBehind="GeneralReport.aspx.cs" Inherits="GuestHouse.Views.GeneralReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script type="text/javascript">
        $(function () {

            var tdate1 = $("#<%= starting_date.ClientID %>").flatpickr({
                enableTime: false,
                dateFormat: "Y-m-d",
                altInput: true,
                altFormat: "F j, Y",
                minDate: "",
                maxDate: "today"
                // defaultDate: new Date().fp_incr(-30)


            });
            var tdate2 = $("#<%= ending_date.ClientID %>").flatpickr({
                enableTime: false,
                dateFormat: "Y-m-d",
                altInput: true,
                altFormat: "F j, Y",
                maxDate: "today",
                // defaultDate: new Date()


            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
    <div class="row mt-4">
        <div class="col-lg-12">
            <h1 class="page-header">General Report</h1>
        </div>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <div class="form-row ml-2 mb-4 mt-3">
        <div class="col-md-3">
            <asp:Label runat="server" AssociatedControlID="starting_date" ID="lblSt">Start Date:</asp:Label>
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
