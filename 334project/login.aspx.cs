using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace _334project
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] != null)
            {
                Session.Remove("user");
            }
            if (Session["userN"] != null)
            {
                Session.Remove("userN");
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("register.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_con"].ConnectionString;

            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            string query = "SELECT * FROM Account WHERE userName=@userN AND password=@passWord AND role=@role";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@userN", TextBox1.Text.Trim());
            cmd.Parameters.AddWithValue("@passWord", TextBox2.Text.Trim());
            cmd.Parameters.AddWithValue("@role", DropDownList1.Text);

            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.Read())
            {
                Session["userName"] = sdr["fullName"].ToString();
                Session["user"] = DropDownList1.Text;
                Session["userN"] = TextBox1.Text.Trim();
                if (Session["user"] == "CEO")
                {
                    Response.Redirect("ceo.aspx");
                } else if(Session["user"] == "Project Manager")
                {
                    Response.Redirect("manager.aspx");
                } else if(Session["user"] == "Client")
                {
                    Response.Redirect("client.aspx");
                } else if(Session["user"] == "IT Technician")
                {
                    Response.Redirect("tech.aspx");
                }
            }
            else
            {
                Label1.Text = "Login Error (Wrong Account Input). Please try again with correct input, correct role or reset your password if needed!";
            }

            con.Close();

        }
    }
}