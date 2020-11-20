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
    public partial class resetPassword : System.Web.UI.Page
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

        protected void Button3_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_con"].ConnectionString;

            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            string query = "UPDATE Account SET password=@passWord WHERE userName=@userN AND resetKey=@rKey";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@userN", TextBox1.Text.Trim());
            cmd.Parameters.AddWithValue("@rKey", TextBox2.Text.Trim());
            cmd.Parameters.AddWithValue("@passWord", TextBox3.Text.Trim());

            int result = cmd.ExecuteNonQuery();

            if (result > 0)
            {
                Label1.Text = "Password changed. Please go to Login page to proceed.";
            }
            else
            {
                Label1.Text = "Oops! Some error occur. You might enter wrong userName or resetKey. Please re-enter values and try again.";
            }

            con.Close();
        }
    }
}