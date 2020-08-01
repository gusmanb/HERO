using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace EditorPantallas
{
    public partial class exportForm : Form
    {
        public int ExportIndex { get; set; }
        public exportForm()
        {
            InitializeComponent();
            this.DialogResult = DialogResult.Cancel;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (radioButton1.Checked)
                ExportIndex = 0;
            else
                ExportIndex = (int)numericUpDown1.Value;

            this.DialogResult = DialogResult.OK;
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
