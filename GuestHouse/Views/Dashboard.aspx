<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Views/Dashboard.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="GuestHouse.Views.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- Here We need to write some js code for load google chart with database data --%>

    <script src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#dtbl').dataTable();
            $("#txtExt").val('');
        });
        function openModal() {
            $('#ExtendModal').modal('show');
        }
        function GetConfirmation() {
            var reply = confirm("Are you sure you want to check-out this booking?");
            if (reply) {
                return true;
            }
            else {
                return false;
            }
        }
    </script>

    <%--   <script>
        var chartData; // globar variable for hold chart data

        google.charts.load('current', { packages: ['corechart'] });
        $(document).ready(function () {

            $.ajax({
                url: "Dashboard.aspx/GetChartData",
                data: "",
                dataType: "json",
                type: "POST",
                contentType: "application/json; chartset=utf-8",
                success: function (data) {
                    chartData = data.d;
                },
                error: function () {
                    alert("Error loading data! Please try again.");
                }
            }).done(function () {
                // after complete loading data
                google.setOnLoadCallback(drawChart);
                drawChart();
            });
        });

        function drawChart() {
            var data = google.visualization.arrayToDataTable(chartData);

            var options = {

                pointSize: 5,
                width: 230,
                height: 150,
                chartArea: { left: 20, top: 0, width: '90%', height: '90%' }
            };

            var pieChart = new google.visualization.PieChart(document.getElementById('RoomsChart'));
            pieChart.draw(data, options);

        }
    </script>--%>
</asp:Content>




<asp:Content ID="homeDashboard" runat="server" ContentPlaceHolderID="mainBody">
    <!-- This the main content of the page -->
    <main class="mt-5">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Overview</h1>
            </div>
        </div>

        <!-- This is the graph row -->
        <div class="row" style="margin-left: 20px">
            <!--  <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <div>Rooms Overview</div>
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fas fa-chart-pie mr-1"></i>
                                    </div>
                                    <div id="RoomsChart">
                                       
                                        
                                    </div>
                                </div>
                            </div>
                            </div>
                     </div> -->
             <div class="col-xl-3 col-sm-6 col-12">
                <div class="card card-1">
                    <div class="card-content">
                        <div class="card-body">
                            <div class="media d-flex">
                                <div class="media-body text-left">
                                    <h3 style="color: mediumslateblue" id="InHouse" runat="server"></h3>
                                    <span>Current In House</span>
                                </div>
                                <div class="align-self-center">
                                    <i class="fas fa-users fa-3x float-right" style="color: mediumslateblue"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
             <div class="col-xl-3 col-sm-6 col-12">
                <div class="card card-2">
                    <div class="card-content">
                        <div class="card-body">
                            <div class="media d-flex">
                                <div class="media-body text-left">
                                    <h3 style="color: dodgerblue" id="RoomsAvailable" runat="server"></h3>
                                    <span>Rooms Available</span>
                                </div>
                                <div class="align-self-center">
                                    <i class="fas fa-bed fa-3x float-right" style="color: dodgerblue"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
             <div class="col-xl-3 col-sm-6 col-12">
                <div class="card card-3">
                    <div class="card-content">
                        <div class="card-body">
                            <div class="media d-flex">
                                <div class="media-body text-left">
                                    <h3 style="color: lightcoral" id="RoomsBlocked" runat="server"></h3>
                                    <span>Rooms Blocked</span>
                                </div>
                                <div class="align-self-center">
                                    <i class="fas fa-ban fa-3x float-right" style="color: lightcoral"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-sm-6 col-12">
                <div class="card card-4">
                    <div class="card-content">
                        <div class="card-body">
                            <div class="media d-flex">
                                <div class="media-body text-left">
                                    <h3 style="color: lightgreen" id="Revenue" runat="server"></h3>
                                    <span>Revenue(Last 30 days)</span>
                                </div>
                                <div class="align-self-center">
                                    <i class="fas fa-rupee-sign fa-3x float-right" style="color: lightgreen"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        
  

        <!-- This is the DataTable -->
        <div class="row mt-5">
            <div class="col-lg-12">
                <h1 class="page-header">Active Bookings</h1>
            </div>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-12">
                    <asp:Repeater ID="rptTable" runat="server">
                        <HeaderTemplate>
                            <table class="table table-striped" id="dtbl">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Guest House</th>
                                        <th>Room Number</th>
                                        <th>Booking Type</th>
                                        <th>Booking From</th>
                                        <th>Booking To</th>
                                        <th>Occupants</th>
                                        <th>Amount</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("Name") %></td>
                                <td>
                                    <p><%# Eval("GuestHouse") %></p>
                                </td>
                                <td>
                                    <p>
                                        <%# Eval("RoomNumber") %>
                                    </p>
                                </td>
                                <td>
                                    <p>
                                        <%# Eval("BookingType") %>
                                    </p>
                                </td>
                                <td>
                                    <p>
                                        <%# Eval("BookingFrom")%>
                                    </p>
                                </td>
                                <td>
                                    <p>
                                        <%# Eval("BookingTo")%>
                                    </p>
                                </td>
                                <td>
                                    <p>
                                        <%# Eval("NoOfMembers")%>
                                    </p>
                                </td>
                                <td>
                                    <p>
                                        <%# Eval("TotalAmount")%>
                                    </p>
                                </td>
                                <td>
                                    <p style="display: none">
                                        <%# Eval("BookingID")%>
                                    </p>
                                    <asp:LinkButton runat="server" CssClass="btn btn-primary" ID="chkOut" Text='Check-Out' CommandArgument='<%# Eval("RoomID") +","+ Eval("BookingID") %>' OnClick="CheckOut_Click" OnClientClick="return GetConfirmation();" />
                                    <asp:LinkButton runat="server" CssClass="btn btn-outline-primary" ID="ShowExt" Text='Extend Booking' CommandArgument='<%# Eval("RoomID") +","+ Eval("BookingID") %>' OnClick="ShowExt_Click" />
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

        <div class="modal fade" id="ExtendModal" tabindex="-1" role="dialog" aria-labelledby="ModalTitle" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="ModalTitle">Extend Booking Form</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;</button>
                    </div>
                    <div class="modal-body">
                        <asp:Label ID="hiddenRoom" runat="server" Visible="false" />
                        <asp:Label ID="hiddenBooking" runat="server" Visible="false" />
                        <label for="txtExt">
                            Extend by:
                        </label>

                        <asp:TextBox type="number" ID="txtExt" runat="server" CssClass="form-control" placeholder="Enter Number of days" />
                        <br />

                        <div id="dvMessage" runat="server" visible="false" class="alert alert-danger">
                            <strong>Error!</strong>
                            <asp:Label ID="lblMessage" runat="server" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="btnExtend" runat="server" class="btn btn-success" onserverclick="OnExtend">
                            Extend Booking
                        </button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal">
                            Close</button>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
