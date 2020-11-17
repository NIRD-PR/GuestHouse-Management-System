<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Dashboard.Master" AutoEventWireup="true" CodeBehind="GeneralReport.aspx.cs" Inherits="GuestHouse.Views.GeneralReport" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
     <div class="row mt-4">
            <div class="col-lg-12">
                <h1 class="page-header">General Report</h1>
            </div>
        </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
Selection:
<asp:DropDownList ID="ddlDays" runat="server" OnSelectedIndexChanged="DaysChanged"
    AutoPostBack="true">
    <asp:ListItem Text="All" Value="10000" />
    <asp:ListItem Text="Last 30 days" Value="30" />
    <asp:ListItem Text="last 3 months" Value="91" />
    <asp:ListItem Text="Last 6 months" Value="182" />
    <asp:ListItem Text="Last year" Value="365" />
</asp:DropDownList>
<hr />

<rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="500" SizeToReportContent="true">
</rsweb:ReportViewer>
<br />
   

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Scripts" runat="server">
</asp:Content>
