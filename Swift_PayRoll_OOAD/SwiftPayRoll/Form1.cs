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
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Search_Click(object sender, EventArgs e)
        {
            this.Hide();
            Form2 form2 = new Form2(EmpIDTB.Text);
            form2.ShowDialog();
            
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

  
    }
}
