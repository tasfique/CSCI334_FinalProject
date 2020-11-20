<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="resetPassword.aspx.cs" Inherits="_334project.resetPassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <title>adTech - Reset Password</title>
    <style>
        body {
            background-image: url("https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80");
            background-size: 100%;
        }
    </style>
    <script>
        $(document).ready(function () {
            if ($("#Label1").text().length > 2) {
                swal($("#Label1").text(), "", "info");
            }
        })
    </script>
</head>
<body>

    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="login.aspx">
                    <img src="https://i.imgur.com/b7xs0vJ.png" style="margin-top: -70px; margin-left: -10px; height: 160px; width: 160px;" /></a>
            </div>
            <div class="collapse navbar-collapse" id="myNavbar">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="about.aspx"><span class="glyphicon glyphicon-education"></span>About</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div style="margin: 75px auto 0px auto; width: 420px; height: 680px; background-color: white; border-radius: 20px;">
        <form method="post" runat="server">
            <div class="form-group" style="margin: 0px auto 0px auto; width: 300px; height: 300px; background-color: white;">
                <br />
                <br />
                <h2 style="text-align: center;">
                    <img src="https://i.imgur.com/UV8AvHP.png" style="height: 70px; width: 70px; margin-top: -50px;"></h2>
                <br />
                <p style="text-align: center; font-size: 15px;">Enter correct information and new password to reset the password.</p>
                <label for="username" style="font-size: 18px;">User Name:</label>
                <asp:TextBox ID="TextBox1" runat="server" class="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required" ControlToValidate="TextBox1" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                <br />
                <label for="username" style="font-size: 18px;">Reset Key:</label>
                <asp:TextBox ID="TextBox2" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ControlToValidate="TextBox2"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator Display="Dynamic" ID="RegularExpressionValidator4" runat="server" ErrorMessage="Reset Key must contain 5 characters" ForeColor="Red" ValidationExpression="(^.{5})" ControlToValidate="TextBox2"></asp:RegularExpressionValidator>
                <br />
                <label for="username" style="font-size: 18px;">New Password:</label>
                <asp:TextBox ID="TextBox3" runat="server" TextMode="Password" class="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Required" ControlToValidate="TextBox3" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator Display="Dynamic" ID="RegularExpressionValidator1" ErrorMessage="Password must be 8-20 characters long with at least one numeric, one alphabet and one special character." ForeColor="Red" runat="server" ValidationExpression="(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*()_+}{&quot;:;'?/>.<,])(?!.*\s).*$" ControlToValidate="TextBox3">
                </asp:RegularExpressionValidator>
                <br />
                <label for="username" style="font-size: 18px;">New Password Confirm:</label>
                <asp:TextBox ID="TextBox4" runat="server" TextMode="Password" class="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ControlToValidate="TextBox4"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator Display="Dynamic" ID="RegularExpressionValidator2" ErrorMessage="Password must be 8-20 characters long with at least one numeric, one alphabet and one special character." ForeColor="Red" runat="server" ValidationExpression="(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*()_+}{&quot;:;'?/>.<,])(?!.*\s).*$" ControlToValidate="TextBox4"></asp:RegularExpressionValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Password must be the same. Please re-enter." ControlToCompare="TextBox3" ForeColor="Red" ControlToValidate="TextBox4" SetFocusOnError="True"></asp:CompareValidator>
                <br />
                <br />
                <div style="text-align: center;">
                    <asp:Button ID="Button3" runat="server" Text="CHANGE" class="btn btn-primary" Style="width: 120px; height: 40px; font-size: 17px;" OnClick="Button3_Click" />
                </div>
                <br />
                <asp:Label ID="Label1" runat="server" Text="" Style="display: none;"></asp:Label>
            </div>
        </form>
    </div>
</body>
</html>
