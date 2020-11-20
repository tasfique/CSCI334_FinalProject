using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace _334project
{
    public partial class manager : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["db_con"].ConnectionString;

        string ConnectionString
        {
            get
            {
                return connectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] != "Project Manager")
            {
                Response.Redirect("login.aspx");
            }
            string accountID = "";
            SqlConnection con = new SqlConnection(ConnectionString);
            con.Open();

            string userN = Session["userN"].ToString();
            string que = "SELECT accountID FROM Account WHERE userName LIKE '" + userN + "%'";
            SqlCommand cmd2 = new SqlCommand(que, con);

            SqlDataReader sdr2 = cmd2.ExecuteReader();
            while (sdr2.Read())
            {
                accountID = sdr2["accountID"].ToString();
            }

            con.Close();
            con.Open();

            string query = "SELECT Request.requestID, Account.fullName, Account.email, Request.issueName, Request.description, convert(varchar, Request.requestDate, 101) AS requestDate FROM Request JOIN Account ON Request.accountID = Account.accountID AND personInCharge=1";

            SqlCommand cmd = new SqlCommand(query, con);

            SqlDataReader sdr = cmd.ExecuteReader();

            GridView1.DataSource = sdr;
            GridView1.DataBind();

            con.Close();
            con.Open();

            query = "SELECT accountID, 'IT Techinician with ID: ' + CONVERT(varchar(10), accountID) AS fullDesc FROM Account WHERE accountID != 1 AND role = 'IT Technician'";

            cmd = new SqlCommand(query, con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (!Page.IsPostBack)
            {
                DropDownList1.DataSource = ds;
                DropDownList1.DataTextField = "fullDesc";
                DropDownList1.DataValueField = "accountID";
                DropDownList1.DataBind();

            }
            con.Close();
            con.Open();

            query = "SELECT Account.accountID, Account.fullName, Account.email, Request.requestID, Request.issueName, Request.description, convert(varchar, Request.assignedDate, 101) AS assignedDate, ITTechStatus = (SELECT CASE WHEN COUNT(requestID) >2 THEN 'Busy' ELSE 'Available' END AS ITStatus FROM Request WHERE personInCharge = Account.accountID AND status != 'Completed' AND assignedDate IS NOT NULL GROUP BY personInCharge ) FROM Request JOIN Account ON Request.personInCharge = Account.accountID AND Request.assignedDate IS NOT NULL AND Request.status != 'Completed'";

            cmd = new SqlCommand(query, con);

            sdr = cmd.ExecuteReader();

            GridView2.DataSource = sdr;
            GridView2.DataBind();

            con.Close();
            con.Open();

            query = "SELECT OverWorkingHour.overTimeID, Account.fullName, Account.email, OverWorkingHour.requestID, convert(varchar, OverWorkingHour.date, 101) AS date, OverWorkingHour.overHour, OverWorkingHour.rate, (OverWorkingHour.rate * OverWorkingHour.overHour) AS earn FROM OverWorkingHour JOIN Account ON OverWorkingHour.accountID = Account.accountID";

            cmd = new SqlCommand(query, con);

            sdr = cmd.ExecuteReader();

            GridView3.DataSource = sdr;
            GridView3.DataBind();

            con.Close();
            con.Open();

            query = "SELECT Request.requestID, Request.issueName, Request.description, Request.personInCharge, convert(varchar, Request.requestDate, 101) AS requestDate, convert(varchar, Request.assignedDate, 101) AS assignedDate, convert(varchar, getdate(), 101) AS todayDate, DATEDIFF(day, Request.assignedDate, getdate()) AS dateSpent FROM Request WHERE personInCharge!= 1 AND status != 'Completed' AND DATEDIFF(day, Request.assignedDate, getdate()) > 7";

            cmd = new SqlCommand(query, con);

            sdr = cmd.ExecuteReader();

            GridView4.DataSource = sdr;
            GridView4.DataBind();

            con.Close();

            con.Open();

            query = "SELECT accountID, 'IT Techinician with ID: ' + CONVERT(varchar(10), accountID) AS fullDesc FROM Account WHERE accountID != 1 AND role = 'IT Technician'";

            cmd = new SqlCommand(query, con);
            sda = new SqlDataAdapter(cmd);
            ds = new DataSet();
            sda.Fill(ds);
            if (!Page.IsPostBack)
            {
                DropDownList2.DataSource = ds;
                DropDownList2.DataTextField = "fullDesc";
                DropDownList2.DataValueField = "accountID";
                DropDownList2.DataBind();

            }
            con.Close();
            con.Open();

            query = "SELECT a.accountID, a.fullName, a.email, SUM(h.workingHour) AS totalHour, h.requestID FROM HourSpent AS h JOIN Account AS a ON h.accountID=a.accountID GROUP BY h.requestID, a.accountID, a.fullName, a.email ORDER BY a.accountID";

            cmd = new SqlCommand(query, con);

            sdr = cmd.ExecuteReader();

            GridView5.DataSource = sdr;
            GridView5.DataBind();

            con.Close();
            con.Open();

            query = "SELECT OverWorkingHour.accountID, Account.fullName, Account.email, OverWorkingHour.rate, SUM(OverWorkingHour.overHour) AS totalOverHour, OverWorkingHour.requestID FROM OverWorkingHour JOIN Account ON OverWorkingHour.accountID = Account.accountID GROUP BY OverWorkingHour.requestID, OverWorkingHour.accountID, Account.fullName, Account.email, OverWorkingHour.rate ORDER BY OverWorkingHour.accountID";

            cmd = new SqlCommand(query, con);

            sdr = cmd.ExecuteReader();

            GridView6.DataSource = sdr;
            GridView6.DataBind();

            con.Close();
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            Label1.Text = "";

            SqlConnection con = new SqlConnection(ConnectionString);
            con.Open();

            string query = "SELECT Request.requestID, Account.fullName, Account.email, Request.issueName, Request.description, convert(varchar, Request.requestDate, 101) AS requestDate FROM Request JOIN Account ON Request.accountID = Account.accountID AND personInCharge=1 AND Request.requestID=@request";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@request", TextBox1.Text.Trim());

            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.HasRows)
            {
                GridView1.DataSource = sdr;
                GridView1.DataBind();
            }
            else
            {
                Label1.Text = "No Data Found. Please refer to the table.";
            }
            con.Close();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string personInCharge = "0";
            SqlConnection con = new SqlConnection(ConnectionString);
            con.Open();

            string query = "SELECT personInCharge FROM Request WHERE requestID = @request";
            SqlCommand cmd2 = new SqlCommand(query, con);

            cmd2.Parameters.AddWithValue("@request", TextBox2.Text.Trim());

            SqlDataReader sdr2 = cmd2.ExecuteReader();
            while (sdr2.Read())
            {
                personInCharge = sdr2["personInCharge"].ToString();
            }

            con.Close();

            if (personInCharge == "0")
            {
                TextBox2.Text = "";
                Label4.Text = "Error! There is no requestID as such. Please re-enter requestID.";
            }
            else if (personInCharge != "1")
            {
                TextBox2.Text = "";
                Label4.Text = "Error! Request was assigned to a IT Technician. Please enter another requestID";
            }
            else
            {
                con.Open();
                query = "UPDATE Request SET personInCharge = @itTech, status = 'Processing', assignedDate = getdate()  WHERE requestID = @request";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@itTech", DropDownList1.SelectedItem.Value);
                cmd.Parameters.AddWithValue("@request", TextBox2.Text.Trim());

                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    Label4.Text = "Request is assigned to IT Technician successfully.";
                }
                else
                {
                    Label4.Text = "Oops! Some error occur.";
                }
                TextBox2.Text = "";
                con.Close();
            }
        }

        protected void TextBox3_TextChanged(object sender, EventArgs e)
        {
            Label5.Text = "";

            SqlConnection con = new SqlConnection(ConnectionString);
            con.Open();

            string query = "SELECT Account.accountID, Account.fullName, Account.email, Request.requestID, Request.issueName, Request.description, convert(varchar, Request.assignedDate, 101) AS assignedDate, ITTechStatus = (SELECT CASE WHEN COUNT(requestID) >2 THEN 'Busy' ELSE 'Available' END AS ITStatus FROM Request WHERE personInCharge = Account.accountID AND status != 'Completed' AND assignedDate IS NOT NULL GROUP BY personInCharge ) FROM Request JOIN Account ON Request.personInCharge = Account.accountID AND Account.accountID=@itTechID AND Request.assignedDate IS NOT NULL AND Request.status != 'Completed'";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@itTechID", TextBox3.Text.Trim());

            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.HasRows)
            {
                GridView2.DataSource = sdr;
                GridView2.DataBind();
            }
            else
            {
                Label5.Text = "No Data Found. Please refer to the table.";
            }
            con.Close();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConnectionString);
            string rate = "";
            con.Open();

            string query = "SELECT rate FROM OverWorkingHour";

            SqlCommand cmd = new SqlCommand(query, con);

            SqlDataReader sdr = cmd.ExecuteReader();

            while (sdr.Read())
            {
                rate = sdr["rate"].ToString();
            }

            con.Close();

            if (rate == TextBox4.Text.Trim())
            {
                TextBox4.Text = "";
                Label4.Text = "Error! New rate is same as the current rate.";
            }
            else
            {
                Session["rate"] = rate;

                con.Open();
                query = "UPDATE OverWorkingHour SET rate = @newRate";

                cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@newRate", TextBox4.Text.Trim());

                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    con.Close();
                    con.Open();

                    query = "SELECT OverWorkingHour.overTimeID, Account.fullName, Account.email, OverWorkingHour.requestID, OverWorkingHour.date, OverWorkingHour.overHour, OverWorkingHour.rate, (OverWorkingHour.rate * OverWorkingHour.overHour) AS earn FROM OverWorkingHour JOIN Account ON OverWorkingHour.accountID = Account.accountID";

                    cmd = new SqlCommand(query, con);

                    sdr = cmd.ExecuteReader();

                    GridView3.DataSource = sdr;
                    GridView3.DataBind();

                    Label4.Text = "New rate for over working hour updated successfully.";
                }
                else
                {
                    Label4.Text = "Oops! Some error occur.";
                }
                con.Close();
            }
            TextBox4.Text = "";
        }

        protected void TextBox5_TextChanged(object sender, EventArgs e)
        {
            Label6.Text = "";

            SqlConnection con = new SqlConnection(ConnectionString);
            con.Open();

            string query = "SELECT Request.requestID, Request.issueName, Request.description, Request.personInCharge, convert(varchar, Request.requestDate, 101) AS requestDate, convert(varchar, Request.assignedDate, 101) AS assignedDate, convert(varchar, getdate(), 101) AS todayDate, DATEDIFF(day, Request.assignedDate, getdate()) AS dateSpent FROM Request WHERE personInCharge!= 1 AND status != 'Completed' AND DATEDIFF(day, Request.assignedDate, getdate()) > 7 AND requestID=@requestID";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@requestID", TextBox5.Text.Trim());

            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.HasRows)
            {
                GridView4.DataSource = sdr;
                GridView4.DataBind();
            }
            else
            {
                Label6.Text = "No Data Found. Please refer to the table.";
            }
            con.Close();
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            string personInCharge = "0";
            string status = "";
            string dateSpent = "-1";
            SqlConnection con = new SqlConnection(ConnectionString);
            con.Open();

            string query = "SELECT personInCharge, status, DATEDIFF(day, assignedDate, getdate()) AS dateSpent FROM Request WHERE requestID = @request";
            SqlCommand cmd2 = new SqlCommand(query, con);

            cmd2.Parameters.AddWithValue("@request", TextBox6.Text.Trim());

            SqlDataReader sdr2 = cmd2.ExecuteReader();
            while (sdr2.Read())
            {
                personInCharge = sdr2["personInCharge"].ToString();
                status = sdr2["status"].ToString();
                dateSpent = sdr2["dateSpent"].ToString();
            }

            con.Close();

            int dateCheck;
            if (!Int32.TryParse(dateSpent, out dateCheck))
            {
                dateCheck = 0;
            }


            if (status == "Completed")
            {
                Label4.Text = "Error! The request was solved, you key in the completed request. Please re-enter requestID.";
            }
            else if (dateCheck <= 7 && dateSpent != "-1")
            {
                Label4.Text = "Error! The request is being handled. Please enter request which exceeds one week.";
            }
            else if (personInCharge == "0")
            {
                Label4.Text = "Error! There is no requestID as such. Please re-enter requestID.";
            }
            else if (personInCharge == "1")
            {
                Label4.Text = "Error! This request is unassigned to any IT Technician, go to tab Assign Requests to proceed. Please re-enter valid requestID to reallocate man power.";

            }
            else if (personInCharge == DropDownList2.SelectedItem.Value)
            {
                Label4.Text = "Error! You reallocate the same IT Technician to the request. Please choose another IT Technician.";
            }
            else
            {
                con.Open();
                query = "UPDATE Request SET personInCharge = @itTech, assignedDate=getdate() WHERE requestID = @request";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@itTech", DropDownList2.SelectedItem.Value);
                cmd.Parameters.AddWithValue("@request", TextBox6.Text.Trim());


                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    con.Close();

                    con.Open();

                    query = "SELECT Request.requestID, Request.issueName, Request.description, Request.personInCharge, convert(varchar, Request.requestDate, 101) AS" +
                        " requestDate, convert(varchar, Request.assignedDate, 101) AS assignedDate, convert(varchar, getdate(), 101) AS todayDate, DATEDIFF(day, Request.assignedDate, getdate())" +
                        " AS dateSpent FROM Request WHERE personInCharge!= 1 AND status != 'Completed' AND DATEDIFF(day, Request.assignedDate, getdate()) > 7";

                    cmd = new SqlCommand(query, con);

                    SqlDataReader sdr = cmd.ExecuteReader();
                    GridView4.DataSource = sdr;
                    GridView4.DataBind();

                    Label4.Text = "The request is assigned to another IT Technician to solve.";
                }
                else
                {
                    Label4.Text = "Oops! Some error occur.";
                }
                con.Close();
            }
            TextBox6.Text = "";
        }

        protected void TextBox7_TextChanged(object sender, EventArgs e)
        {
            Label9.Text = "";
            bool check1 = true, check2 = true;

            SqlConnection con = new SqlConnection(ConnectionString);
            con.Open();

            string query = "SELECT a.accountID, a.fullName, a.email, SUM(h.workingHour) AS totalHour, h.requestID FROM HourSpent AS h JOIN Account AS a ON h.accountID=a.accountID WHERE h.accountID=@ittechID GROUP BY h.requestID, a.accountID, a.fullName, a.email ORDER BY a.accountID";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@ittechID", TextBox7.Text.Trim());

            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.HasRows)
            {
                GridView5.DataSource = sdr;
                GridView5.DataBind();
            }
            else
            {
                check1 = false;
            }
            con.Close();

            con.Open();

            query = "SELECT OverWorkingHour.accountID, Account.fullName, Account.email, OverWorkingHour.rate, SUM(OverWorkingHour.overHour) AS totalOverHour, OverWorkingHour.requestID FROM OverWorkingHour JOIN Account ON OverWorkingHour.accountID = Account.accountID WHERE OverWorkingHour.accountID=@ittechID GROUP BY OverWorkingHour.requestID, OverWorkingHour.accountID, Account.fullName, Account.email, OverWorkingHour.rate ORDER BY OverWorkingHour.accountID";

            cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@ittechID", TextBox7.Text.Trim());

            sdr = cmd.ExecuteReader();

            if (sdr.HasRows)
            {
                GridView6.DataSource = sdr;
                GridView6.DataBind();
            }
            else
            {
                check2 = false;
            }
            con.Close();

            if (!check1 && !check2)
            {
                Label9.Text = "No Data Found. Please refer to two tables below.";
            }
            else if (check1 && !check2)
            {
                Label9.Text = "No Data Found. Please refer to the total overtime hour table.";
            }
            else if (!check1 && check2)
            {
                Label9.Text = "No Data Found. Please refer to the total office hour table.";
            }
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            if (Session["rate"] != null)
            {
                SqlConnection con = new SqlConnection(ConnectionString);
                con.Open();

                string query = "UPDATE OverWorkingHour SET rate = @newRate";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@newRate", Session["rate"]);

                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    con.Close();
                    con.Open();

                    query = "SELECT OverWorkingHour.overTimeID, Account.fullName, Account.email, OverWorkingHour.requestID, OverWorkingHour.date, OverWorkingHour.overHour, OverWorkingHour.rate, (OverWorkingHour.rate * OverWorkingHour.overHour) AS earn FROM OverWorkingHour JOIN Account ON OverWorkingHour.accountID = Account.accountID";

                    cmd = new SqlCommand(query, con);

                    SqlDataReader sdr = cmd.ExecuteReader();

                    GridView3.DataSource = sdr;
                    GridView3.DataBind();

                    Label4.Text = "The rate is changed to the previous value successfully.";
                }
                else
                {
                    Label4.Text = "Oops! Some error occur.";
                }
                con.Close();
                Session.Remove("rate");
            }
            else
            {
                Label4.Text = "You haven't changed the new rate, so it's not needed to changed back rate to the previous value.";
            }
        }
    }
}