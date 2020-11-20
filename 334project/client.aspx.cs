using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace _334project
{
    public partial class client : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["db_con"].ConnectionString;
        string accountID = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] != "Client")
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

            string query = "SELECT Request.requestID, Account.fullName, Account.email, Request.issueName, Request.description, convert(varchar, Request.requestDate, 101) AS requestDate, Request.status FROM Request JOIN Account ON Request.personInCharge = Account.accountID AND Request.accountID=" + accountID;

            SqlCommand cmd = new SqlCommand(query, con);

            SqlDataReader sdr = cmd.ExecuteReader();

            GridView1.DataSource = sdr;
            GridView1.DataBind();
            //string output = "<tr><th>Request ID</th><th>IT Full Name</th><th>IT Email</th><th>Issue Name</th><th>Issue Description</th><th>Generated Date</th><th>Status</th></tr>";

            //while (sdr.Read())
            //{
            //    output += "<tr><td>" + sdr["requestID"].ToString() + "</td>";
            //    output += "<td>" + sdr["fullName"].ToString() + "</td>";
            //    output += "<td>" + sdr["email"].ToString() + "</td>";
            //    output += "<td>" + sdr["issueName"].ToString() + "</td>";
            //    output += "<td>" + sdr["description"].ToString() + "</td>";
            //    output += "<td>" + sdr["requestDate"].ToString() + "</td>";
            //    output += "<td>" + sdr["status"].ToString() + "</td></tr>";
            //}

            con.Close();

            con.Open();

            query = "SELECT requestID FROM Request WHERE feedBack=0 AND status='Completed' AND accountID=" + accountID;

            cmd = new SqlCommand(query, con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (!Page.IsPostBack)
            {
                DropDownList1.DataSource = ds;
                DropDownList1.DataTextField = "requestID";
                DropDownList1.DataValueField = "requestID";
                DropDownList1.DataBind();

            }
            //DropDownList1.DataSource = ds;
            //DropDownList1.DataTextField = "requestID";
            //DropDownList1.DataValueField = "requestID";
            //DropDownList1.DataBind();
            con.Close();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            string query = "INSERT INTO Request (issueName, description, accountID, personInCharge, requestDate, status, feedBack) VALUES (@issueN, @desc," + accountID + ", 1, getdate(), 'Pending', 0)";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@issueN", TextBox1.Text.Trim());
            cmd.Parameters.AddWithValue("@desc", TextArea1.Value.Trim());

            int result = cmd.ExecuteNonQuery();

            if (result > 0)
            {
                query = "SELECT Request.requestID, Account.fullName, Account.email, Request.issueName, Request.description, convert(varchar, Request.requestDate, 101) AS requestDate, Request.status FROM Request JOIN Account ON Request.personInCharge = Account.accountID AND Request.accountID=" + accountID;

                SqlCommand cmd2 = new SqlCommand(query, con);

                SqlDataReader sdr = cmd2.ExecuteReader();

                GridView1.DataSource = sdr;
                GridView1.DataBind();
                //Label1.Text = "Request was made successfully.";
                TextBox1.Text = "";
                TextArea1.Value = "";
            }
            else
            {
                Label1.Text = "Oops! Some error occur.";
            }

            con.Close();
        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {
            Label2.Text = "";

            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            string query = "SELECT Request.requestID, Account.fullName, Account.email, Request.issueName, Request.description, convert(varchar, Request.requestDate, 101) AS requestDate, Request.status FROM Request JOIN Account ON Request.personInCharge = Account.accountID AND Request.requestID=@request AND Request.accountID=" + accountID;

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@request", TextBox2.Text.Trim());

            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.HasRows) { 
            GridView1.DataSource = sdr;
            GridView1.DataBind();
            }
            else
            {
                Label2.Text = "No Data Found. Please refer to the table.";
            }
            con.Close();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {            
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            string query = "UPDATE Request SET feedBack=1, feedBackDescription = @feedDesc, feedBackRating = @rating WHERE requestID=@request";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@feedDesc", TextArea2.Value.Trim());
            cmd.Parameters.AddWithValue("@rating", Rating1.CurrentRating);
            cmd.Parameters.AddWithValue("@request", DropDownList1.SelectedItem.Text);

            int result = cmd.ExecuteNonQuery();

            if (result > 0)
            {
                con.Close();

                Label1.Text = "FeedBack was added successfully.";
                TextArea2.Value = "";
                con.Open();

                query = "SELECT requestID FROM Request WHERE feedBack=0 AND status='Completed' AND accountID=" + accountID;

                cmd = new SqlCommand(query, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                DropDownList1.DataSource = ds;
                DropDownList1.DataTextField = "requestID";
                DropDownList1.DataValueField = "requestID";
                DropDownList1.DataBind();
                con.Close();
            }
            else
            {
                Label1.Text = "Oops! Some error occur.";
                con.Close();

            }

        }


    }
}