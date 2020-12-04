$(document).ready(function () {
    $("#collapseManagement").collapse('show');
    $('.roles-table-lib').select2();

    //driver code
    ajaxCurrentManagement().then((data) => updateTable(data.d));

    // ajax function to retrieve data from server
    async function ajaxCurrentManagement() {
        const result = await $.ajax({
            type: "POST",
            url: "CurrentManagement.aspx/GetManagemetnDetails",
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
        temp += '<td name="selectPrimaryRole" class="required" hidden>';
        temp += '<select class="btn btn-light btn-sm roles">';
        temp += '<option value=""><--Select--></option>';
        temp += '<option value="">Admin</option>';
        temp += '<option value="">Reception</option>';
        temp += '</select>';
        temp += '</td>';
        var temp2 = '';
        temp2 += '<td name="selectSecondaryRole" hidden>';
        temp2 += '<select class="btn btn-light btn-sm roles">';
        temp2 += '<option value=""><--Select--></option>';
        temp2 += '<option value="">Admin</option>';
        temp2 += '<option value="">Reception</option>';
        temp2 += '</select>';
        temp2 += '</td>';
        temp2 += '<td name="defaultAction">';
        temp2 += '<i class="fa fa-edit alert-success" onclick="editRowfxn(this)"></i>';
        temp2 += '&nbsp &nbsp';
        temp2 += '<i class="fa fa-trash alert-danger" onclick = "deleteRowfxn(this)"></i>';
        temp2 += '</td>';
        temp2 += '<td name="editAction" hidden>';
        temp2 += '<i class="fa fa-check alert-success" onclick="acceptfxn(this)"></i>';
        temp2 += '&nbsp &nbsp';
        temp2 += '<i class="fa fa-close alert-danger" onclick = "canclefxn(this)"></i>';
        temp2 += '</td>';

        $.each(data.Table, function (key, value) {
            requests += '<tr>';
            requests += '<td>';
            requests += value.FirstName;
            if (value.LastName) {
                //console.log("last name - " + value.LastName);
                requests += ' ' + value.LastName;
            }
            requests += '</td>';
            requests += '<td>' + value.MobileNo + '</td>';
            requests += '<td>' + value.ID + '</td>';
            requests += '<td name="email">' + value.Email + '</td>';
            requests += '<td name="displayPrimaryRole"><span class="displayPrimaryRole">' + value.PrimaryRole + '</span></td>';
            requests += temp;
            if (value.SecondaryRole) {
                requests += '<td name="displaySecondaryRole"><span class="displaySecondaryRole">' + value.SecondaryRole + '</span></td>';
            }
            else {
                requests += '<td name="displaySecondaryRole">-</td>';
            }
            requests += temp2;
            requests += '</tr>';
        });
        $('#managementTable').append(requests);
        $('#managementTable').DataTable();
        $('.dataTables_length').addClass('bs-select');

        $("tbody tr td[name='selectPrimaryRole']").each(function () {
            $(this).hide();
            $(this).removeAttr("hidden");
        });

        $("tbody tr td[name='selectSecondaryRole']").each(function () {
            $(this).hide();
            $(this).removeAttr("hidden");
        });

        $("tbody tr td[name='editAction']").each(function () {
            $(this).hide();
            $(this).removeAttr("hidden");
        });
    }

    ////driver code
    //ajaxRoles().then((data) => updateSelect(data.d));

    // ajax function to retrieve roles
    //async function ajaxRoles() {
    //    const result = await $.ajax({
    //        type: "POST",
    //        url: "CurrentManagement.aspx/GetRoles",
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
function deleteRequest(email, cntx) {
    //console.log("inside delete");
    //console.log(email);

    var postData = {
        email: email
    };

    const result = $.ajax({
        type: "POST",
        url: "CurrentManagement.aspx/DeleteRequest",
        data: JSON.stringify(postData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        traditional: true,
        success: function () {
            $(cntx).closest("tr").remove();
        },
        failure: function () {
            alert("Delete Request Failed");
        }
    });
    return result;
}

function deleteRowfxn(cntx) {
    //console.log("deleteRowfxn");
    var email = $(cntx).closest("tr").find('td[name = "email"]').text();
    //console.log(email);
    if (email) {
        alert("Are you sure you want to delete?");
        deleteRequest(email, cntx);
    }
}

// ajax function to accept request
function updateRequest(email, primaryRole, secondaryRole, cntx) {
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
        url: "CurrentManagement.aspx/UpdateRequest",
        data: JSON.stringify(postData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        traditional: true,
        success: function () {
            flag = false;
            toggleAction(cntx);
            var displayPrimary = $(cntx).closest("tr").find("td[name = 'displayPrimaryRole']").find("span.displayPrimaryRole");
            //console.log(displayPrimary);
            displayPrimary.html(primaryRole);
            var displaySecondary = $(cntx).closest("tr").find("td[name = 'displaySecondaryRole']").find("span.displaySecondaryRole");
            //console.log(displayPrimary);
            displaySecondary.html(secondaryRole);

        },
        failure: function () {
            alert("Edit Request Failed");
        }
    });
    return result;
}

var flag = false;

function acceptfxn(cntx) {
    console.log("acceptfxn");
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
        alert("Are you sure you want to EDIT roles?");
        updateRequest(email, primaryRole, secondaryRole, cntx);
        // toggleAction(cntx);
    }
}

function toggleAction(cntx) {
    var selectPrimary = $(cntx).closest("tr").find("td[name = 'selectPrimaryRole']");
    var displayPrimary = $(cntx).closest("tr").find("td[name = 'displayPrimaryRole']");
    displayPrimary.toggle();
    selectPrimary.toggle();

    var selectSecondary = $(cntx).closest("tr").find("td[name = 'selectSecondaryRole']");
    var displaySecondary = $(cntx).closest("tr").find("td[name = 'displaySecondaryRole']");
    displaySecondary.toggle();
    selectSecondary.toggle();

    var defaultAction = $(cntx).closest("tr").find("td[name = 'defaultAction']");
    defaultAction.toggle();
    var editAction = $(cntx).closest("tr").find("td[name = 'editAction']");
    editAction.toggle();
    
}

function editRowfxn(cntx) {

    if (flag) {
        alert("Please complete the current update first.");
        return
    }
    flag = true;
    console.log("editRowfxn");

    toggleAction(cntx);

    var selectPrimary = $(cntx).closest("tr").find("td[name = 'selectPrimaryRole']");
    var displayPrimary = $(cntx).closest("tr").find("td[name = 'displayPrimaryRole']");

    var primary = selectPrimary.find("select");
    var val = displayPrimary.text();
    console.log(val);
    primary.find("option[value ='" + val + "']").attr("selected", "true");
    console.log(primary.find("option[value ='" + val + "']").text());

    var selectSecondary = $(cntx).closest("tr").find("td[name = 'selectSecondaryRole']");
    var displaySecondary = $(cntx).closest("tr").find("td[name = 'displaySecondaryRole']");


    var secondary = selectSecondary.find("select");
    var val = displaySecondary.text();
    if (val != "-") {
        secondary.find("option[value ='" + val + "']").attr("selected", "true");
    }
}