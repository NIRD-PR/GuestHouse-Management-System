<%@ Page Title="" Language="C#" MasterPageFile="~/Views/User/user.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="GuestHouse.Views.User.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- Here We need to write some js code for load google chart with database data --%>
    
    <script src="https://www.gstatic.com/charts/loader.js"></script>

    <script>
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
    </script>

</asp:Content>




<asp:Content ID="homeDashboard" runat="server" ContentPlaceHolderID="mainBody">
    <!-- This the main content of the page -->
        <main>
            <div class="container-fluid">
                <h1 class="mt-4">Dashboard</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">Dashboard</li>
                </ol>

                <!-- This is the graph row -->
                <div class="row">
                    <div class="col-xl-2">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-chart-pie mr-1"></i>
                                Rooms Overview
                            </div>
                            <div class="card-body"><div id="RoomsChart" ></div></div>
                        </div>
                    </div>
                    <div class="col-xl-6">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-chart-bar mr-1"></i>
                                Bar Chart Example
                            </div>
                            <div class="card-body"><canvas id="myBarChart" width="100%" height="40"></canvas></div>
                        </div>
                    </div>
                </div>

                <!-- This is the DataTable -->
                <div class="card mb-4">
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
            </div>
        </main>  
</asp:Content>