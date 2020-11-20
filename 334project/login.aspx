<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="_334project.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <title>adTech - Login</title>
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
    <div style="margin: 75px auto 0px auto; width: 420px; height: 540px; background-color: white; border-radius: 20px;">
        <form method="post" runat="server">
            <div class="form-group" style="margin: 0px auto 0px auto; width: 300px; height: 300px; background-color: white;">
                <br />
                <br />
                <h2 style="text-align: center;">
                    <img src="https://i.imgur.com/UV8AvHP.png" style="height: 70px; width: 70px; margin-top: -50px;"></h2>
                <br />
                <label for="username" style="font-size: 18px;">User Name:</label>
                <br />
                <asp:TextBox ID="TextBox1" runat="server" class="form-control"></asp:TextBox>
                <br />
                <label for="username" style="font-size: 18px;">Password:</label>
                <asp:TextBox ID="TextBox2" runat="server" class="form-control" TextMode="Password">
                </asp:TextBox>
                <asp:RegularExpressionValidator Display="Dynamic" ID="RegularExpressionValidator1" ErrorMessage="Password must be 8-20 characters long with at least one numeric, one alphabet and one special character." ForeColor="Red" runat="server" ValidationExpression="(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*()_+}{&quot;:;'?/>.<,])(?!.*\s).*$" ControlToValidate="TextBox2">
                </asp:RegularExpressionValidator>
                <br />
                <label for="username" style="font-size: 18px;">User Type:</label>
                <br />
                <asp:DropDownList ID="DropDownList1" runat="server" class="select-css">
                    <asp:ListItem>CEO</asp:ListItem>
                    <asp:ListItem>Project Manager</asp:ListItem>
                    <asp:ListItem>Client</asp:ListItem>
                    <asp:ListItem>IT Technician</asp:ListItem>
                </asp:DropDownList>
                <br />
                <asp:Label ID="Label1" runat="server" Text="" Style="display: none;"></asp:Label>
                <br />
                <br />
                <div style="text-align: center;">
                    <asp:Button ID="Button1" runat="server" Text="LOGIN" class="btn btn-primary" Style="width: 120px; height: 40px; font-size: 17px;" OnClick="Button1_Click" />
                    &nbsp; &nbsp;
                    <asp:Button ID="Button2" runat="server" Text="SIGN UP" class="btn btn-success" Style="width: 120px; height: 40px; font-size: 17px;" OnClick="Button2_Click" />
                </div>
                <br />
                <a href="resetPassword.aspx">
                    <p style="text-align: center;">Forgot Your Password?</p>
                </a>
            </div>
        </form>
    </div>
</body>
</html>
