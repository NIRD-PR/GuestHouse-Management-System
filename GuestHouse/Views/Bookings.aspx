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

                $("[id*=bID]").html(data.BookingID);
                $("[id*=bFirst]").html(data.FirstName);
                $("[id*=bLast]").html(data.LastName);
                $("[id*=bBT]").html(data.BookingType);
                $("[id*=bMembers]").html(data.NoOfMembers);
                $("[id*=bPhNumber]").html(data.PhoneNo);
                $("[id*=bAddress]").html(data.Address);
                $("[id*=bAmount]").html(data.TotalAmount);
                var bFDate = new Date(parseInt(data.BookingFrom.substr(6)));
                var bFMonth = bFDate.getMonth() + 1;
                var BookingFrom = bFDate.getDate() + "/" + (bFMonth.length > 1 ? bFMonth : bFMonth) + "/" + bFDate.getFullYear() + "&nbsp;&nbsp;" + (bFDate.getHours() < 10 ? ("0" + bFDate.getHours()) : bFDate.getHours()) + ":" + (bFDate.getMinutes() < 10 ? ("0" + bFDate.getMinutes()) : bFDate.getMinutes());
                var bTDate = new Date(parseInt(data.BookingTo.substr(6)));
                var bTMonth = bTDate.getMonth() + 1;
                var BookingTo = bTDate.getDate() + "/" + (bTMonth.length > 1 ? bTMonth : bTMonth) + "/" + bTDate.getFullYear() + "&nbsp;&nbsp;" + (bTDate.getHours() < 10 ? ("0" + bTDate.getHours()) : bTDate.getHours()) + ":" + (bTDate.getMinutes() < 10 ? ("0" + bTDate.getMinutes()) : bTDate.getMinutes());

                $("[id*=bBookingFrom]").html(BookingFrom);
                $("[id*=bBookingTo]").html(BookingTo);

                if (type == "Training") {
                    $("[id*=trName]").html(data.TrainingName);
                    $("[id*=trDirector]").html(data.TrainingDirector);
                    var trFDate = new Date(parseInt(data.TrainingFrom.substr(6)));
                    var trFMonth = trFDate.getMonth() + 1;
                    var trainingFrom = trFDate.getDate() + "/" + (trFMonth.length > 1 ? trFMonth : trFMonth) + "/" + trFDate.getFullYear() + "&nbsp;&nbsp;" + (trFDate.getHours() < 10 ? ("0" + trFDate.getHours()) : trFDate.getHours()) + ":" + (trFDate.getMinutes() < 10 ? ("0" + trFDate.getMinutes()) : trFDate.getMinutes());
                    var trTDate = new Date(parseInt(data.TrainingTo.substr(6)));
                    var trTMonth = trTDate.getMonth() + 1;
                    var trainingTo = trTDate.getDate() + "/" + (trTMonth.length > 1 ? trTMonth : trTMonth) + "/" + trTDate.getFullYear() + "&nbsp;&nbsp;" + (trTDate.getHours() < 10 ? ("0" + trTDate.getHours()) : trTDate.getHours()) + ":" + (trTDate.getMinutes() < 10 ? ("0" + trTDate.getMinutes()) : trTDate.getMinutes());

                    $("[id*=trFrom]").html(trainingFrom);
                    $("[id*=trTo]").html(trainingTo);
                    //show the hidden training fields.
                  /*  $("[id*=lblTN]").css('display', 'inline'); 
                    $("[id*=lblTD]").css('display', 'inline'); 
                    $("[id*=lblTF]").css('display', 'inline'); 
                    $("[id*=lblTT]").css('display', 'inline'); 
                    $("[id*=trName]").css('display', 'inline');
                    $("[id*=trDirector]").css('display', 'inline');
                    $("[id*=trFrom]").css('display', 'inline');
                    $("[id*=trTo]").css('display', 'inline');*/
                }
                if (type == "Official Visit") {
                    $("[id*=ovPurp]").html(data.PurposeOfVisit);
                    $("[id*=ovWhom]").html(data.VisitingWhom);
                    $("[id*=ovCenter]").html(data.CenterVisiting);
                    //show the hidden official visit fields.
                  /*  $("[id*=lblPV]").css('display', 'inline');
                    $("[id*=lblCV]").css('display', 'inline');
                    $("[id*=lblVW]").css('display', 'inline');
                    
                    $("[id*=ovPurp]").css('display', 'inline');
                    $("[id*=ovWhom]").css('display', 'inline');
                    $("[id*=ovCenter]").css('display', 'inline');*/
                }
             /*   if (type == "Other") {
                    $("[id*=lblTN]").css('display', 'none');
                    $("[id*=lblTD]").css('display', 'none');
                    $("[id*=lblTF]").css('display', 'none');
                    $("[id*=lblTT]").css('display', 'none'); 
                    $("[id*=trName]").css('display', 'none');
                    $("[id*=trDirector]").css('display', 'none');
                    $("[id*=trFrom]").css('display', 'none');
                    $("[id*=trTo]").css('display', 'none');

                    $("[id*=lblPV]").css('display', 'none');
                    $("[id*=lblCV]").css('display', 'none');
                    $("[id*=lblVW]").css('display', 'none');
                    $("[id*=ovPurp]").css('display', 'none');
                    $("[id*=ovWhom]").css('display', 'none');
                    $("[id*=ovCenter]").css('display', 'none');
                }*/
                
                $("#dialogBg").dialog({
                    title: "Booking Details",
                    buttons: {
                        Ok: function () {
                            $(this).dialog('close');
                        },
                        Print: function () {
                            printArea();
                        }
                    },
                    modal: true,
                    dialogClass: 'no-close bookings-dialog',
                    close: function (event, ui) {
                        //clearing the optional fields.
                        $("[id*=trName]").html("");
                        $("[id*=trDirector]").html("");
                        $("[id*=trFrom]").html("");
                        $("[id*=trTo]").html("");
                        $("[id*=ovPurp]").html("");
                        $("[id*=ovWhom]").html("");
                        $("[id*=ovCenter]").html("");
                    }
                });
                return false;
            });
        });
        function OnSuccess(response) {
            tablegv = $("[id*=gvBookings]").DataTable(
                {

                    bLengthChange: true,
                    lengthMenu: [[5, 10, -1], [5, 10, "All"]],
                    bFilter: true,
                    bSort: true,
                    bPaginate: true,
                    data: response.d,
                    columns: [
                        {
                            'data': 'BookingID',
                            'render': function (data, type, row) {
                                return '<button class="btn btn-link" data-id="' + row[2] + '" data-title="' + row[2] + '" >' + data + '</button>';
                            },
                        },
                        { 'data': 'FirstName' },
                        { 'data': 'LastName' },
                        {
                            'data': 'BookingType',
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
                        {
                            "targets": [13],
                            "visible": false,
                            "searchable": false
                        },


                    ],


                });
        };
        function printArea() {
            var contents = document.getElementById("dialogBg").innerHTML;
            var frame1 = document.createElement('iframe');
            frame1.name = "frame1";
            frame1.style.position = "absolute";
            frame1.style.top = "-1000000px";
            document.body.appendChild(frame1);
            var frameDoc = frame1.contentWindow ? frame1.contentWindow : frame1.contentDocument.document ? frame1.contentDocument.document : frame1.contentDocument;
            frameDoc.document.open();
            frameDoc.document.write('<html><head><title>NIRDPR</title>');
            frameDoc.document.write('</head><body>');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                document.body.removeChild(frame1);
            }, 500);
            return false;
        }
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


                    <asp:GridView ID="gvBookings" runat="server" CssClass="gvBookings" HeaderStyle-CssClass="gvHeader" AllowPaging="true" AutoGenerateColumns="false" ClientIDMode="Static">
                        <Columns>
                            <asp:BoundField DataField="BookingID" HeaderText="Booking ID" />
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




                <br />
                <div id="dialogBg" style="display: none">
                    <b>Booking ID: </b><span id="bID"></span>
                    <br />
                    <b>First Name: </b><span id="bFirst"></span>
                    <br />
                    <b>Last Name: </b><span id="bLast"></span>
                    <br />
                    <b>Booking Type: </b><span id="bBT"></span>
                    <br />
                    <b>Number of Members: </b><span id="bMembers"></span>
                    <br />
                    <b>Booking From: </b><span id="bBookingFrom"></span>
                    <br />
                    <b>Booking To: </b><span id="bBookingTo"></span>
                    <br />
                    <b>Phone Number </b><span id="bPhNumber"></span>
                    <br />
                    <b>Address: </b><span id="bAddress"></span>
                    <br />
                    <b>Total Amount: </b><span id="bAmount"></span>
                    <br />
                    <b id="lblPV" >Purpose Of Visit:</b> <span id="ovPurp" ></span>
                    <br />
                    <b id="lblCV" >Center Visiting:</b> <span id="ovCenter" ></span>
                    <br />
                    <b id="lblVW" >Visiting Whom:</b> <span id="ovWhom" ></span>
                    <br />
                    <b id="lblTN" >Training Name:</b> <span id="trName" ></span>
                    <br />
                    <b id="lblTR" >Training Director:</b> <span id="trDirector" ></span>
                    <br />
                    <b id="lblTF" >Training From:</b> <span id="trFrom" ></span>
                    <br />
                    <b id="lblTT" >Training To:</b> <span id="trTo" ></span>
                </div>


            </div>
        </div>
    </main>
</asp:Content>
