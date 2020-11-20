<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ceo.aspx.cs" Inherits="_334project.ceo" %>

<!DOCTYPE html>
<html>
<head>
    <title>adTech - CEO</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Lato:300'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
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

            if ($("#Label1").text().length > 1) {
                swal($("#Label1").text(), "", "info");
            }
        });

        google.load("visualization", "1", { packages: ["corechart"] });
        google.setOnLoadCallback(function () {

            // using Iterator
            function Iterator(data) {
                this.data = data;
                this.index = 0;
            }

            Iterator.prototype = {
                hasNext: function () {
                    return this.index < this.data.length
                },
                next: function () {
                    return this.data[this.index++]
                },
                rewind: function () {
                    this.index = 0;
                    return data[this.index];
                },
            }

            const data = ['Take a first look at statistic', 'Find the data category you want', 'Force yourself to remain ' 
                + 'objective', "See the IT's major accomplishment", 'Ask yourself the problem - solving question', 'Find way to enhance the IT Tech work'];
            const iter = new Iterator(data);



            $("#subBut3").click(function () {
                if ($("#<%=TextBox3.ClientID%>").val() == "" && $("#<%=TextBox4.ClientID%>").val() == "") {
                    $('#<%=Label2.ClientID%>').html("Please enter From Date and To Date.");
                } else if ($("#<%=TextBox3.ClientID%>").val() == "" && $("#<%=TextBox4.ClientID%>").val() != "") {
                    $('#<%=Label2.ClientID%>').html("Please enter From Date.");
                } else if ($("#<%=TextBox3.ClientID%>").val() != "" && $("#<%=TextBox4.ClientID%>").val() == "") {
                    $('#<%=Label2.ClientID%>').html("Please enter To Date.");
                } else if (new Date($("#<%=TextBox3.ClientID%>").val()) > new Date($("#<%=TextBox4.ClientID%>").val())) {
                    $('#<%=Label2.ClientID%>').html("To Date can't be before From Date.");
                }
                else {
                    $('#<%=Label2.ClientID%>').html("");
                    var date1 = $("#<%=TextBox3.ClientID%>").val();
                    var date2 = $("#<%=TextBox4.ClientID%>").val();
                    var value1 = $('#<%=DropDownList1.ClientID %> option:selected').val();
                    var value2 = $('#<%=DropDownList2.ClientID %> option:selected').val();
                    PageMethods.CreateSessionViaJavascript(date1, date2, value1, value2);

                    // Iterator design pattern usage
                    if (iter.hasNext()) {
                        swal("Hi CEO", iter.next(), "info");
                    } else {
                        iter.rewind();
                    }

                    if (value1 == "rs") {
                        drawChart();
                    } else if (value1 == "wt") {
                        drawChart2();
                    } else if (value1 == "oh") {
                        drawChart3();
                    } else {
                        swal("Error!", "Oops! Some error occur.", "info");
                    }
                }
            });
        });

        function drawChart() {
            var options = {
                title: 'Request Status Which Assigned To IT Technician',
                width: 900,
                height: 900,
                backgroundColor: "transparent",
                is3D: true
            };

            $.ajax({
                type: "POST",
                url: "ceo.aspx/GetChartData",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    debugger;
                    var data = google.visualization.arrayToDataTable(r.d);
                    var chart = new google.visualization.PieChart($("#chart")[0]); //***PieChart***
                    chart.draw(data, options);
                },

                failure: function (r) {
                    alert(r.d);
                },

                error: function (r) {
                    alert(r.d);
                }
            });
        }

        function drawChart2() {
            var options = {
                title: 'Total Working Hour Of IT Technician Per Day',
                width: 900,
                height: 900,
                legend: { position: "none" },
                backgroundColor: "transparent",
                hAxis: {
                    title: 'DATE',
                },
                vAxis: {
                    title: 'HOUR'
                }
            };

            $.ajax({
                type: "POST",
                url: "ceo.aspx/GetChartData",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    debugger;
                    var data = google.visualization.arrayToDataTable(r.d);
                    var chart = new google.visualization.ColumnChart($("#chart")[0]);
                    chart.draw(data, options);
                },

                failure: function (r) {
                    alert(r.d);
                },

                error: function (r) {
                    alert(r.d);
                }
            });
        }

        function drawChart3() {
            var options = {
                title: 'Total OverTime Hour Of IT Technician Per Day',
                width: 900,
                height: 900,
                legend: { position: "none" },
                backgroundColor: "transparent",
                hAxis: {
                    title: 'DATE',
                },
                vAxis: {
                    title: 'HOUR'
                }
            };

            $.ajax({
                type: "POST",
                url: "ceo.aspx/GetChartData",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    debugger;
                    var data = google.visualization.arrayToDataTable(r.d);
                    var chart = new google.visualization.ColumnChart($("#chart")[0]);
                    chart.draw(data, options);
                },

                failure: function (r) {
                    alert(r.d);
                },

                error: function (r) {
                    alert(r.d);
                }
            });
        }
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
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" runat="server" ScriptMode="Release" LoadScriptsBeforeUI="true"></asp:ScriptManager>
        <div class="container" style="width: 80%;">
            <h2>CEO DASHBOARD</h2>
            <br />
            <br />
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#statisticPart">STATISTIC</a></li>
                <li><a data-toggle="tab" href="#reportPart">REPORT</a></li>
            </ul>

            <div class="tab-content">
                <div id="statisticPart" class="tab-pane fade in active" style="width: 100%; margin: 0px auto 0px auto;">
                    <br />
                    <h3 style="margin-left: 10%">STATISTIC</h3>
                    <br />
                    <div style="text-align: center">
                        <label style="font-size: 18px;">From:</label>&nbsp; 
                        <asp:TextBox ID="TextBox3" runat="server" TextMode="Date" class="form-control" Style="width: 30%; display: inline"></asp:TextBox>&nbsp;&nbsp; 
                        <label style="font-size: 18px;">To:</label>&nbsp; 
                        <asp:TextBox ID="TextBox4" runat="server" TextMode="Date" class="form-control" Style="width: 30%; display: inline"></asp:TextBox>
                        <br />
                        <br />
                        <label style="font-size: 18px; margin-left: -3%">Type:</label>&nbsp;
                        <asp:DropDownList ID="DropDownList1" runat="server" class="select-css" Style="width: 30%; display: inline;">
                            <asp:ListItem Value="rs">Request Status</asp:ListItem>
                            <asp:ListItem Value="wt">Working Time</asp:ListItem>
                            <asp:ListItem Value="oh">Over Hour</asp:ListItem>
                        </asp:DropDownList>&nbsp;&nbsp;&nbsp;&nbsp;
                        <label style="font-size: 18px;">IT Technician:</label>&nbsp;
                        <asp:DropDownList ID="DropDownList2" runat="server" class="select-css" Style="width: 20%; display: inline;" DataSourceID="SqlDataSource1" DataTextField="accountID" DataValueField="accountID"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:db_con %>" SelectCommand="SELECT [accountID] FROM [Account] WHERE (([role] = @role) AND ([accountID] &lt;&gt; @accountID))">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="IT Technician" Name="role" Type="String" />
                                <asp:Parameter DefaultValue="1" Name="accountID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <br />
                        <asp:Label ID="Label2" runat="server" Text="" ForeColor="Red" Style="margin-right: 40%"></asp:Label>
                        <br />
                        <br />
                    </div>
                    <div style="text-align: center;">
                        <button id="subBut3" onclick="return false;" validationgroup="group2">DISPLAY</button>
                    </div>
                    <div id="chart" style="width: 950px; height: 950px; margin-left: 20%"></div>
                    <br />
                </div>

                <div id="reportPart" class="tab-pane fade">
                    <br />
                    <h3 style="margin-left: 10%">REPORT</h3>
                    <br />
                    <div style="text-align: center;">

                        <label style="font-size: 18px;">From:</label>&nbsp; 
                    <asp:TextBox ID="TextBox1" runat="server" TextMode="Date" class="form-control" Style="width: 30%; display: inline"></asp:TextBox>&nbsp;&nbsp; 
                    <label style="font-size: 18px;">To:</label>&nbsp;
                    <asp:TextBox ID="TextBox2" runat="server" class="form-control" Style="width: 30%; display: inline" TextMode="Date"></asp:TextBox>
                    </div>
                    <br />
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="group1" ForeColor="Red" Style="margin-left: 20%" />
                    <br />
                    <div style="text-align: center;">
                        <button id="subBut1" style="display: inline;">DISPLAY</button>
                        <button id="subBut2" style="display: inline; margin-left: 5%;">DOWNLOAD</button>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required From Date" Display="None" ControlToValidate="TextBox1" ValidationGroup="group1"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required To Date" ControlToValidate="TextBox2" ValidationGroup="group1" Display="None"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="From Date Must Before The To Date" ValidationGroup="group1" Display="None" ControlToCompare="TextBox1" ControlToValidate="TextBox2" Operator="GreaterThan"></asp:CompareValidator>
                    </div>
                    <asp:Button ID="Button1" runat="server" Text="Button" Style="display: none;" OnClick="Button1_Click" ValidationGroup="group1" />
                    <asp:Button ID="Button2" runat="server" Text="Button" Style="display: none;" OnClick="Button2_Click" ValidationGroup="group1" />
                    <br />
                    <br />
                    <asp:GridView ID="GridView1" runat="server" class="table table-hover" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="requestDate" HeaderText="Generated Date" ReadOnly="True" />
                            <asp:BoundField DataField="requestID" HeaderText="Request ID" ReadOnly="True" />
                            <asp:BoundField DataField="fullName" HeaderText="Client FullName" ReadOnly="True" />
                            <asp:BoundField DataField="email" HeaderText="Client Email" ReadOnly="True" />
                            <asp:BoundField DataField="issueName" HeaderText="Issue Name" ReadOnly="True" />
                            <asp:BoundField DataField="description" HeaderText="Issue Description" ReadOnly="True" />
                            <asp:BoundField DataField="status" HeaderText="Request Status" ReadOnly="True" />
                            <asp:BoundField DataField="completedDate" HeaderText="Completed Date" ReadOnly="True" />
                            <asp:BoundField DataField="personInCharge" HeaderText="ITTech ID" ReadOnly="True" />
                            <asp:BoundField DataField="ITfullName" HeaderText="ITTech FullName" ReadOnly="True" />
                            <asp:BoundField DataField="totalWorkingHour" HeaderText="Total Office Hour" ReadOnly="True" />
                            <asp:BoundField DataField="totalOverTime" HeaderText="Total OverTime Hour" ReadOnly="True" />
                            <asp:BoundField DataField="feedBackDescription" HeaderText="FeedBack Description" ReadOnly="True" />
                            <asp:BoundField DataField="feedBackRating" HeaderText="Rating(1-5)" ReadOnly="True" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <asp:Label ID="Label1" runat="server" Text="" Style="display: none"></asp:Label>
    </form>
</body>
</html>
