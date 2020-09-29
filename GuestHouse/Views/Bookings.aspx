<%@ Page Title="" Language="C#" MasterPageFile="~/Views/admin.Master" AutoEventWireup="true" CodeBehind="Bookings.aspx.cs" Inherits="GuestHouse.Views.Bookings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: 'Bookings.aspx/GetBookings',
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });
        });
        function OnSuccess(response) {
            $("[id*=gvBookings]").DataTable(
                {
                    bLengthChange: true,
                    lengthMenu: [[5, 10, -1], [5, 10, "All"]],
                    bFilter: true,
                    bSort: true,
                    bPaginate: true,
                    data: response.d,
                    columns: [
                        { 'data': 'FirstName' },
                        { 'data': 'LastName' },
                        { 'data': 'NoOfMembers' },
                        {
                            'data': 'BookingFrom',
                            'render': function (date) {
                                var date = new Date(parseInt(date.substr(6)));
                                var month = date.getMonth() + 1;
                                return date.getDate() + "/" + (month.length > 1 ? month : month) + "/" + date.getFullYear() + "&nbsp;&nbsp;" + (date.getHours() < 10 ? ("0" + date.getHours()) : date.getHours()) + ":" + (date.getMinutes() < 10 ? ("0" + date.getMinutes()) : date.getMinutes());
                            }
                        },
                        {
                            'data': 'BookingTo',
                            "render": function (date) {
                                var date = new Date(parseInt(date.substr(6)));
                                var month = date.getMonth() + 1;
                                return date.getDate() + "/" + (month.length > 1 ? month : month) + "/" + date.getFullYear() + "&nbsp;&nbsp;" + (date.getHours() < 10 ? ("0" + date.getHours()) : date.getHours()) + ":" + (date.getMinutes() < 10 ? ("0" + date.getMinutes()) : date.getMinutes());
                            }
                        },
                        { 'data': 'PhoneNo' },
                        { 'data': 'Address' },
                        { 'data': 'TotalAmount' }

                    ]

                });
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainBody" runat="server">
    <main>
        <div class="container-fluid">
            <div class="mb-4" id="roomDetail">
                <div class="jumbotron" style="padding-top: 5px; padding-bottom: 5px;">
                    <h2 class="mt-4" style="color: #007bff; font-family: 'Raleway',sans-serif; font-size: 62px; font-weight: 600; line-height: 72px; margin: 0 0 0px; text-align: center; text-transform: uppercase;">Booking Details</h2>
                </div>
                <br />

                <form role="form" id="Booking" action="#" method="post" runat="server" style="margin-left: 15px">
                    <asp:Button type="button" class="btn btn-primary" ID="addBooking" runat="server" PostBackUrl="~/Views/AddBookings.aspx" Text="New Booking"></asp:Button>
                    <div style="margin-top: 20px; width: 1500px">
                        <asp:GridView ID="gvBookings" runat="server" CssClass="gvBookings" HeaderStyle-CssClass="gvHeader" AllowPaging="true" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                                <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                                <asp:BoundField DataField="NoOfMembers" HeaderText="Number of Members" />
                                <asp:BoundField DataField="BookingFrom" HeaderText="Booking From" DataFormatString="{0:MM-dd-yyyy hh:mm tt}" />
                                <asp:BoundField DataField="BookingTo" HeaderText="Booking To" DataFormatString="{0:MM-dd-yyyy hh:mm tt}" />
                                <asp:BoundField DataField="PhoneNo" HeaderText="Phone Number" />
                                <asp:BoundField DataField="Address" HeaderText="Address" />
                                <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" />
                            </Columns>
                        </asp:GridView>
                    </div>


                </form>
            </div>
        </div>
    </main>
</asp:Content>
