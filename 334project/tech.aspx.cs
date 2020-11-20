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
    public partial class tech : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["db_con"].ConnectionString;
        string accountID = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] != "IT Technician")
            {
                Response.Redirect("login.aspx");
            }

            SqlConnection con = new SqlConnection(connectionString);
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

            string query = "SELECT Request.requestID, Account.fullName, Account.email, Request.issueName, Request.description, convert(varchar, Request.assignedDate, 101) AS assignedDate, Request.status FROM Request JOIN Account ON Request.personInCharge =" + accountID + " AND Account.accountID = Request.accountID AND Request.status = 'Processing'";

            SqlCommand cmd = new SqlCommand(query, con);

            SqlDataReader sdr = cmd.ExecuteReader();

            GridView1.DataSource = sdr;
            GridView1.DataBind();

            con.Close();
            con.Open();

            query = "SELECT Request.requestID, Account.fullName, Account.email, Request.issueName, Request.description, convert(varchar, Request.assignedDate, 101) AS assignedDate, convert(varchar, Request.completedDate, 101) AS completedDate FROM Request JOIN Account ON Request.personInCharge =" + accountID + " AND Account.accountID = Request.accountID AND Request.status = 'Completed'";

            cmd = new SqlCommand(query, con);

            sdr = cmd.ExecuteReader();

            GridView2.DataSource = sdr;
            GridView2.DataBind();

            con.Close();

            con.Open();

            query = "SELECT requestID FROM Request WHERE status='Processing' AND personInCharge=" + accountID;

            cmd = new SqlCommand(query, con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (!Page.IsPostBack)
            {
                DropDownList2.DataSource = ds;
                DropDownList2.DataTextField = "requestID";
                DropDownList2.DataValueField = "requestID";
                DropDownList2.DataBind();

            }
            con.Close();

            con.Open();

            query = "SELECT requestID FROM Request WHERE status='Processing' AND personInCharge=" + accountID;

            cmd = new SqlCommand(query, con);
            sda = new SqlDataAdapter(cmd);
            ds = new DataSet();
            sda.Fill(ds);
            if (!Page.IsPostBack)
            {
                DropDownList1.DataSource = ds;
                DropDownList1.DataTextField = "requestID";
                DropDownList1.DataValueField = "requestID";
                DropDownList1.DataBind();
            }
            con.Close();
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            Label1.Text = "";

            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            string query = "SELECT Request.requestID, Account.fullName, Account.email, Request.issueName, Request.description, convert(varchar, Request.assignedDate, 101) AS assignedDate, Request.status FROM Request JOIN Account ON Request.personInCharge =" + accountID + " AND Account.accountID = Request.accountID AND Request.requestID=@request AND Request.status = 'Processing'";

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
            string statuss = "";
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            string que = "SELECT status FROM Request WHERE requestID = @request AND personInCharge =" + accountID;
            SqlCommand cmd2 = new SqlCommand(que, con);

            cmd2.Parameters.AddWithValue("@request", TextBox2.Text.Trim());

            SqlDataReader sdr2 = cmd2.ExecuteReader();
            while (sdr2.Read())
            {
                statuss = sdr2["status"].ToString();
            }

            con.Close();
            if (statuss == "Completed")
            {
                Label4.Text = "Error! Request already was marked as completed. Please enter another valid requestID";
            }
            else if (statuss == "")
            {
                Label4.Text = "Error! The requestID is wrong or the request was not assigned to you. Please enter valid requestID.";
            }
            else
            {
                con.Open();
                string query = "UPDATE Request SET status = 'Completed', completedDate= getdate() WHERE requestID = @request AND personInCharge =" + accountID;

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@request", TextBox2.Text.Trim());

                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    TextBox2.Text = "";
                    Label4.Text = "Status is changed successfully. The request now is completed.";
                }
                else
                {
                    Label4.Text = "Oops! Some error occur.";
                }
                con.Close();
            }
        }

        protected void TextBox3_TextChanged(object sender, EventArgs e)
        {
            Label5.Text = "";

            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            string query = "SELECT Request.requestID, Account.fullName, Account.email, Request.issueName, Request.description, convert(varchar, Request.assignedDate, 101) AS assignedDate, convert(varchar, Request.completedDate, 101) AS completedDate FROM Request JOIN Account ON Request.personInCharge =" + accountID + " AND Account.accountID = Request.accountID AND Request.requestID=@request AND Request.status = 'Completed'";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@request", TextBox3.Text.Trim());

            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.HasRows)
            {
                Label5.Text = "";
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
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            DateTime thisDay = DateTime.Today;
            string assignedDate = "";
            string query = "SELECT assignedDate FROM Request WHERE requestID=@request";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@request", DropDownList2.SelectedItem.Text);

            SqlDataReader sdr = cmd.ExecuteReader();
            while (sdr.Read())
            {
                assignedDate = sdr["assignedDate"].ToString();
            }
            con.Close();

            DateTime dt1 = convertDate(assignedDate);
            DateTime dt2 = convertDate(TextBox4.Text.Trim());

            if (dt1.Date > dt2.Date)
            {
                Label4.Text = "Error! You choose the date before the assigned date which is wrong.";
                TextBox4.Text = "";
                DropDownList3.SelectedIndex = -1;
            }
            else if (dt2.Date > thisDay.Date)
            {
                Label4.Text = "Error! You choose the date in the future which is wrong.";
                TextBox4.Text = "";
                DropDownList3.SelectedIndex = -1;
            }
            else
            {
                con.Open();

                query = "INSERT INTO OverWorkingHour (date, overHour, requestID, accountID, rate) VALUES (@date, @overTime, @request, " + accountID + ", 20)";

                cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@date", TextBox4.Text.Trim());
                cmd.Parameters.AddWithValue("@request", DropDownList2.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@overTime", DropDownList3.SelectedItem.Value);

                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    con.Close();
                    Label4.Text = "Over Working Hour was added successfully.";
                    TextBox4.Text = "";
                    DropDownList3.SelectedIndex = -1;
                }
                else
                {
                    con.Close();
                    Label4.Text = "Oops! Some error occur.";
                }
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            DateTime thisDay = DateTime.Today;
            string assignedDate = "";
            string query = "SELECT assignedDate FROM Request WHERE requestID=@request";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@request", DropDownList1.SelectedItem.Text);

            SqlDataReader sdr = cmd.ExecuteReader();
            while (sdr.Read())
            {
                assignedDate = sdr["assignedDate"].ToString();
            }
            con.Close();

            DateTime dt1 = convertDate(assignedDate);
            DateTime dt2 = convertDate(TextBox5.Text.Trim());

            if (dt1.Date > dt2.Date)
            {
                Label4.Text = "Error! You choose the date before the assigned date which is wrong.";
                TextBox5.Text = "";
                DropDownList4.SelectedIndex = -1;
            }
            else if (dt2.Date > thisDay.Date)
            {
                Label4.Text = "Error! You choose the date in the future which is wrong.";
                TextBox5.Text = "";
                DropDownList4.SelectedIndex = -1;
            }
            else
            {
                con.Open();

                query = "INSERT INTO HourSpent (date, workingHour, requestID, accountID) VALUES (@date, @officeHour, @request, " + accountID + ")";

                cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@date", TextBox5.Text.Trim());
                cmd.Parameters.AddWithValue("@request", DropDownList1.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@officeHour", DropDownList4.SelectedItem.Value);

                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    con.Close();
                    Label4.Text = "Office Working Hour was added successfully.";
                    TextBox5.Text = "";
                    DropDownList4.SelectedIndex = -1;
                }
                else
                {
                    con.Close();
                    Label4.Text = "Oops! Some error occur.";
                }
            }
        }

        private static DateTime convertDate(string date)
        {
            return DateTime.Parse(date);
        }
    }
}