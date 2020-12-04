
$(document).ready(function () {
    $("#collapseManagement").collapse('show');

    //driver code
    ajaxPendingRequests().then((data) => updateTable(data.d));

    // ajax function to retrieve data from server
    async function ajaxPendingRequests() {
        const result = await $.ajax({
            type: "POST",
            url: "PendingRequest.aspx/GetPendingRequests",
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
        var temp = '';
        temp += '<td name="selectPrimaryRole" class="required">';
        temp += '<select class="btn btn-light btn-sm roles">';
        temp += '<option value=""><--Select--></option>';
        temp += '<option value="">Admin</option>';
        temp += '<option value="">Reception</option>';
        temp += '</select>';
        temp += '</td>';
        temp += '<td name="selectSecondaryRole">';
        temp += '<select class="btn btn-light btn-sm roles">';
        temp += '<option value=""><--Select--></option>';
        temp += '<option value="">Admin</option>';
        temp += '<option value="">Reception</option>';
        temp += '</select>';
        temp += '</td>';
        temp += '<td>';
        temp += '<i class="fa fa-check alert-success" onclick="acceptRowfxn(this)"></i>';
        temp += '&nbsp &nbsp';
        temp += '<i class="fa fa-trash alert-danger" onclick = "rejectRowfxn(this)"></i>';
        temp += '</td>';

        $.each(data.Table, function (key, value) {
            requests += '<tr>';
            //requests += '<td><input type = "checkbox" name="rowBox"></td>';
            requests += '<td>';
            requests += value.FirstName + ' ';
            if (value.LastName) {
                requests += value.LastName;
            }
            requests += '</td>';
            requests += '<td>' + value.MobileNo + '</td>';
            requests += '<td>' + value.ID + '</td>';
            requests += '<td name="email">' + value.Email + '</td>';
            requests += temp;
            requests += '</tr>';
        });
        $('#requestTable').append(requests);
        $('#requestTable').DataTable();
        $('.dataTables_length').addClass('bs-select');
    }

    ////driver code
    //ajaxRoles().then((data) => updateSelect(data.d));

    //// ajax function to retrieve roles
    //async function ajaxRoles() {
    //    const result = await $.ajax({
    //        type: "POST",
    //        url: "PendingRequest.aspx/GetRoles",
    //        data: "{}",
    //        contentType: "application/json; charset=utf-8",
    //        dataType: "json"
    //    });
    //    return result;
    //}

    //function updateSelect(data) {
    //    var roles = $.parseJSON(data);
    //    //console.log(roles);
    //    var select = $(".roles");
    //    $.each(roles.Table, function (key, val) {
    //        //console.log(val.Role);
    //        select.append(
    //            $("<option></option>").val(val.Role).html(val.Role)
    //        );
    //    });
    //}
});

// ajax function to reject request
function rejectRequest(email, cntx) {
    //console.log("inside reject");
    //console.log(email);

    var postData = {
        email: email
    };

    const result = $.ajax({
        type: "POST",
        url: "PendingRequest.aspx/RejectRequests",
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
    //console.log("rejectRowfxn");
    var email = $(cntx).closest("tr").find('td[name = "email"]').text();
    //console.log(email);
    if (email) {
        alert("Are you sure you want to REJECT this request?");
        rejectRequest(email, cntx);
    }
}

// ajax function to accept request
function acceptRequest(email, primaryRole, secondaryRole, cntx) {
    //console.log("inside accept");
    //console.log(email);
    //console.log(primaryRole);
    //console.log(secondaryRole);

    var postData = {
        email: email,
        primaryRole: primaryRole,
        secondaryRole: secondaryRole
    };

    const result = $.ajax({
        type: "POST",
        url: "PendingRequest.aspx/AcceptRequests",
        data: JSON.stringify(postData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        traditional: true,
        success: function () {
            $(cntx).closest("tr").remove();
            alert("Accept Request Successful!");
        },
        failure: function () {
            alert("Accept Request Failed");
        }
    });
    return result;
}

function acceptRowfxn(cntx) {
    //console.log("acceptRowfxn");
    var select = $(cntx).closest("tr").find("td[name = 'selectPrimaryRole']").find("select");
    //console.log(select);
    var primaryRole = select.val();
    //console.log(primaryRole);
    if (!primaryRole) {
        alert("Please Select a Primary Role!");
        select.focus();
        return;
    }

    var secondaryRole = $(cntx).closest("tr").find("td[name = 'selectSecondaryRole']").find("select").val();
    //console.log(secondaryRole);

    var email = $(cntx).closest("tr").find('td[name = "email"]').text();
    //console.log(email);
    if (email) {
        alert("Are you sure you want to ACCEPT this request?");
        acceptRequest(email, primaryRole, secondaryRole, cntx);
    }    
}