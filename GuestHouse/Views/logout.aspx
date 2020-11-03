<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="logout.aspx.cs" Inherits="GuestHouse.Views.logout" %>

<!DOCTYPE html>

<html lang="en">
    <head runat="server">
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>GMS| Login</title>
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js" crossorigin="anonymous"></script>    </head>
    <body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-3">Thank You!</h3></div>
                                    <div class="card-body text-center">
                                        <p style="font-size:110%">
                                            <br />
                                            You have been successfully logged out!
                                            <br />
                                            <br />
                                            Click <a href="login.aspx"><u>here</u></a> to Login again.
                                            <br />
                                            <br />
                                        </p>
                                    </div>
                                    <div class="card-footer text-center">
                                        <div class="small"><a href="Register.aspx" style="font-size:110%">Need an account? Sign up!</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="../js/scripts.js"></script>        
    </body>
</html>
