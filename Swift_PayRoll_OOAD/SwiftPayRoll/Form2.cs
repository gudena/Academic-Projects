using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace SwiftPayRoll
{
    public partial class Form2 : Form
    {
        public Form2(string str)
        {
            InitializeComponent();
            pass.Text = str;
            string connectionString = null;
            MySqlConnection cnn;
            connectionString = "server=localhost;database=swiftpayroll;uid=root;pwd=admin;";
            cnn = new MySqlConnection(connectionString);
  
            cnn.Open();
            string query = "select * from personaldata where EmployeeID = '"+Int32.Parse(pass.Text)+"'";
            MySqlCommand user = new MySqlCommand(query, cnn);
            MySqlDataReader sqlreader;
            sqlreader = user.ExecuteReader();
            sqlreader.Read();
            IDTB.Text = sqlreader.GetString("EmployeeID");
            FNameTB.Text = sqlreader.GetString("FirstName");
            LNameTB.Text = sqlreader.GetString("LastName");
            GenderTB.Text = sqlreader.GetString("Gender");
            DOBTB.Text = sqlreader.GetString("DOB");
            JobLevelTB.Text = sqlreader.GetString("JobDesignation");
            eMailTB.Text = sqlreader.GetString("EmailID");
            AddLine1TB.Text = sqlreader.GetString("Address1");
            AddLine2TB.Text = sqlreader.GetString("Address2");
            StateTB.Text = sqlreader.GetString("State");
            ZipTB.Text = sqlreader.GetString("Zip");
            CityTB.Text = sqlreader.GetString("City");
           
        }

        private void Form2_Load(object sender, EventArgs e)
        {

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void Close_Click(object sender, EventArgs e)
        {
            this.Hide();
            Form1 f1 = new Form1();
            f1.ShowDialog();
        }
    }
}
