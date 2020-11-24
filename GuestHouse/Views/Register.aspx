<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="GuestHouse.Views.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" >
     <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title> Registration </title>
    <link href="../css/styles.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script>-->
    <script src="../js/sha1.js" type="text/javascript"></script>
    <script type="text/javascript"> 
        /*
        $(document).ready(function () {
            $('#registrationForm').validate({
                rules: {
                    inputPassword: {
                        required: true,
                        minlength: 8
                    },
                    inputConfirmPassword: {
                        required: true,
                        minlength: 8,
                        equalTo: "#password"
                    },
                    messages: {
                        password: " Enter Password",
                        confirmpassword: " Enter Confirm Password Same as Password"
                    }
                }
            });
        });
        */

        $(document).ready(function () {
            $('#registrationForm').submit(function (e) {
                console.log("reaches here");
                e.preventDefault();
                var guest = {};
                guest.FirstName = $('#inputFirstName').val();
                guest.LastName = $('#inputLastName').val();
                guest.Email = $('#inputEmailAddress').val();
                guest.MobileNo = $('#inputMobileNumber').val();
                guest.ID = $('#inputPersonID').val();
                guest.Password = $('#inputPassword').val();
                $.ajax({
                    url: 'Register.aspx/SaveUserDetails',
                    type: "POST",
                    
                    contentType: 'application/json;charset=utf-8',
                    data: JSON.stringify({userData:JSON.parse(JSON.stringify(guest))}),
                    success: function (result) {
                        alert('success');
                    },
                    error: function (result) {
                        alert(result.responseText);
                    }

                });
            });
        });

    </script>
        
    <!--function saveEHdata(fEHPath, jsonObj) {
        // alert('Call from save ext details : ' + fEHPath);
        var ddt = JSON.stringify(jsonObj);
        $.ajax({
            type: "POST",
            //url: "../ProjectStaff/PGeneral/services.aspx/SaveExetnDetails",
            url: "services.aspx/SaveExetnDetails",
            //url: "../PEmp_PSService/SaveExetnDetails",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            //data: JSON.stringify({ ExtType: $("#ddlExtType").val(), EHDOE: $('#txtEHDoE').val(), EHDoEB: $('#txtEHDoEB').val(), EHDOEEnd: $("#txtEHDoEEnd").val(), EHNewDesg: $("#txtEHDesg").val(), EHPrevDesg: $('#txtEHPrvDesg').val(), EHNewSal: $('#txtEHNewsal').val(), EHPrevSal: $("#txtEHPrevSal").val(), EHRemarks: $("#txtEHRemarks").val(), EHOOrder: fEHPath }), //
            data: JSON.stringify({ ServHistory: JSON.parse(ddt) }),
            processData: false,
            success: function (result) {
                alert("Data saved successfully...", "");
                resetEH();
                displayEHdata();
                //checkForallTabsStatus();
            },
            error: function (result) {
                alert(JSON.parse(result.responseText).Message, "alert alert-danger", "");
            }
        });
    } -->


</head>
<body class="bg-primary">
    
      <div id="layoutAuthentication">
        <div id="layoutAuthentication_content">
            <main>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-7">
                            <div class="card shadow-lg border-0 rounded-lg mt-5">
                                <div class="card-header"><h3 class="text-center font-weight-light my-4">Create Account</h3></div>
                                <div class="card-body">
                                    <form id="registrationForm" action="#" method="post">
                                        <div class="form-row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="small mb-1 required" for="inputFirstName">First Name</label>
                                                    <input class="form-control py-4" id="inputFirstName" type="text" autocapitalize="word" placeholder="Enter first name" required="required" />
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="small mb-1" for="inputLastName">Last Name</label>
                                                    <input class="form-control py-4" id="inputLastName" type="text" placeholder="Enter last name" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="small mb-1 required" for="inputMobileNumber">Mobile No.</label>
                                                    <input class="form-control py-4" id="inputMobileNumber" type="tel" placeholder="Enter mobile number" required="required" />
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="small mb-1 required" for="inputPersonID">ID</label>
                                                    <input class="form-control py-4" id="inputPersonID" type="text" placeholder="Enter ID" required="required" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="small mb-1 required" for="inputEmailAddress">Email</label>
                                            <input class="form-control py-4" id="inputEmailAddress" type="email" aria-describedby="emailHelp" placeholder="Enter email address" required="required" />
                                        </div>
                                        <div class="form-row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="small mb-1 required" for="inputPassword">Password</label>
                                                    <input class="form-control py-4" id="inputPassword" type="password" placeholder="Enter password" required="required" />
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="small mb-1 required" for="inputConfirmPassword">Confirm Password</label>
                                                    <input class="form-control py-4" id="inputConfirmPassword" type="password" placeholder="Confirm password" required="required" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group mt-4 mb-0"><button type="submit" class="btn btn-primary btn-block" id="registrationButton">Create Account</button></div>
                                    </form>
                                </div>
                                <div class="card-footer text-center">
                                    <div class="small"><a href="login.aspx">Have an account? Go to login</a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <div id="layoutAuthentication_footer">
            <footer class="py-4 bg-light mt-auto">
                <div class="container-fluid">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted">NIRDPR &copy; 2020</div>
                        <div>
                            <a href="#">Privacy Policy</a>
                            &middot;
                            <a href="#">Terms &amp; Conditions</a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js" ></script>
  <!-- <script src="js/scripts.js"></script>-->
</body>
</html>
