using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Generar_tabla
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();

            byte[] data = new byte[8560];

            for (int buc = 0; buc < 118; buc++)
                data[buc] = 85;

            data[8260] = 1;

            File.WriteAllBytes("mapdata.bin", data);

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            List<byte> lo = new List<byte>();
            List<byte> hi = new List<byte>();
            List<int> composite = new List<int>();

            for (int y = 0; y < 192; y++)
            {

                int yy = y;
                int add = ((yy << 2) & 0xE0) | ((yy << 8) & 0x700) | ((yy << 5) & 0x1800);

                composite.Add(add + 16384);

                lo.Add((byte)(add & 0xFF));
                hi.Add((byte)((add >> 8) & 0xFF));

                Debug.Print(add.ToString());
            }

            textBox1.AppendText("Dim tableLo(192) as uByte => { ");

            for (int buc = 0; buc < lo.Count; buc++)
                textBox1.AppendText($"{lo[buc]}, ");

            textBox1.Text = textBox1.Text.Substring(0, textBox1.Text.Length - 2) + " } at 56064\r\n";

            textBox1.AppendText("Dim tableHi(192) as uByte => { ");

            for (int buc = 0; buc < lo.Count; buc++)
                textBox1.AppendText($"{hi[buc]}, ");

            textBox1.Text = textBox1.Text.Substring(0, textBox1.Text.Length - 2) + " } at 56320\r\n";

            textBox1.AppendText("Dim tableCP(192) as uInteger => { ");

            for (int buc = 0; buc < lo.Count; buc++)
                textBox1.AppendText($"{composite[buc]}, ");

            textBox1.Text = textBox1.Text.Substring(0, textBox1.Text.Length - 2) + " } at 56832\r\n";

        }
    }
}
