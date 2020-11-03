<%@ Page Title="PendingRequestTrial" Language="C#" MasterPageFile="~/Views/Dashboard.Master" AutoEventWireup="true" CodeBehind="PendingRequestTrial.aspx.cs" Inherits="GuestHouse.Views.PendingRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../js/dist/jquery.simple-checkbox-table.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#collapseManagement").collapse('show');
            $('.roles-table-lib').select2();
            //$("table#roomsTable").simpleCheckboxTable();

            //driver code
            ajaxPendingRegistration().then((data) => updateTable(data.d));

            // ajax function to retrieve data from server
            async function ajaxPendingRegistration() {
                const result = await $.ajax({
                    type: "POST",
                    url: "PendingRequestTrial.aspx/GetPendingRequestTrials",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json"
                });
                return result;
            }

            // function to dynamically update the table
            function updateTable(res) {
                var data = $.parseJSON(res);
                //console.log(data);

                var requests = '';
                $.each(data.Table, function (key, value) {
                    requests += '<tr>';
                    //requests += '<td><input type = "checkbox" name="rowBox"></td>';
                    requests += '<td>' + value.FirstName + ' ' + value.LastName + '</td>';
                    requests += '<td>' + value.MobileNo + '</td>';
                    requests += '<td>' + value.ID + '</td>';
                    requests += '<td name="email">' + value.Email + '</td>';
                    requests += '<td>';
                    requests += '<i class="fa fa-check alert-success" onclick="acceptRowfxn(this)"></i>';
                    requests += '&nbsp &nbsp';
                    requests += '<i class="fa fa-trash alert-danger" onclick = "rejectRowfxn(this)"></i>';
                    requests += '</td > ';
                    requests += '</tr>';
                });
                $('#requestTable').append(requests);
                $('#requestTable').DataTable();
                $('.dataTables_length').addClass('bs-select');
            }
            /*
            $("#requestPage").hide();

            $("#managementButton").click(function () {
                //var element = document.getElementById("managementButton");
                $("#requestPage").hide();
                $("#managementTable").show();                
                $("#managementButton").removeClass("btn-light");
                $("#managementButton").addClass("btn-primary");
                $("#requestButton").removeClass("btn-primary");
                $("#requestButton").addClass("btn-light");
            });

            $("#requestButton").click(function () {
                //var element = document.getElementById("managementButton");
                $("#managementTable").hide();
                $("#requestPage").show();                
                $("#managementButton").removeClass("btn-primary");
                $("#managementButton").addClass("btn-light");
                $("#requestButton").removeClass("btn-light");
                $("#requestButton").addClass("btn-primary");                
            });
            */
        });

        // ajax function to reject request
        function rejectRequest(email) {
            console.log("inside reject");
            console.log(email);

            var postData = {
                email: email
            };

            const result = $.ajax({
                type: "POST",
                url: "PendingRequestTrial.aspx/RejectRequests",
                data: JSON.stringify(postData),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                traditional: true,
                success: function () {
                    $(cntx).closest("tr").remove();
                },
                failure: function () {
                    alert("Reject Request Failed");
                }
            });
            return result;
        }

        function rejectRowfxn(cntx) {
            console.log("rejectRowfxn");           
            var email = $(cntx).closest("tr").find('td[name = "email"]').text();
            console.log(email);
            if (email) {
                rejectRequest(email, cntx);
            }
        }

        // ajax function to accept request
        function acceptRequest(email, roles, cntx) {
            console.log("inside accept");
            console.log(email);

            var postData = {
                email: email,
                roles: roles 
            };

            const result = $.ajax({
                type: "POST",
                url: "PendingRequestTrial.aspx/AcceptRequests",
                data: JSON.stringify(postData),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                traditional: true,
                success: function () {
                    $(cntx).closest("tr").remove();
                },
                failure: function () {
                    alert("Accept Request Failed");
                }
            });
            return result;
        }

        function acceptRowfxn(cntx) {
            console.log("acceptRowfxn");
            var select = $(cntx).closest("tr").find("td[name = 'selectRoles']").find("select");
            var roles = select.val();
            if (roles.length <1) {
                alert("Select atleast one Role before accepting!");
            }
            console.log(roles);
            var email = $(cntx).closest("tr").find('td[name = "email"]').text();
            console.log(email);
            if (email) {
                acceptRequest(email,roles,cntx);
            }
        }

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainBody" runat="server">
    <main>
	<div class="container-fluid">
        <div class="mb-4">
			<h2 class="mt-4">Pending Requests</h2>
            <!--<div class="btn-group btn-group-toggle mt-4 btn-group-lg" role="group">
              <button type="button" class="btn btn-primary" id="managementButton">Management</button>
              <button type="button" class="btn btn-light" id="requestButton">Pending Request</button>
            </div>
            <br />-->
            <br />
          <div class="table-responsive">
            <table class="table table-striped" id="requestTable" width="100%" cellspacing="0">
              <thead class="grey lighten-2">
                <tr>
                    <!--<th><input type="checkbox" id="masterCheckbox"></th>-->
                    <th>Name</th>
                    <th>Mobile No.</th>
			        <th>ID</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
              </thead>
              <tbody id="requestinfo">
				  <tr>
                    <!--<td><input type="checkbox" name="rowBox"></td>-->
                    <td>lorem ipsum</td>
                    <td>lorem ipsum</td>
                    <td>lorem ipsum</td>
                    <td name="email">lorem ipsum</td>
                    <td name="selectRoles" class="required" id="selectRoles">
                        <select class="btn btn-light roles-table-lib" multiple>
                            <option value="Admin">Admin</option>
                            <option value="User">User</option>
                        </select>
                    </td>
                    <td><i class="fa fa-check alert-success" onclick="acceptRowfxn(this)"></i>&nbsp &nbsp<i class="fa fa-trash alert-danger" onclick="rejectRowfxn(this)"></i></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
    </div>
    </main>
</asp:Content>
