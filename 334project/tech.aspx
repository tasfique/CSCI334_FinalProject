<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tech.aspx.cs" Inherits="_334project.tech" %>

<!DOCTYPE html>
<html>
<head>
    <title>adTech - IT Technician</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Lato:300'>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#subBut1").click(function () {
                $("#Button1").click();
                return false;
            })

            $("#subBut2").click(function () {
                $("#Button2").click();
                return false;
            })

            $("#subBut3").click(function () {
                $("#Button3").click();
                return false;
            })

            if ($("#Label4").text().length > 1) {
                swal($("#Label4").text(), "", "info");
            }
        });
    </script>
        <style>
        button {
            color: white
        }
    </style>
</head>
<body style="background-size: 100%; background-repeat: no-repeat; background-size: cover;">
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="login.aspx">
                    <img src="https://i.imgur.com/b7xs0vJ.png" style="margin-top: -70px; margin-left: -10px; height: 160px; width: 160px;" /></a>
            </div>
            <div class="collapse navbar-collapse" id="myNavbar">
                <ul class="nav navbar-nav navbar-right">
                    <li><a><span>Hello <%=Session["userName"]%></span></a></li>
                    <li><a href="login.aspx"><span class="glyphicon glyphicon-log-out"></span>Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <br />
    <br />
    <form runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container" style="width: 70%;">
            <h2>IT TECHNICIAN DASHBOARD</h2>
            <br />
            <br />
            <ul class="nav nav-tabs">
                <li><a data-toggle="tab" href="#formPart">ASSIGNED REQUESTS</a></li>
                <li><a data-toggle="tab" href="#completedTask">COMPLETED REQUESTS</a></li>
                <li><a data-toggle="tab" href="#overtimeHours">OVERTIME HOURS</a></li>
                <li><a data-toggle="tab" href="#workingHour">WORKING HOURS</a></li>
            </ul>

            <div class="tab-content">


                <div id="formPart" class="tab-pane fade in active" style="width: 100%; margin: 0px auto 0px auto;">
                    <br />
                    <h3>ASSIGNED REQUESTS</h3>
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                            <asp:TextBox ID="TextBox1" runat="server" class="form-control" AutoPostBack="True" OnTextChanged="TextBox1_TextChanged">Search By RequestID..</asp:TextBox>
                            <br />
                            <asp:GridView ID="GridView1" runat="server" class="table table-hover" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="requestID" HeaderText="Request ID" ReadOnly="True" />
                                    <asp:BoundField DataField="fullName" HeaderText="Client FullName" ReadOnly="True" />
                                    <asp:BoundField DataField="email" HeaderText="Client Email" ReadOnly="True" />
                                    <asp:BoundField DataField="issueName" HeaderText="Issue Name" ReadOnly="True" />
                                    <asp:BoundField DataField="description" HeaderText="Issue Description" ReadOnly="True" />
                                    <asp:BoundField DataField="assignedDate" HeaderText="Assigned Date" ReadOnly="True" />
                                    <asp:BoundField DataField="status" HeaderText="Status" ReadOnly="True" />
                                </Columns>
                            </asp:GridView>
                            <br />
                            <br />
                            <h4>Update Status for Request To Mark The Request AS Completed</h4>
                            <br />
                            <asp:Label ID="Label2" runat="server" Text="Enter Request ID:" Style="display: inline; font-size: 17px;"></asp:Label>
                            <asp:TextBox ID="TextBox2" runat="server" class="form-control" Style="width: 20%; display: inline; margin-left: 3%" TextMode="Number"></asp:TextBox>
                            <button id="subBut1" style="display: inline; margin-left: 5.5%;">UPDATE</button>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required RequestID" ControlToValidate="TextBox2" ValidationGroup="group1" Display="None"></asp:RequiredFieldValidator>

                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="group1" ForeColor="Red" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <br />
                    <br />
                    <asp:Button ID="Button1" runat="server" Text="Button" Style="display: none;" ValidationGroup="group1" OnClick="Button1_Click" />
                    <br />
                    <br />

                    <asp:Label ID="Label4" runat="server" Text="" Style="display: none;"></asp:Label>
                </div>


                <div id="completedTask" class="tab-pane fade">
                    <br />
                    <h3>LIST OF COMPLETED REQUESTS</h3>
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="Label5" runat="server" Text=""></asp:Label>
                            <asp:TextBox ID="TextBox3" runat="server" class="form-control" AutoPostBack="True" OnTextChanged="TextBox3_TextChanged"></asp:TextBox>
                            <br />
                            <asp:GridView ID="GridView2" runat="server" class="table table-hover" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="requestID" HeaderText="Request ID" ReadOnly="True" />
                                    <asp:BoundField DataField="fullName" HeaderText="Client FullName" ReadOnly="True" />
                                    <asp:BoundField DataField="email" HeaderText="Client Email" ReadOnly="True" />
                                    <asp:BoundField DataField="issueName" HeaderText="Issue Name" ReadOnly="True" />
                                    <asp:BoundField DataField="description" HeaderText="Issue Description" ReadOnly="True" />
                                    <asp:BoundField DataField="assignedDate" HeaderText="Assigned Date" ReadOnly="True" />
                                    <asp:BoundField DataField="completedDate" HeaderText="Completed Date" ReadOnly="True" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div id="overtimeHours" class="tab-pane fade">
                    <br />
                    <h3 style="margin-left: 18%">SPECIFY OVERTIME HOURS</h3>
                    <br />
                    <label style="font-size: 18px; margin-left: 18%">RequestID:</label>
                    <asp:DropDownList ID="DropDownList2" runat="server" class="select-css" Style="width: 45%; display: inline; margin-left: 90px;"></asp:DropDownList>
                    <br />
                    <br />
                    <label style="font-size: 18px; margin-left: 18%">Date:</label>
                    <asp:TextBox ID="TextBox4" runat="server" TextMode="Date" class="form-control" Style="width: 45%; display: inline; margin-left: 140px;"></asp:TextBox>
                    <br />
                    <br />
                    <label style="font-size: 18px; margin-left: 18%">Overworking hours:</label>
                    <asp:DropDownList ID="DropDownList3" runat="server" class="select-css" Style="width: 45%; display: inline; margin-left: 14px;">
                        <asp:ListItem Value="0">Select Hour...</asp:ListItem>
                        <asp:ListItem Value="1">1 hour</asp:ListItem>
                        <asp:ListItem Value="2">2 hours</asp:ListItem>
                        <asp:ListItem Value="3">3 hours</asp:ListItem>
                        <asp:ListItem Value="4">4 hours</asp:ListItem>
                        <asp:ListItem Value="5">5 hours</asp:ListItem>
                        <asp:ListItem Value="6">6 hours</asp:ListItem>
                        <asp:ListItem Value="7">7 hours</asp:ListItem>
                        <asp:ListItem Value="8">8 hours</asp:ListItem>
                        <asp:ListItem Value="9">9 hours</asp:ListItem>
                        <asp:ListItem Value="10">10 hours</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required RequestID" Display="None" ValidationGroup="Group2" ControlToValidate="DropDownList2"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Required Date" Display="None" ValidationGroup="Group2" ControlToValidate="TextBox4"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" InitialValue="0" runat="server" ErrorMessage="Required OverTime Hour" Display="None" ControlToValidate="DropDownList3" ValidationGroup="Group2"></asp:RequiredFieldValidator>
                    <br />
                    <br />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" Style="margin-left: 18%" ValidationGroup="Group2" ForeColor="Red" />
                    <br />
                    <br />
                    <br />
                    <button id="subBut2" style="margin-left: 44%;">UPDATE</button>
                    <asp:Button ID="Button2" runat="server" Text="Button" Style="display: none" ValidationGroup="Group2" OnClick="Button2_Click" />
                </div>

                <div id="workingHour" class="tab-pane fade">
                    <br />
                    <h3 style="margin-left: 18%">WORKING HOURS</h3>
                    <br />
                    <label style="font-size: 18px; margin-left: 18%">RequestID:</label>
                    <asp:DropDownList ID="DropDownList1" runat="server" class="select-css" Style="width: 45%; display: inline; margin-left: 90px;"></asp:DropDownList>
                    <br />
                    <br />
                    <label style="font-size: 18px; margin-left: 18%">Date:</label>
                    <asp:TextBox ID="TextBox5" runat="server" TextMode="Date" class="form-control" Style="width: 45%; display: inline; margin-left: 140px;"></asp:TextBox>
                    <br />
                    <br />
                    <label style="font-size: 18px; margin-left: 18%">Office Hour Spent:</label>
                    <asp:DropDownList ID="DropDownList4" runat="server" class="select-css" Style="width: 45%; display: inline; margin-left: 26px;">
                        <asp:ListItem Value="0">Select Hour...</asp:ListItem>
                        <asp:ListItem Value="1">1 hour</asp:ListItem>
                        <asp:ListItem Value="2">2 hours</asp:ListItem>
                        <asp:ListItem Value="3">3 hours</asp:ListItem>
                        <asp:ListItem Value="4">4 hours</asp:ListItem>
                        <asp:ListItem Value="5">5 hours</asp:ListItem>
                        <asp:ListItem Value="6">6 hours</asp:ListItem>
                        <asp:ListItem Value="7">7 hours</asp:ListItem>
                        <asp:ListItem Value="8">8 hours</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Required RequestID" Display="None" ValidationGroup="Group3" ControlToValidate="DropDownList1"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Required Date" Display="None" ValidationGroup="Group3" ControlToValidate="TextBox5"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" InitialValue="0" runat="server" ErrorMessage="Required Working Hour" Display="None" ControlToValidate="DropDownList4" ValidationGroup="Group3"></asp:RequiredFieldValidator>
                    <br />
                    <br />
                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" ValidationGroup="Group3" Style="margin-left: 18%" ForeColor="Red" />
                    <br />
                    <br />
                    <br />
                    <button id="subBut3" style="margin-left: 44%;">UPDATE</button>
                    <asp:Button ID="Button3" runat="server" Text="Button" Style="display: none" ValidationGroup="Group3" OnClick="Button3_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
