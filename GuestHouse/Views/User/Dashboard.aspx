<%@ Page Title="" Language="C#" MasterPageFile="~/Views/User/user.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="GuestHouse.Views.User.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- Here We need to write some js code for load google chart with database data --%>

    <script src="https://www.gstatic.com/charts/loader.js"></script>
   
   
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
    <main>
        <div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Home</h1>
		</div>
	</div>   

                <!-- This is the graph row -->
        <div class="row" style="margin-left:20px">
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
                    <div class="col-lg-3 col-md-6 ">
                        <div class="panel panel-red">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-users fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">80</div>
                                        <div>Guests Today</div>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-check fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">18</div>
                                        <div>Upcoming Reservations</div>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-yellow">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-bed fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">34</div>
                                        <div>New Bookings (This Month)</div>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    
                </div>

                <!-- This is the DataTable -->
                <div class="card mb-4 mt-3">
                    <div class="card-header">
                        <i class="fas fa-table mr-1"></i>
                        DataTable Example
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Position</th>
                                        <th>Office</th>
                                        <th>Age</th>
                                        <th>Start date</th>
                                        <th>Salary</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Tiger Nixon</td>
                                        <td>System Architect</td>
                                        <td>Edinburgh</td>
                                        <td>61</td>
                                        <td>2011/04/25</td>
                                        <td>$320,800</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
           
        </main>
</asp:Content>
