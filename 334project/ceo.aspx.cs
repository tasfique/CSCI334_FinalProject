using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Data;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.Linq.Expressions;
using System.Web.Services;

namespace _334project
{
    public partial class ceo : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["db_con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] != "CEO")
            {
                Response.Redirect("login.aspx");
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
               server control at run time. */
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            string query = "SELECT convert(varchar, r.requestDate, 101) AS requestDate, r.requestID, a.fullName, a.email, r.issueName, r.description, r.status, convert(varchar, r.completedDate, 101) AS completedDate, r.personInCharge, (SELECT userName FROM Account WHERE r.personInCharge = accountID) AS ITfullName, (SELECT SUM(workingHour) FROM HourSpent WHERE requestID = r.requestID AND accountID = r.personInCharge GROUP BY accountID) AS totalWorkingHour, (SELECT SUM(overHour) FROM OverWorkingHour WHERE requestID = r.requestID AND accountID = r.personInCharge GROUP BY accountID) AS totalOverTime, r.feedBackDescription, r.feedBackRating FROM Request AS r JOIN Account AS a ON r.accountID = a.accountID AND DATEDIFF(day, CONVERT(datetime, @dt1), r.requestDate) >= 0 AND DATEDIFF(day, CONVERT(datetime, @dt2), r.requestDate) <= 0";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@dt1", TextBox1.Text.Trim());
            cmd.Parameters.AddWithValue("@dt2", TextBox2.Text.Trim());


            SqlDataReader sdr = cmd.ExecuteReader();

            GridView1.DataSource = sdr;
            GridView1.DataBind();

            con.Close();

            Label1.Text = "You can go to REPORT Tab to view the data now.";
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    //To Export all pages
                    SqlConnection con = new SqlConnection(connectionString);
                    con.Open();

                    string query = "SELECT convert(varchar, r.requestDate, 101) AS requestDate, r.requestID, a.fullName, a.email, r.issueName, r.description, r.status, convert(varchar, r.completedDate, 101) AS completedDate, r.personInCharge, (SELECT userName FROM Account WHERE r.personInCharge = accountID) AS ITfullName, (SELECT SUM(workingHour) FROM HourSpent WHERE requestID = r.requestID AND accountID = r.personInCharge GROUP BY accountID) AS totalWorkingHour, (SELECT SUM(overHour) FROM OverWorkingHour WHERE requestID = r.requestID AND accountID = r.personInCharge GROUP BY accountID) AS totalOverTime, r.feedBackDescription, r.feedBackRating FROM Request AS r JOIN Account AS a ON r.accountID = a.accountID AND DATEDIFF(day, CONVERT(datetime, @dt1), r.requestDate) >= 0 AND DATEDIFF(day, CONVERT(datetime, @dt2), r.requestDate) <= 0";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@dt1", TextBox1.Text.Trim());
                    cmd.Parameters.AddWithValue("@dt2", TextBox2.Text.Trim());


                    SqlDataReader sdr = cmd.ExecuteReader();

                    GridView1.DataSource = sdr;
                    GridView1.DataBind();

                    con.Close();

                    string from = TextBox1.Text.Trim(), to = TextBox2.Text.Trim();
                    string fileName = "'attachment;filename=Report_From" + from + "_To" + to + ".pdf";

                    GridView1.RenderControl(hw);
                    StringReader sr = new StringReader(sw.ToString());
                    Document pdfDoc = new Document(PageSize.A2, 10f, 10f, 10f, 0f);
                    HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                    PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                    pdfDoc.Open();
                    htmlparser.Parse(sr);
                    pdfDoc.Close();

                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", fileName);
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.End();
                    GridView1.DataBind();
                }
            }
        }

        [WebMethod]
        public static List<object> GetChartData()

        {
            string query = "";
            string value1 = string.Empty, value2 = string.Empty, date1 = string.Empty, date2 = string.Empty;

            Page objp = new Page();
            value1 = objp.Session["value1"].ToString();
            value2 = objp.Session["value2"].ToString();
            date1 = objp.Session["date1"].ToString();
            date2 = objp.Session["date2"].ToString();

            string connectionString = ConfigurationManager.ConnectionStrings["db_con"].ConnectionString;

            List<object> chartData = new List<object>();

            chartData.Add(new object[] { "status", "Value"});

            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            if (value1 == "rs")
            {
                query = "select status, COUNT(status) AS Value from Request WHERE personInCharge = " + value2 + " AND DATEDIFF(day, CONVERT(datetime, @dt1), assignedDate) >= 0 AND DATEDIFF(day, CONVERT(datetime, @dt2), assignedDate) <= 0 GROUP BY status";
            }
            else if (value1 == "wt")
            {
                query = "select convert(varchar, date, 101) AS status, SUM(workingHour) AS Value from HourSpent WHERE accountID = " + value2 + " AND DATEDIFF(day, CONVERT(datetime, @dt1), date) >= 0 AND DATEDIFF(day, CONVERT(datetime, @dt2), date) <= 0 GROUP BY date";
            }
            else if (value1 == "oh")
            {
                query = "select convert(varchar, date, 101) AS status, SUM(overHour) AS Value from OverWorkingHour WHERE accountID = " + value2 + " AND DATEDIFF(day, CONVERT(datetime, @dt1), date) >= 0 AND DATEDIFF(day, CONVERT(datetime, @dt2), date) <= 0 GROUP BY date";
            }

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@dt1", date1);
            cmd.Parameters.AddWithValue("@dt2", date2);

            SqlDataReader sdr = cmd.ExecuteReader();

            while (sdr.Read())
            {
                chartData.Add(new object[]{sdr["status"], sdr["Value"]});
            }
            con.Close();

            return chartData;
        }

        [System.Web.Services.WebMethod]
        public static string CreateSessionViaJavascript(string date11, string date22, string strTest, string strTest2)
        {
            Page objp = new Page();
            objp.Session["date1"] = date11;
            objp.Session["date2"] = date22;
            objp.Session["value1"] = strTest;
            objp.Session["value2"] = strTest2;
            return strTest;
        }

    }
}