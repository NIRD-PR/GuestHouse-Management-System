<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Dashboard.Master" AutoEventWireup="true" CodeBehind="Bookings.aspx.cs" Inherits="GuestHouse.Views.Bookings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://code.jquery.com/ui/1.12.1/themes/ui-lightness/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script
        src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
        integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU="
        crossorigin="anonymous"></script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            var tablegv = "";
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
            $('#gvBookings tbody').on('click', 'button', function () {
                var table = $.fn.dataTable.tables({ api: true });
                var data = table.row($(this).closest('tr')).data();
                var type = data.BookingType;
                console.log(type);
                if (type == "Training") { 
                $("[id*=trName]").html(data.TrainingName);
                $("[id*=trDirector]").html(data.TrainingDirector);
                    var trFDate = new Date(parseInt(data.TrainingFrom.substr(6)));
                    var trFMonth = trFDate.getMonth() + 1;
                    var trainingFrom =trFDate.getDate() + "/" + (trFMonth.length > 1 ? trFMonth : trFMonth) + "/" + trFDate.getFullYear() + "&nbsp;&nbsp;" + (trFDate.getHours() < 10 ? ("0" + trFDate.getHours()) : trFDate.getHours()) + ":" + (trFDate.getMinutes() < 10 ? ("0" + trFDate.getMinutes()) : trFDate.getMinutes());
                    var trTDate = new Date(parseInt(data.TrainingTo.substr(6)));
                    var trTMonth = trTDate.getMonth() + 1;
                    var trainingTo = trTDate.getDate() + "/" + (trTMonth.length > 1 ? trTMonth : trTMonth) + "/" + trTDate.getFullYear() + "&nbsp;&nbsp;" + (trTDate.getHours() < 10 ? ("0" + trTDate.getHours()) : trTDate.getHours()) + ":" + (trTDate.getMinutes() < 10 ? ("0" + trTDate.getMinutes()) : trTDate.getMinutes());

                $("[id*=trFrom]").html(trainingFrom);
                $("[id*=trTo]").html(trainingTo);
                $("#dialogTr").dialog({
                    title: "Training Details",
                    buttons: {
                        Ok: function () {
                            $(this).dialog('close');
                        }
                    },
                    modal: true,
                    dialogClass: 'no-close bookings-dialog'
                });
            }
                if (type == "Official Visit") {
                    $("[id*=ovPurp]").html(data.PurposeOfVisit);
                    $("[id*=ovWhom]").html(data.VisitingWhom);
                    $("[id*=ovCenter]").html(data.CenterVisiting);
                    $("#dialogOv").dialog({
                        title: "Official Visit Details",
                        buttons: {
                            Ok: function () {
                                $(this).dialog('close');
                            }
                        },
                        modal: true,
                        dialogClass: 'no-close bookings-dialog'
                    });
                }
                return false;
            });
            /*   $("#ModalDetails").on('show.bs.modal', function (e) {
                   var triggerLink = $(e.relatedTarget);
                   console.log($(e.relatedTarget));
                   var trName = triggerLink.data("TrainingName");
                   var trDirector = triggerLink.data("TrainingDirector");
                   var title = triggerLink.data("BookingType");
                   var id = $(e.relatedTarget).data('id');
                   $("#modalTitle").text(title);
                   $(this).find(".modal-body").html("<h5>id: " + id + "</h5>");
                   $(this).find(".modal-body").html("<h5>Training Name: " + trName + "</h5>");
                   $(this).find(".modal-body").html("<h5>Training Director: " + trDirector + "</h5>");
               }).modal('show');*/
        });
        function OnSuccess(response) {
         tablegv=   $("[id*=gvBookings]").DataTable(
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
                        {
                            'data': 'BookingType',
                            'render': function (data, type, row) {
                                return '<button class="btn btn-link" data-id="' + row[2] + '" data-title="' + row[2] + '" >' + data + '</button>';
                            },
                            
                        },
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
                        { 'data': 'TotalAmount' },
                        { 'data': 'TrainingName' },
                        { 'data': 'TrainingDirector' },
                        {
                            'data': 'TrainingFrom',
                            'render': function (date) {
                                if (date) {
                                    var date = new Date(parseInt(date.substr(6)));
                                    var month = date.getMonth() + 1;
                                    return date.getDate() + "/" + (month.length > 1 ? month : month) + "/" + date.getFullYear() + "&nbsp;&nbsp;" + (date.getHours() < 10 ? ("0" + date.getHours()) : date.getHours()) + ":" + (date.getMinutes() < 10 ? ("0" + date.getMinutes()) : date.getMinutes());
                                }
                                return "-";
                            }
                        },
                        {
                            'data': 'TrainingTo',
                            'render': function (date) {
                                if (date) {
                                    var date = new Date(parseInt(date.substr(6)));
                                    var month = date.getMonth() + 1;
                                    return date.getDate() + "/" + (month.length > 1 ? month : month) + "/" + date.getFullYear() + "&nbsp;&nbsp;" + (date.getHours() < 10 ? ("0" + date.getHours()) : date.getHours()) + ":" + (date.getMinutes() < 10 ? ("0" + date.getMinutes()) : date.getMinutes());
                                }
                                return "-";
                            }
                        },
                       
                         

                    ],
                    "columnDefs": [
                        {
                            "targets": [9],
                            "visible": false,
                            "searchable": false
                        },
                        {
                            "targets": [10],
                            "visible": false,
                            "searchable": false
                        },
                        {
                            "targets": [11],
                            "visible": false,
                            "searchable": false
                        },
                        {
                            "targets": [12],
                            "visible": false,
                            "searchable": false
                        },


                    ],


                });
        };
        /*  function openTrPopup(trName, trDirector, trFrom, trTo) {
                      $('#lblName').text(trName);
                      $('#lblDir').text(trDirector);
                      $('#lblFrom').text(trFrom);
                      $('#lblTo').text(trTo);
                      $("#TrainingDetails").dialog({
                          title: "Training Details",
                          width: 300,
                          height: 250,
                          modal: true,
                          buttons: {
                              Close: function () {
                                  $(this).dialog('close');
                              }
                          }
                      });
                  }*/

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

               
                    <asp:Button type="button" class="btn btn-primary" ID="addBooking" runat="server" PostBackUrl="~/Views/AddBookings.aspx" Text="New Booking"></asp:Button>
                    <div style="margin-top: 20px; width: 100%; text-align: center">


                        <asp:GridView ID="gvBookings" runat="server" CssClass="gvBookings" HeaderStyle-CssClass="gvHeader" AllowPaging="true" AutoGenerateColumns="false" ClientIDMode="Static" >
                            <Columns>
                                <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                                <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                                <asp:BoundField DataField="BookingType" HeaderText="Booking Type " />
                                <asp:BoundField DataField="NoOfMembers" HeaderText="Number of Members" />
                                <asp:BoundField DataField="BookingFrom" HeaderText="Booking From" DataFormatString="{0:MM-dd-yyyy hh:mm tt}" />
                                <asp:BoundField DataField="BookingTo" HeaderText="Booking To" DataFormatString="{0:MM-dd-yyyy hh:mm tt}" />
                                <asp:BoundField DataField="PhoneNo" HeaderText="Phone Number" />
                                <asp:BoundField DataField="Address" HeaderText="Address" />
                                <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" />
                                <asp:BoundField DataField="TrainingName" HeaderText="Training Name" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                <asp:BoundField DataField="TrainingDirector" HeaderText="Training Director" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                <asp:BoundField DataField="TrainingFrom" HeaderText="Training From" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                <asp:BoundField DataField="TrainingTo" HeaderText="Training To" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />

                            </Columns>
                        </asp:GridView>

                    </div>



                    <div id="dialogTr" style="display: none">
                        <b>Training Name:</b> <span id="trName"></span>
                        <br />
                        <b>Training Director:</b> <span id="trDirector"></span>
                        <br />
                        <b>Training From:</b> <span id="trFrom"></span>
                        <br />
                        <b>Training To:</b> <span id="trTo"></span>
                    </div>
                    <br />

                    <div id="dialogOv" style="display: none">
                        <b>Purpose Of Visit:</b> <span id="ovPurp"></span>
                        <br />
                        <b>Center Visiting:</b> <span id="ovCenter"></span>
                        <br />
                        <b>Visiting Whom:</b> <span id="ovWhom"></span>
                        <br />
                       
                    </div>
                    <br />

               
            </div>
        </div>
    </main>
</asp:Content>
