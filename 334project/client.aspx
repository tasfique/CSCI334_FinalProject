<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="client.aspx.cs" Inherits="_334project.client" %>

<!DOCTYPE html>
<html>
<head>
    <title>adTech - Client</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Lato:300'>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script>
        $(document).ready(function () {
            // Prototype Pattern
            var requestPrototype = {
                createRequest: function () {
                    swal("Request Created", "Hello our client, you created a request " + this.request + ", with description " + this.desc, "info");
                },
                giveFeedBack: function () {
                    swal("", "Thank you for using your service!", "info");
                }
            };

            function Request(request, desc) {
                request = request || "Hardware Issue";
                desc = desc || "Blank Monitor";

                function constructorFunction(request, desc) {
                    this.request = request;
                    this.desc = desc;
                };

                constructorFunction.prototype = requestPrototype;

                var instance = new constructorFunction(request, desc);
                return instance;
            }

            $("#subBut1").click(function () {
                var request = Request($("#<%=TextBox1.ClientID%>").val(), $("#<%=TextArea1.ClientID%>").val());
                request.createRequest();

                // code onclick event to run the code behind to insert data
                setTimeout(function () { $("#Button1").click(); }, 2000);
                return false;
            })

            $("#subBut2").click(function () {
                $("#Button2").click();
                return false;
            })

            if ($("#Label1").text().length > 1) {
                swal($("#Label1").text(), "", "info");
            }
        })
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
            <h2>CLIENT DASHBOARD</h2>
            <br />
            <br />
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#formPart" id="requestForm">REQUEST FORM</a></li>
                <li><a data-toggle="tab" href="#historyPart" id="requestHistory">REQUEST HISTORY</a></li>
                <li><a data-toggle="tab" href="#feedbackPart" id="feedBackT">FEEDBACK</a></li>
            </ul>

            <div class="tab-content">
                <div id="formPart" class="tab-pane fade in active" style="width: 80%; margin: 0px auto 0px auto;">
                    <br />
                    <h3>REQUEST FORM</h3>
                    <br />
                    <label for="Issue" style="font-size: 18px;">Issue:</label>
                    <asp:TextBox ID="TextBox1" runat="server" class="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Issue" ControlToValidate="TextBox1" Display="None" ValidationGroup="Group1"></asp:RequiredFieldValidator>
                    <br />
                    <label for="description" style="font-size: 18px;">Description:</label>
                    <textarea id="TextArea1" rows="10" class="form-control" runat="server"></textarea>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Description" ControlToValidate="TextArea1" Display="None" ValidationGroup="Group1"></asp:RequiredFieldValidator>
                    <br />

                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ValidationGroup="Group1" />
                    <br />
                    <div style="text-align: center;">
                        <button id="subBut1">SUBMIT</button>
                    </div>
                    <asp:Label ID="Label1" runat="server" Text="" Style="display: none;"></asp:Label>
                    <asp:Button ID="Button1" ClientIDMode="Static" runat="server" Style="display: none" OnClick="Button1_Click" ValidationGroup="Group1" />
                </div>
                <div id="historyPart" class="tab-pane fade">
                    <br />
                    <h3>HISTORY</h3>
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                            <asp:TextBox ID="TextBox2" runat="server" class="form-control" OnTextChanged="TextBox2_TextChanged" AutoPostBack="True">Search By RequestID..</asp:TextBox>
                            <br />
                            <asp:GridView ID="GridView1" runat="server" class="table table-bordered" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="requestID" HeaderText="Request ID" ReadOnly="True" />
                                    <asp:BoundField DataField="fullName" HeaderText="ITTech FullName" ReadOnly="True" />
                                    <asp:BoundField DataField="email" HeaderText="ITTech Email" ReadOnly="True" />
                                    <asp:BoundField DataField="issueName" HeaderText="Issue Name" ReadOnly="True" />
                                    <asp:BoundField DataField="description" HeaderText="Issue Description" ReadOnly="True" />
                                    <asp:BoundField DataField="requestDate" HeaderText="Generated Date" ReadOnly="True" />
                                    <asp:BoundField DataField="status" HeaderText="Status" ReadOnly="True" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="feedbackPart" class="tab-pane fade" style="width: 80%; margin: 0px auto 0px auto;">
                    <br />
                    <h3>FEEDBACK</h3>
                    <br />

                    <label for="feedback" style="font-size: 18px;">Choose Request ID:</label>
                    <asp:DropDownList ID="DropDownList1" runat="server" class="select-css" Style="width: 30%"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Must Choose a RequestID" ControlToValidate="DropDownList1" Display="None" ValidationGroup="Group2"></asp:RequiredFieldValidator>
                    <br />
                    <label for="feedback" style="font-size: 18px;">Give your Rating:</label>

                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <ajaxToolkit:Rating ID="Rating1"
                                BehaviorID="RatingBehavior1"
                                runat="server"
                                CurrentRating="1"
                                StarCssClass="ratingStar"
                                WaitingStarCssClass="savedRatingStar"
                                FilledStarCssClass="filledRatingStar"
                                EmptyStarCssClass="emptyRatingStar" AutoPostBack="True">
                            </ajaxToolkit:Rating>

                            <br />
                            <br />
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <br />
                    <br />
                    <br />
                    <br />
                    <label for="feedback" style="font-size: 18px;">Enter your feedback:</label>
                    <textarea id="TextArea2" rows="10" class="form-control" runat="server"></textarea>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Required FeedBack Description" ControlToValidate="TextArea2" Display="None" ValidationGroup="Group2"></asp:RequiredFieldValidator>
                    <br />

                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ForeColor="Red" ValidationGroup="Group2" />
                    <div style="text-align: center;">
                        <button id="subBut2">SUBMIT</button>
                    </div>
                    <br />
                    <asp:Button ID="Button2" runat="server" Text="Button" OnClick="Button2_Click" Style="display: none;" ValidationGroup="Group2" />
                </div>
            </div>
        </div>
    </form>

</body>
</html>
