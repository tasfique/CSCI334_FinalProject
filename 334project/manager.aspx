<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manager.aspx.cs" Inherits="_334project.manager" %>

<!DOCTYPE html>
<html>
<head>
    <title>adTech - Project Manager</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Lato:300'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
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

            $("#subBut4").click(function () {
                $("#Button4").click();
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
            <h2>PROJECT MANAGER DASHBOARD</h2>
            <br />
            <br />
            <ul class="nav nav-pills">
                <li class="active"><a data-toggle="tab" href="#formPart" id="assignRequest">ASSIGN REQUESTS</a></li>
                <li><a data-toggle="tab" href="#historyPart">VIEW IT TECHNICIAN</a></li>
                <li><a data-toggle="tab" id="testss" href="#overtimeR" id="overtimeRate">OVERTIME RATE</a></li>
                <li><a data-toggle="tab" href="#uncompletedTask" id="uncompleted">REQUEST EXCEED A WEEK</a></li>
                <li><a data-toggle="tab" href="#timeSpent" id="totalTime">TIME SPENT</a></li>
            </ul>

            <div class="tab-content">
                <div id="formPart" class="tab-pane fade in active" style="width: 100%; margin: 0px auto 0px auto;">
                    <br />
                    <h3>REQUESTS FROM CLIENTS</h3>
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
                                    <asp:BoundField DataField="requestDate" HeaderText="Generated Date" ReadOnly="True" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <br />
                    <h4>Assign Request To IT Technician</h4>
                    <br />
                    <asp:Label ID="Label2" runat="server" Text="Enter Request ID:" Style="display: inline; font-size: 17px;"></asp:Label>
                    <asp:Label ID="Label3" runat="server" Text="Choose IT Technician:" Style="display: inline; margin-left: 17.8%; font-size: 17px;"></asp:Label><br />
                    <asp:TextBox ID="TextBox2" runat="server" class="form-control" Style="width: 20%; display: inline" TextMode="Number"></asp:TextBox>
                    <asp:DropDownList ID="DropDownList1" runat="server" class="select-css" Style="width: 25%; display: inline; margin-left: 10%;"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required RequestID" ControlToValidate="TextBox2" Display="None" ValidationGroup="group1"></asp:RequiredFieldValidator>

                    <br />
                    <br />
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ValidationGroup="group1" />
                    <br />
                    <button id="subBut1" style="margin-left: 20.5%">UPDATE</button>

                    <asp:Button ID="Button1" runat="server" Text="Button" Style="display: none;" ValidationGroup="group1" OnClick="Button1_Click" />
                    <br />
                    <br />
                    <br />

                    <asp:Label ID="Label4" runat="server" Text="" Style="display: none;"></asp:Label>

                </div>

                <div id="historyPart" class="tab-pane fade">
                    <br />
                    <h3>IT TECHNICIAN CURRENT WORKLOAD</h3>
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="Label5" runat="server" Text=""></asp:Label>
                            <asp:TextBox ID="TextBox3" runat="server" class="form-control" AutoPostBack="True" OnTextChanged="TextBox3_TextChanged">Search By IT Technician ID..</asp:TextBox>
                            <br />
                            <asp:GridView ID="GridView2" runat="server" class="table table-hover" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="accountID" HeaderText="ITTech ID" ReadOnly="True" />
                                    <asp:BoundField DataField="fullName" HeaderText="ITTech FullName" ReadOnly="True" />
                                    <asp:BoundField DataField="email" HeaderText="ITTech Email" ReadOnly="True" />

                                    <asp:BoundField DataField="requestID" HeaderText="Working On Request" ReadOnly="True" />

                                    <asp:BoundField DataField="issueName" HeaderText="Issue Name" ReadOnly="True" />
                                    <asp:BoundField DataField="description" HeaderText="Issue Description" ReadOnly="True" />
                                    <asp:BoundField DataField="assignedDate" HeaderText="Assigned Date" ReadOnly="True" />
                                    <asp:BoundField DataField="ITTechStatus" HeaderText="ITTech Status" ReadOnly="True" />


                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>


                <div id="overtimeR" class="tab-pane fade">
                    <br />
                    <h3>OVERTIME HOUR</h3>
                    <br />
                    <label style="font-size: 18px;">Enter New Rate:</label><br />
                    <asp:TextBox ID="TextBox4" runat="server" class="form-control" Style="width: 40%; display: inline;" TextMode="Number"></asp:TextBox>
                    <button id="subBut2" style="margin-left: 10%; display: inline;">UPDATE</button>
                    <button id="subBut4" style="margin-left: 5%; display: inline;">PREVIOUS VALUE</button>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Rate" ControlToValidate="TextBox4" ValidationGroup="group2" Display="None"></asp:RequiredFieldValidator>
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ForeColor="Red" ValidationGroup="group2" />
                    <asp:Button ID="Button2" runat="server" Text="Button" Style="display: none;" ValidationGroup="group2" OnClick="Button2_Click" />
                    <asp:Button ID="Button4" runat="server" Text="Button" style="display: none;" OnClick="Button4_Click" />
                    <br />
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>

                            <asp:GridView ID="GridView3" runat="server" class="table table-hover" AutoGenerateColumns="False">
                                <Columns>

                                    <asp:BoundField DataField="overTimeID" HeaderText="OverTime ID" ReadOnly="True" />
                                    <asp:BoundField DataField="fullName" HeaderText="ITTech FullName" ReadOnly="True" />
                                    <asp:BoundField DataField="email" HeaderText="ITTech Email" ReadOnly="True" />

                                    <asp:BoundField DataField="requestID" HeaderText="Working On Request" ReadOnly="True" />

                                    <asp:BoundField DataField="date" HeaderText="Hard Working Day" ReadOnly="True" />
                                    <asp:BoundField DataField="overHour" HeaderText="Overtime Hour" ReadOnly="True" />
                                    <asp:BoundField DataField="rate" HeaderText="Rate" ReadOnly="True" />
                                    <asp:BoundField DataField="earn" HeaderText="Total Earn" ReadOnly="True" />


                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <br />
                    <br />

                </div>

                <div id="uncompletedTask" class="tab-pane fade">
                    <br />
                    <h3>REQUEST CANNOT BE SOLVED IN A WEEK</h3>
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="Label6" runat="server" Text=""></asp:Label>
                            <asp:TextBox ID="TextBox5" runat="server" class="form-control" AutoPostBack="True" OnTextChanged="TextBox5_TextChanged">Search By RequestID..</asp:TextBox>
                            <br />
                            <asp:GridView ID="GridView4" runat="server" class="table table-hover" AutoGenerateColumns="False">
                                <Columns>

                                    <asp:BoundField DataField="requestID" HeaderText="Request ID" ReadOnly="True" />
                                    <asp:BoundField DataField="issueName" HeaderText="Issue Name" ReadOnly="True" />
                                    <asp:BoundField DataField="description" HeaderText="Issue Description" ReadOnly="True" />

                                    <asp:BoundField DataField="personInCharge" HeaderText="ITTech In Charge" ReadOnly="True" />
                                    <asp:BoundField DataField="requestDate" HeaderText="Request Date" ReadOnly="True" />

                                    <asp:BoundField DataField="assignedDate" HeaderText="Assigned Date" ReadOnly="True" />
                                    <asp:BoundField DataField="todayDate" HeaderText="Today" ReadOnly="True" />

                                    <asp:BoundField DataField="dateSpent" HeaderText="Total days since request was assigned" ReadOnly="True" />


                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <br />
                    <h4>Reallocate Request To another IT Technician</h4>
                    <br />
                    <asp:Label ID="Label7" runat="server" Text="Enter Request ID:" Style="display: inline; font-size: 17px;"></asp:Label>
                    <asp:Label ID="Label8" runat="server" Text="Choose IT Technician:" Style="display: inline; margin-left: 17.8%; font-size: 17px;"></asp:Label><br />
                    <asp:TextBox ID="TextBox6" runat="server" class="form-control" Style="width: 20%; display: inline" TextMode="Number"></asp:TextBox>
                    <asp:DropDownList ID="DropDownList2" runat="server" class="select-css" Style="width: 25%; display: inline; margin-left: 10%;"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Required RequestID" ControlToValidate="TextBox6" Display="None" ValidationGroup="group3"></asp:RequiredFieldValidator>
                    <br />
                    <br />
                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" ForeColor="Red" ValidationGroup="group3" />
                    <br />
                    <button id="subBut3" style="margin-left: 20.5%">UPDATE</button>

                    <asp:Button ID="Button3" runat="server" Text="Button" Style="display: none;" ValidationGroup="group3" OnClick="Button3_Click" />
                    <br />
                    <br />
                    <br />
                </div>

                <div id="timeSpent" class="tab-pane fade">
                    <br />
                    <h3>WORKING TIME</h3>
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="Label9" runat="server" Text=""></asp:Label>
                            <asp:TextBox ID="TextBox7" runat="server" class="form-control" AutoPostBack="True" OnTextChanged="TextBox7_TextChanged">Search By IT Technician ID..</asp:TextBox>
                            <br />
                            <h4>IT TECHNICIAN TOTAL OFFICE HOUR</h4>
                            <br />
                            <asp:GridView ID="GridView5" runat="server" class="table table-hover" AutoGenerateColumns="False">
                                <Columns>

                                    <asp:BoundField DataField="accountID" HeaderText="ITTech ID" ReadOnly="True" />

                                    <asp:BoundField DataField="fullName" HeaderText="ITTech FullName" ReadOnly="True" />
                                    <asp:BoundField DataField="email" HeaderText="ITTech Email" ReadOnly="True" />

                                    <asp:BoundField DataField="totalHour" HeaderText="Total Office Hour Spent" ReadOnly="True" />



                                    <asp:BoundField DataField="requestID" HeaderText="Working On Request" ReadOnly="True" />
                                </Columns>
                            </asp:GridView>
                            <br />
                            <h4>IT TECHNICIAN TOTAL OVERTIME</h4>
                            <br />
                            <asp:GridView ID="GridView6" runat="server" class="table table-hover" AutoGenerateColumns="False">
                                <Columns>


                                    <asp:BoundField DataField="accountID" HeaderText="ITTech ID" ReadOnly="True" />
                                    <asp:BoundField DataField="fullName" HeaderText="ITTech FullName" ReadOnly="True" />
                                    <asp:BoundField DataField="email" HeaderText="ITTech Email" ReadOnly="True" />

                                    <asp:BoundField DataField="rate" HeaderText="Rate" ReadOnly="True" />

                                    <asp:BoundField DataField="totalOverHour" HeaderText="Total OverTime Hour" ReadOnly="True" />
                                    <asp:BoundField DataField="requestID" HeaderText="Working On Request" ReadOnly="True" />

                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>
    </form>
</body>
</html>
