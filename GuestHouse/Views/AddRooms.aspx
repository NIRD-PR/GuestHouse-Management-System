<%@ Page Title="" Language="C#" MasterPageFile="~/Views/admin.Master" AutoEventWireup="true" CodeBehind="AddRooms.aspx.cs" Inherits="GuestHouse.Views.AddRooms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainBody" runat="server">
    <!-- The new room form starts here -->
    <main>
        <div class="container-fluid">
            <div class="mb-4" id="formnew">
                <form role="form" id="newRoom" action="#" method="post" runat="server" style="margin-left: 20px">
                    <div class="jumbotron" style="padding-top: 5px; padding-bottom: 5px;">
                        <h2 class="mt-4" style="color: #007bff; font-family: 'Raleway',sans-serif; font-size: 40px; font-weight: 400; line-height: 72px; margin: 0 0 0px; text-align: left; text-transform: capitalize;">Enter Room Details</h2>
                    </div>
                    <br />
                    <asp:ScriptManager ID="ScriptManager2" runat="server">
                    </asp:ScriptManager>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="form-group col-md-8 mb-2">
                                <label class="required" for="guest_house">Guest House  </label>
                                &nbsp;&nbsp;&nbsp;&nbsp; 
                                <asp:DropDownList ID="DropDownListGH" runat="server" AutoPostBack="True" DataTextField="Name" DataValueField="GuestHouseID" Width="120px" Height="25px"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="valGH" runat="server" InitialValue="-1" ErrorMessage="Invalid Selection" ForeColor="Red" ControlToValidate="DropDownListGH"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group col-md-8 mb-2">
                                <label class="required" for="room_type">Room Type   </label>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:DropDownList ID="DropDownListRoom" runat="server" AutoPostBack="True" DataTextField="RoomType" DataValueField="RoomTypeID" Width="120px" Height="25px"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="valRT" runat="server" InitialValue="-1" ErrorMessage="Invalid Selection" ForeColor="Red" ControlToValidate="DropDownListRoom"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group col-md-4 mb-1">
                                <label class="required" for="total_room">Room Number</label>
                                <asp:TextBox type="number" ClientIDMode="Static" class="form-control" ID="room_number" placeholder="Room Number" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="valNumber" runat="server" ErrorMessage="Room Number is a  required field." ForeColor="Red" ControlToValidate="room_number"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group col-md-4 mb-1">
                                <label class="required" for="occupancy">Occupancy</label>
                                <asp:TextBox type="number" ClientIDMode="Static" class="form-control" name="occupancy" ID="occupancy" placeholder="Maximum number of occupants" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="valOcc" runat="server" ErrorMessage="Occupany is a  required field." ForeColor="Red" ControlToValidate="occupancy"></asp:RequiredFieldValidator>

                            </div>

                            <div class="form-group col-md-8 mb-2">
                                <label for="desc">Descriptions</label>
                                <input type="text" class="form-control" name="desc" id="desc" placeholder="">
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <!--<div class="form-group">
					<label for="img">Upload Room Image [recommended size is 400 X 400]: </label>
					<input id="img" type="file" class="form-control" name="img" title="load image"  >
                    <img id="imgRoom" height="150" width="150" style="border:solid" />
				 p class="help-block">Example block-level help text here.</p
				<br />
                </div>-->
                    <asp:Button class="btn btn-primary ml-2 mt-2" ID="addroom" runat="server" Text="Back" OnClientClick="javascript:window.location.href='RoomDetails.aspx'; return false;"></asp:Button>

                    <asp:Button class="btn btn-primary ml-2 mt-2" ID="submitBtn" runat="server" Text="Submit" ClientIDMode="Static"></asp:Button>

                </form>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                /* LoadRoomDetails();
                 $("#addroom").click(function () {
                     $("#formnew").toggle();
                     $("#roomDetail").toggle();
                 });
                 $("#back").click(function () {
                     $("#formnew").toggle();
                     $("#roomDetail").toggle();
                 });
                 */
                $("#submitBtn").click(function (e) {
                    e.preventDefault();
                    console.log("hello!");

                    var room = {};
                    // console.log(DropDownListRoom.SelectedItem.Value);

                    room.RoomNumber = $("#room_number").val();
                    room.RoomCapacity = $("#occupancy").val();
                    room.RoomDescription = $("#desc").val();
                    room.RoomTypeID = $("#<%=DropDownListRoom.ClientID%> option:selected").val();

                    room.GuestHouseID = $("#<%=DropDownListGH.ClientID%> option:selected").val();
                    //room.InputImage = $("#img").get(0).files[0];
                    if (room.RoomCapacity && room.RoomNumber && room.RoomTypeID && room.GuestHouseID) {
                        $.ajax({
                            type: "POST",

                            contentType: 'application/json;charset=utf-8',

                            url: 'AddRooms.aspx/SaveRoomDetails',
                            data: JSON.stringify({ roomData: JSON.parse(JSON.stringify(room)) }),
                            success: function (result) {
                                alert('success');
                                ResetRoomInformation();

                            },
                            error: function (result) {
                                alert(result.responseText);
                            }
                        });
                    }
                    return false;
                });

            });
            function DisplayImage(result) {
                if (result.files && result.files[0]) {
                    // console.log("hello");
                    var fileReader = new FileReader;
                    fileReader.onload = function (e) {
                        $("#imgRoom").attr('src', e.target.result);
                    }
                    fileReader.readAsDataURL(result.files[0]);
                }
            }

            function LoadRoomDetails() {
                $.ajax({
                    async: true,
                    data: 'GET',
                    dataType: 'HTML',
                    contentType: false,
                    processData: false,
                    url: 'RoomDetails.aspx/GetRoomDetails',
                    success: function (data) {
                    },
                    error: function () {
                        alert('There is an error in the request.');
                    }
                });

            }

            function ResetRoomInformation() {

                $("#room_number").val('');
                $("#occupancy").val('');
                $("#desc").val('');
                $("#<%=DropDownListRoom.ClientID%> option:selected").removeAttr('selected');

                $("#<%=DropDownListGH.ClientID%> option:selected").removeAttr('selected');
                $("#room_number").focus();
            }

        </script>
    </main>
</asp:Content>
