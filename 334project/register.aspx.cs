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
    public partial class register : System.Web.UI.Page
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_con"].ConnectionString;

            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            string query = "If Not Exists(SELECT * FROM Account WHERE userName=@userN) BEGIN INSERT INTO Account " +
                "(userName, fullName, resetKey, password, email, role) VALUES (@userN, @fName, @rKey, @passWord, @email, @role) END";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@userN", TextBox1.Text.Trim());
            cmd.Parameters.AddWithValue("@fName", TextBox5.Text.Trim());
            cmd.Parameters.AddWithValue("@rKey", TextBox6.Text.Trim());
            cmd.Parameters.AddWithValue("@passWord", TextBox2.Text.Trim());
            cmd.Parameters.AddWithValue("@email", TextBox4.Text.Trim());
            cmd.Parameters.AddWithValue("@role", DropDownList1.Text);

            int result = cmd.ExecuteNonQuery();

            if (result > 0)
            {
                Label1.Text = "User created. Please go to Login page to proceed.";
            }
            else
            {
                Label1.Text = "Error! User name already exists";
            }

            con.Close();

        }

    }
}