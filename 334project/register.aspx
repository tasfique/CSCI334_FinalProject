<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="_334project.register" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <title>adTech - Sign Up</title>
    <style>
        body {
            background-image: url("https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80");
            background-size: 100%;
        }
    </style>
    <script>
        $(document).ready(function () {
            // Singleton Pattern
            class createAccountMessage {
                constructor(data) {
                    if (createAccountMessage.exists) {
                        return createAccountMessage.instance;
                    }
                    this._data = data;
                    createAccountMessage.instance = this;
                    createAccountMessage.exists = true;
                    return this;
                }

                getData() {
                    return this._data;
                }

                setData(data) {
                    this._data = data;
                }
            }

            const createMessage = new createAccountMessage("Hello new user, please fill in all information to create new account.");
            const testSingleton = new createAccountMessage("Hello Client");
            // Test the singleton design pattern, swal is same as the alert but with better look
            swal(testSingleton.getData(), "Welcome to our service", "info");



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
    <div style="margin: 30px auto 0px auto; width: 440px; height: 830px; background-color: white; border-radius: 20px;">
        <form method="post" autocomplete="off" runat="server">
            <div class="form-group" style="margin: 0px auto 0px auto; width: 300px; height: 400px; background-color: white;">
                <br />
                <h2 style="text-align: center;">REGISTER</h2>

                <label for="username" style="font-size: 18px;">Enter New Username:</label>
                <asp:TextBox ID="TextBox1" runat="server" class="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
                <br />
                <label for="username" style="font-size: 18px;">Enter full name:</label>
                <asp:TextBox ID="TextBox5" runat="server" class="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ControlToValidate="TextBox5"></asp:RequiredFieldValidator>
                <br />
                <label for="username" style="font-size: 18px;">Enter Reset Key:</label>
                <asp:TextBox ID="TextBox6" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ControlToValidate="TextBox6"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator Display="Dynamic" ID="RegularExpressionValidator4" runat="server" ErrorMessage="Reset Key must contain 5 characters" ForeColor="Red" ValidationExpression="(^.{5})" ControlToValidate="TextBox6"></asp:RegularExpressionValidator>
                <br />
                <label for="username" style="font-size: 18px;">Enter New Password:</label>
                <asp:TextBox ID="TextBox2" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ControlToValidate="TextBox2"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator Display="Dynamic" ID="RegularExpressionValidator1" ErrorMessage="Password must be 8-20 characters long with at least one numeric, one alphabet and one special character." ForeColor="Red" runat="server" ValidationExpression="(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*()_+}{&quot;:;'?/>.<,])(?!.*\s).*$" ControlToValidate="TextBox2">
                </asp:RegularExpressionValidator>
                <br />
                <label for="username" style="font-size: 18px;">Repeat New Password:</label>
                <asp:TextBox ID="TextBox3" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ControlToValidate="TextBox3"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator Display="Dynamic" ID="RegularExpressionValidator2" ErrorMessage="Password must be 8-20 characters long with at least one numeric, one alphabet and one special character." ForeColor="Red" runat="server" ValidationExpression="(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*()_+}{&quot;:;'?/>.<,])(?!.*\s).*$" ControlToValidate="TextBox3">
                </asp:RegularExpressionValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Password must be the same. Please re-enter." ControlToCompare="TextBox2" ForeColor="Red" ControlToValidate="TextBox3" SetFocusOnError="True"></asp:CompareValidator>
                <br />
                <label for="username" style="font-size: 18px;">Enter Email:</label>
                <asp:TextBox ID="TextBox4" runat="server" class="form-control" TextMode="Email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ControlToValidate="TextBox4"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Invalid email address" ControlToValidate="TextBox4" ForeColor="Red" Display="Dynamic" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"></asp:RegularExpressionValidator>
                <br />
                <label for="username" style="font-size: 18px;">User Type:</label><br />
                <asp:DropDownList ID="DropDownList1" runat="server" class="select-css">
                    <asp:ListItem>Client</asp:ListItem>
<%--                    <asp:ListItem>Project Manager</asp:ListItem>--%>
                    <asp:ListItem>IT Technician</asp:ListItem>
                </asp:DropDownList><br />
                <div style="text-align: center;">
                    <asp:Button ID="Button1" runat="server" Text="REGISTER" class="btn btn-success" Style="width: 120px; height: 40px; font-size: 17px;" OnClick="Button1_Click" />
                </div>
                <br />
                <asp:Label ID="Label1" runat="server" Text="" Style="display: none;"></asp:Label>
            </div>
        </form>
    </div>
</body>
</html>
