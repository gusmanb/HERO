using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows.Forms;

namespace EditorPantallas
{
    public partial class MainForm : Form
    {
        LevelData selectedLevel;
        PictureBox selectedPb;
        MatchesForm matchFrm;

        byte[] mainData = new byte[70 * 116 + 300]; //70 pantallas, 96 bytes de mapa, 18 de objetos/enemigos, 1 de info general, 1 de solidos
        public MainForm()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            for (int y = 0; y < 12; y++)
            {
                for (int x = 0; x < 32; x++)
                {
                    var pnl = new Panel();
                    pnl.Name = $"{x}_{y}";
                    pnl.Tag = 0;
                    pnl.Width = 32;
                    pnl.Height = 32;
                    pnl.Top = tsMain.Top + tsMain.Height + y * 32;
                    pnl.Left = x * 32;
                    pnl.BackColor = Color.Black;
                    pnl.MouseDown += Pnl_MouseEvent;
                    pnl.MouseMove += Pnl_MouseEvent;
                    pnl.Capture = false;
                    this.Controls.Add(pnl);
                }
            }

            ClientSize = new Size(32 * 32 + lstScreens.Width + 5, 12 * 32 + tsMain.Height + lstOrder.Height + 5);

            cbType.SelectedIndex = 0;
            cbScreenFG.SelectedIndex = 0;
            cbScreenBG.SelectedIndex = 0;
            cbSolidFG.SelectedIndex = 0;
            cbSolidBG.SelectedIndex = 0;
            cbSolidPT.SelectedIndex = 0;
        }

        private void Pnl_MouseEvent(object sender, MouseEventArgs e)
        {
            var pnl = sender as Panel;
            pnl.Capture = false;

            if (cbType.SelectedItem == null || e.Button != MouseButtons.Left)
                return;

            string selected = cbType.SelectedItem.ToString();
            int type = int.Parse(selected.Split('-')[0]);

            SetPanelType(type, pnl);

        }

        private void SetPanelType(int type, Panel pnl)
        {
            pnl.BackgroundImage = null;
            pnl.BackColor = Color.Black;

            switch (type)
            {
                case 1:

                    pnl.BackColor = Color.SaddleBrown;
                    break;

                case 2:

                    pnl.BackColor = Color.Blue;
                    break;

                case 3:

                    pnl.BackColor = Color.LightGray;
                    break;

                case 4:

                    pnl.BackColor = Color.Yellow;
                    break;

                case 5:

                    pnl.BackgroundImage = imgObjects.Images["murcielago"];
                    break;

                case 6:

                    pnl.BackgroundImage = imgObjects.Images["aranya"];
                    break;

                case 7:

                    pnl.BackgroundImage = imgObjects.Images["mosca"];
                    break;

                case 8:

                    pnl.BackgroundImage = imgObjects.Images["bicho"];
                    break;

                case 9:

                    pnl.BackgroundImage = imgObjects.Images["cangrejo"];
                    break;

                case 10:

                    pnl.BackgroundImage = imgObjects.Images["serpiente"];
                    break;

                case 11:

                    pnl.BackgroundImage = imgObjects.Images["cocodrilo"];
                    break;

                case 12:

                    pnl.BackgroundImage = imgObjects.Images["lampara"];
                    break;

                case 13:

                    pnl.BackgroundImage = imgObjects.Images["persona"];
                    break;

            }

            pnl.Tag = type;
        }

        private void btnClipTest_Click(object sender, EventArgs e)
        {
            var data = parseScreen();
            data.Image.Dispose();
            StringBuilder sb = new StringBuilder();

            sb.Append("{ ");

            for (int buc = 0; buc < 116; buc++)
                sb.Append(data.Data[buc].ToString() + ", ");

            sb.Remove(sb.Length - 2, 2);

            sb.Append(" }");

            Clipboard.SetText(sb.ToString());

        }

        int getSide(int x, int y)
        {
            if (x == 0)
                return 2;
            else if (x == 31)
                return 3;
            else if (y == 0)
                return 0;
            else if (y == 11)
                return 1;

            return -1;
        }

        private void btnSaveScreen_Click(object sender, EventArgs e)
        {
            if (lstScreens.Controls.Count > 69 * 2)
            {
                MessageBox.Show("Se ha alcanzado el máximo de pantallas");
                return;
            }

            var result = parseScreen();

            if (result == null)
                return;

            PictureBox pbNew = new PictureBox();
            pbNew.Image = result.Image;
            pbNew.SizeMode = PictureBoxSizeMode.CenterImage;
            pbNew.Width = 256;
            pbNew.Height = 96;
            pbNew.BackColor = Color.LightGray;
            pbNew.Tag = result;
            pbNew.MouseDown += PbNew_MouseDown;
            pbNew.MouseUp += PbNew_MouseUp;

            Label lblNumber = new Label();
            lblNumber.Visible = true;
            lblNumber.Location = Point.Empty;
            lblNumber.AutoSize = true;

            pbNew.Controls.Add(lblNumber);

            lstScreens.Controls.Add(pbNew);

            renumberSequence(lstScreens);

            clearScreen();
        }

        private void PbNew_MouseUp(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                selectedLevel = (sender as PictureBox).Tag as LevelData;
                cmLevel.Show(sender as PictureBox, e.Location);
            }
        }

        private void PbNew_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                var pic = sender as PictureBox;
                pic.DoDragDrop(pic, DragDropEffects.Copy);
            }
        }

        LevelData parseScreen()
        {
            if (cbScreenBG.SelectedItem == null)
            {
                MessageBox.Show("Selecciona color de fondo");
                return null;
            }

            if (cbScreenFG.SelectedItem == null)
            {
                MessageBox.Show("Selecciona color de frente");
                return null;
            }

            if (cbSolidBG.SelectedItem == null)
            {
                MessageBox.Show("Selecciona color de fondo de sólido");
                return null;
            }

            if (cbSolidFG.SelectedItem == null)
            {
                MessageBox.Show("Selecciona color de frente de sólido");
                return null;
            }

            if (cbSolidPT.SelectedItem == null)
            {
                MessageBox.Show("Selecciona patrón de sólido");
                return null;
            }

            int exit = -1;
            int enter = -1;
            int tmpValue;

            bool hasPerson = false;

            List<byte> scrBuffer = new List<byte>();
            //Bitmap bmp = new Bitmap(128, 48, System.Drawing.Imaging.PixelFormat.Format32bppPArgb);

            List<byte> enems = new List<byte>();
            List<Point> enters = new List<Point>();
            List<Point> exits = new List<Point>();

            int[,] map = new int[32, 12];

            for (int y = 0; y < 12; y++)
            {
                for (int x = 0; x < 32; x += 4)
                {
                    byte value = 0;

                    for (int xx = 0; xx < 4; xx++)
                    {
                        int trueX = x + xx;

                        var pnl = this.Controls.Find($"{trueX}_{y}", false).First() as Panel;
                        tmpValue = (byte)(int)pnl.Tag;
                        map[trueX, y] = tmpValue;

                        //setColor(tmpValue, bmp, trueX, y);

                        if (tmpValue > 4)
                        {
                            AddEnemy(enems, tmpValue, trueX, y);
                            if (tmpValue == 13)
                                hasPerson = true;
                            else if(tmpValue == 10)
                                value = (byte)(value | (1 << (xx * 2)));

                        }
                        else if (tmpValue == 4)
                        {
                            exit = getSide(trueX, y);
                            exits.Add(new Point(trueX, y));
                        }
                        else if (tmpValue == 0)
                        {
                            if (enter == -1)
                                enter = getSide(trueX, y);

                            if (trueX == 0 || trueX == 31 || y == 0 || y == 11)
                                enters.Add(new Point(trueX, y));
                        }
                        else
                            value = (byte)(value | (tmpValue << (xx * 2)));

                    }

                    scrBuffer.Add(value);
                }
            }
            
            if (enter == -1)
            {
                MessageBox.Show("No hay entrada");
                return null;
            }

            if (hasPerson)
            {
                if (enter == 0)
                    exit = 1;
                else if (enter == 1)
                    exit = 0;
                else if (enter == 2)
                    exit = 3;
                else
                    exit = 2;
            }

            if (exit == -1)
            {
                MessageBox.Show("No hay salida");
                return null;
            }

            if (enter == exit)
            {
                MessageBox.Show("La entrada y la salida no pueden estar en el mismo lado");
                return null;
            }

            if (enems.Count > 18)
            {
                MessageBox.Show("No pueden haber más de 6 objetos/enemigos");
                return null;
            }

            enems.AddRange(Enumerable.Repeat((byte)0, 18 - enems.Count));
            scrBuffer.AddRange(enems);

            int bgColor = int.Parse(cbScreenBG.SelectedItem.ToString().Split('-')[0]);
            int fgColor = int.Parse(cbScreenFG.SelectedItem.ToString().Split('-')[0]);
            int solidBgColor = int.Parse(cbSolidBG.SelectedItem.ToString().Split('-')[0]);
            int solidFgColor = int.Parse(cbSolidFG.SelectedItem.ToString().Split('-')[0]);
            int pattern = int.Parse(cbSolidPT.SelectedItem.ToString().Split('-')[0]);

            int info = bgColor |
                (fgColor << 3) |
                (exit << 6);

            scrBuffer.Add((byte)info); //screen info

            info = solidBgColor |
                (solidFgColor << 3) |
                (pattern << 6);

            scrBuffer.Add((byte)info); //solid info

            LevelData data = new LevelData
            {
                Image = getMapImage(map, bgColor, solidFgColor, solidBgColor, pattern),
                Data = scrBuffer.ToArray(),
                Exits = exits.ToArray(),
                Entrances = enters.ToArray(),
                Map = map,
                FGColor = cbScreenFG.SelectedIndex,
                BGColor = cbScreenBG.SelectedIndex,
                SolidFGColor = cbSolidFG.SelectedIndex,
                SolidBGColor = cbSolidBG.SelectedIndex,
                SolidPattern = cbSolidPT.SelectedIndex
            };

            return data;
        }

        private void AddEnemy(List<byte> enems, int tmpValue, int x, int y)
        {
            enems.Add((byte)(tmpValue - 4));
            enems.Add((byte)(x + 1));
            enems.Add((byte)(y + 1));
        }

        private Bitmap getMapImage(int[,] map, int BgColor, int SolidFgColor, int SolidBgColor, int SolidPattern)
        {
            Bitmap bmp = new Bitmap(256, 96, System.Drawing.Imaging.PixelFormat.Format24bppRgb);
            Graphics g = Graphics.FromImage(bmp);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.NearestNeighbor;
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.None;

            Brush emptyBrush = GetZXBrush(BgColor);
            Brush solidBrush = GetZXBrush(SolidFgColor);
            Bitmap solidPattern = GetPattern(SolidBgColor, SolidPattern);
            for (int y = 0; y < 12; y++)
            {
                for (int x = 0; x < 32; x++)
                {
                    switch (map[x,y])
                    {
                        case 0:

                            g.FillRectangle(emptyBrush, x * 8, y * 8, 8, 8);
                            break;

                        case 1:

                            g.FillRectangle(solidBrush, x * 8, y * 8, 8, 8);
                            if(solidPattern != null)
                                g.DrawImage(solidPattern, new Rectangle(x * 8, y * 8, 8, 8), new Rectangle(0, 0, 32, 32), GraphicsUnit.Pixel);
                            break;

                        case 2:

                            g.FillRectangle(Brushes.Blue, x * 8, y * 8, 8, 8);
                            if (solidPattern != null)
                                g.DrawImage(solidPattern, new Rectangle(x * 8, y * 8, 8, 8), new Rectangle(0, 0, 32, 32), GraphicsUnit.Pixel);
                            break;

                        case 3:

                            g.FillRectangle(Brushes.LightGray, x * 8, y * 8, 8, 8);
                            break;

                        case 4:

                            g.FillRectangle(Brushes.Yellow, x * 8, y * 8, 8, 8);
                            break;

                        case 5:

                            g.DrawImage(imgObjects.Images["murcielago"], new Rectangle(x * 8, y * 8, 8, 8), new Rectangle(0, 0, 32, 32), GraphicsUnit.Pixel);
                            break;

                        case 6:

                            g.DrawImage(imgObjects.Images["aranya"], new Rectangle(x * 8, y * 8, 8, 8), new Rectangle(0, 0, 32, 32), GraphicsUnit.Pixel);
                            break;

                        case 7:

                            g.DrawImage(imgObjects.Images["mosca"], new Rectangle(x * 8, y * 8, 8, 8), new Rectangle(0, 0, 32, 32), GraphicsUnit.Pixel);
                            break;

                        case 8:

                            g.DrawImage(imgObjects.Images["bicho"], new Rectangle(x * 8, y * 8, 8, 8), new Rectangle(0, 0, 32, 32), GraphicsUnit.Pixel);
                            break;

                        case 9:

                            g.DrawImage(imgObjects.Images["cangrejo"], new Rectangle(x * 8, y * 8, 8, 8), new Rectangle(0, 0, 32, 32), GraphicsUnit.Pixel);
                            break;

                        case 10:

                            g.DrawImage(imgObjects.Images["serpiente"], new Rectangle(x * 8, y * 8, 8, 8), new Rectangle(0, 0, 32, 32), GraphicsUnit.Pixel);
                            break;

                        case 11:

                            g.DrawImage(imgObjects.Images["cocodrilo"], new Rectangle(x * 8, y * 8, 8, 8), new Rectangle(0, 0, 32, 32), GraphicsUnit.Pixel);
                            break;

                        case 12:

                            g.DrawImage(imgObjects.Images["lampara"], new Rectangle(x * 8, y * 8, 8, 8), new Rectangle(0, 0, 32, 32), GraphicsUnit.Pixel);
                            break;

                        case 13:

                            g.DrawImage(imgObjects.Images["persona"], new Rectangle(x * 8, y * 8, 8, 8), new Rectangle(0, 0, 24, 24), GraphicsUnit.Pixel);
                            break;
                    }
                }
            }

            g.Dispose();

            return bmp;
        }

        private Bitmap GetPattern(int solidBgColor, int solidPattern)
        {
            if (solidPattern == 0)
                return null;

            if (solidPattern == 0)
                return null;

            Bitmap bmp = imgObjects.Images["patron" + solidPattern] as Bitmap;

            switch (solidBgColor)
            {
                case 1:

                    return bmp.ColorTint(0, 0, 192 / 255f);

                case 2:

                    return bmp.ColorTint(192 / 255f, 0, 0);

                case 3:

                    return bmp.ColorTint(192 / 255f, 0, 192 / 255f);

                case 4:

                    return bmp.ColorTint(0, 192 / 255f, 0);

                case 5:

                    return bmp.ColorTint(0, 192 / 255f, 192 / 255f);

                case 6:

                    return bmp.ColorTint(192 / 255f, 192 / 255f, 0);

                case 7:

                    return bmp.ColorTint(192 / 255f, 192 / 255f, 192 / 255f);
            }

            return bmp;
        }

        private Brush GetZXBrush(int bgColor)
        {
            switch (bgColor)
            {
                case 1:

                    return new SolidBrush(Color.FromArgb(0, 0, 192));

                case 2:

                    return new SolidBrush(Color.FromArgb(192, 0, 0));

                case 3:

                    return new SolidBrush(Color.FromArgb(192, 0, 192));

                case 4:

                    return new SolidBrush(Color.FromArgb(0, 192, 0));

                case 5:

                    return new SolidBrush(Color.FromArgb(0, 192, 192));

                case 6:

                    return new SolidBrush(Color.FromArgb(192, 192, 0));

                case 7:

                    return new SolidBrush(Color.FromArgb(192, 192, 192));
            }

            return Brushes.Black;
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            clearScreen();
        }

        void clearScreen()
        {
            for (int y = 0; y < 12; y++)
            {
                for (int x = 0; x < 32; x++)
                {
                    var pnl = this.Controls.Find($"{x}_{y}", false).First() as Panel;
                    pnl.BackColor = Color.Black;
                    pnl.Tag = 0;
                    pnl.BackgroundImage = null;
                }
            }
        }

        private void lstOrder_DragEnter(object sender, DragEventArgs e)
        {
            e.Effect = DragDropEffects.Copy;
        }

        private void lstOrder_DragDrop(object sender, DragEventArgs e)
        {
            if (lstOrder.Controls.Count > 298 * 2)
            {
                MessageBox.Show("Se ha alcanzado el máximo de niveles");
                return;
            }

            var pb = e.Data.GetData(typeof(PictureBox)) as PictureBox;

            if (pb == null)
                return;

            LevelData ld = pb.Tag as LevelData;

            if (ld == null)
                return;

            var control = lstOrder.GetChildAtPoint(lstOrder.PointToClient(new Point(e.X, e.Y))) as PictureBox;

            PictureBox pbNew = new PictureBox();
            pbNew.Image = pb.Image;
            pbNew.SizeMode = PictureBoxSizeMode.CenterImage;
            pbNew.Width = 256;
            pbNew.Height = 96;
            pbNew.BackColor = Color.LightGray;
            pbNew.Tag = pb.Tag;
            pbNew.Margin = new Padding(0, 5, 32, 0);
            pbNew.MouseUp += PbNewMap_MouseUp;

            Label lblNumber = new Label();
            lblNumber.Visible = true;
            lblNumber.Location = Point.Empty;
            lblNumber.AutoSize = true;

            pbNew.Controls.Add(lblNumber);

            if (control == null)
            {
                if (lstOrder.Controls.Count == 0)
                    lstOrder.Controls.Add(pbNew);
                else
                {
                    var tmpPb = lstOrder.Controls.Cast<PictureBox>().Last();

                    var lvPrev = tmpPb.Tag as LevelData;

                    if (lvPrev.Exits.Length == 0)
                        lstOrder.Controls.Add(pbNew);
                    else
                    {

                        if (!checkExitMatch(lvPrev, ld))
                        {
                            MessageBox.Show("Las entradas no coinciden con las salidas");
                            pbNew.Image = null;
                            pbNew.Dispose();
                            return;
                        }

                        lstOrder.Controls.Add(pbNew);
                    }
                }
            }
            else
            {
                List<PictureBox> pbs = lstOrder.Controls.OfType<PictureBox>().ToList();

                var idx = pbs.IndexOf(control);

                if (idx < 0)
                {
                    pbNew.Image = null;
                    pbNew.Dispose();
                    return;
                }

                if (idx == 0)
                {
                    var tmpPbNext = pbs[idx];
                    if (!checkExitMatch(ld, tmpPbNext.Tag as LevelData))
                    {
                        MessageBox.Show("Las entradas no coinciden con las salidas");
                        pbNew.Image = null;
                        pbNew.Dispose();
                        return;
                    }

                }
                else
                {

                    if (!checkExitMatch(ld, pbs[idx].Tag as LevelData))
                    {
                        MessageBox.Show("Las entradas no coinciden con las salidas");
                        pbNew.Image = null;
                        pbNew.Dispose();
                        return;
                    }


                    var ldPrev = pbs[idx - 1].Tag as LevelData;


                    if (!checkExitMatch(ldPrev, ld))
                    {
                        MessageBox.Show("Las entradas no coinciden con las salidas");
                        pbNew.Image = null;
                        pbNew.Dispose();
                        return;
                    }

                }

                pbs.Insert(idx, pbNew);
                lstOrder.Controls.Clear();
                lstOrder.Controls.AddRange(pbs.ToArray());
            }

            renumberSequence(lstOrder);
        }

        private void renumberSequence(Control Parent)
        {
            int cnt = 0;

            foreach (Control pb in Parent.Controls)
            {
                var lbl = pb.Controls[0] as Label;
                lbl.Text = cnt.ToString();
                cnt++;
            }
        }

        private void PbNewMap_MouseUp(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                selectedPb = sender as PictureBox;
                cmMap.Show(selectedPb, e.Location);
            }
        }

        bool checkExitMatch(LevelData Exits, LevelData Entrances)
        {
            if (Exits.Exits.Length == 0)
                return true;

            if (Exits.Exits.Length != Entrances.Entrances.Length)
                return false;

            foreach (var exit in Exits.Exits)
            {
                Point checkPt = new Point();

                if (exit.X == 0)
                    checkPt.X = 31;
                else if (exit.X == 31)
                    checkPt.X = 0;
                else
                    checkPt.X = exit.X;

                if (exit.Y == 0)
                    checkPt.Y = 11;
                else if (exit.Y == 11)
                    checkPt.Y = 0;
                else
                    checkPt.Y = exit.Y;

                if (!Entrances.Entrances.Contains(checkPt))
                    return false;
            }

            return true;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                using (SaveFileDialog sf = new SaveFileDialog())
                {
                    sf.Filter = "Archivo de niveles de HERO | *.hmp";

                    if (sf.ShowDialog() != DialogResult.OK)
                        return;

                    List<LevelData> lvls = new List<LevelData>();
                    List<Guid> ids = new List<Guid>();

                    foreach (PictureBox item in lstScreens.Controls)
                    {
                        lvls.Add(item.Tag as LevelData);
                    }

                    foreach (PictureBox item in lstOrder.Controls)
                    {
                        ids.Add((item.Tag as LevelData).ID);
                    }

                    HeroMap map = new HeroMap { Levels = lvls.ToArray(), MapOrder = ids.ToArray() };

                    File.WriteAllText(sf.FileName, JsonConvert.SerializeObject(map));

                    MessageBox.Show("Salvado correctamente");
                }
            }
            catch { MessageBox.Show("Error salvando..."); }
        }

        private void cargarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (selectedLevel == null)
                return;

            for (int x = 0; x < 32; x++)
            {
                for (int y = 0; y < 12; y++)
                {
                    var panel = this.Controls.Find($"{x}_{y}", false).First() as Panel;
                    SetPanelType(selectedLevel.Map[x, y], panel);
                }
            }

            cbScreenFG.SelectedIndex = selectedLevel.FGColor;
            cbScreenBG.SelectedIndex = selectedLevel.BGColor;
            cbSolidFG.SelectedIndex = selectedLevel.SolidFGColor;
            cbSolidBG.SelectedIndex = selectedLevel.SolidBGColor;
            cbSolidPT.SelectedIndex = selectedLevel.SolidPattern;
        }

        private void actualizarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (selectedLevel == null)
                return;

            var lvl = parseScreen();

            if (lvl == null)
                return;

            var used = lstOrder.Controls.Cast<PictureBox>().Where(pb => (pb.Tag as LevelData).ID == selectedLevel.ID).FirstOrDefault();

            if (used != null)
            {
                if (selectedLevel.Exits.Length != lvl.Exits.Length || selectedLevel.Entrances.Length != lvl.Entrances.Length)
                {
                    MessageBox.Show("No se pueden cambiar las entradas/salidas de una pantalla en uso");
                    lvl.Image.Dispose();
                    return;
                }

                foreach (var entr in lvl.Entrances)
                {
                    if (!selectedLevel.Entrances.Contains(entr))
                    {
                        MessageBox.Show("No se pueden cambiar las entradas/salidas de una pantalla en uso");
                        lvl.Image.Dispose();
                        return;
                    }
                }

                foreach (var exit in lvl.Exits)
                {
                    if (!selectedLevel.Exits.Contains(exit))
                    {
                        MessageBox.Show("No se pueden cambiar las entradas/salidas de una pantalla en uso");
                        lvl.Image.Dispose();
                        return;
                    }
                }
            }

            var item = lstScreens.Controls.Cast<PictureBox>().Where(pb => (pb.Tag as LevelData).ID == selectedLevel.ID).FirstOrDefault();

            if (item == null)
            {
                lvl.Image.Dispose();
                return;
            }

            item.Tag = lvl;
            item.Image = lvl.Image;

            foreach (var useds in lstOrder.Controls.Cast<PictureBox>().Where(pb => (pb.Tag as LevelData).ID == selectedLevel.ID).ToArray())
            {
                useds.Tag = lvl;
                useds.Image = lvl.Image;
            }
        }

        private void btnBorder_Click(object sender, EventArgs e)
        {
            for (int x = 0; x < 32; x++)
            {
                for (int y = 0; y < 12; y++)
                {

                    if (x == 0 || y == 0 || x == 31 || y == 11)
                    {
                        var pnl = this.Controls.Find($"{x}_{y}", false).First() as Panel;
                        SetPanelType(1, pnl);
                    }
                }
            }
        }

        private void coincidirEntradaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (selectedLevel == null || selectedLevel.Entrances.Length == 0)
                return;

            int xMin = 0;
            int xMax = 32;
            int yMin = 0;
            int yMax = 12;

            if (selectedLevel.Entrances[0].X == 0)
            {
                xMin = 31;
                xMax = 32;
            }
            else if (selectedLevel.Entrances[0].X == 31)
            {
                xMin = 0;
                xMax = 1;
            }
            else if (selectedLevel.Entrances[0].Y == 0)
            {
                yMin = 11;
                yMax = 12;
            }
            else if (selectedLevel.Entrances[0].Y == 11)
            {
                yMin = 0;
                yMax = 1;
            }

            for (int x = xMin; x < xMax; x++)
            {
                for (int y = yMin; y < yMax; y++)
                {
                    Point pt = new Point(x, y);
                    if (pt.X == 0)
                        pt.X = 31;
                    else if (pt.Y == 0)
                        pt.Y = 11;
                    else if (pt.X == 31)
                        pt.X = 0;
                    else if (pt.Y == 11)
                        pt.Y = 0;

                    var pnl = this.Controls.Find($"{x}_{y}", false).First() as Panel;
                    if (selectedLevel.Entrances.Contains(pt))
                        SetPanelType(4, pnl);
                    else
                        SetPanelType(1, pnl);
                }
            }
        }

        private void coincidirSalidaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (selectedLevel == null || selectedLevel.Exits.Length == 0)
                return;

            int xMin = 0;
            int xMax = 32;
            int yMin = 0;
            int yMax = 12;

            if (selectedLevel.Exits[0].X == 0)
            {
                xMin = 31;
                xMax = 32;
            }
            else if (selectedLevel.Exits[0].X == 31)
            {
                xMin = 0;
                xMax = 1;
            }
            else if (selectedLevel.Exits[0].Y == 0)
            {
                yMin = 11;
                yMax = 12;
            }
            else if (selectedLevel.Exits[0].Y == 11)
            {
                yMin = 0;
                yMax = 1;
            }

            for (int x = xMin; x < xMax; x++)
            {
                for (int y = yMin; y < yMax; y++)
                {
                    Point pt = new Point(x, y);
                    if (pt.X == 0)
                        pt.X = 31;
                    else if (pt.Y == 0)
                        pt.Y = 11;
                    else if (pt.X == 31)
                        pt.X = 0;
                    else if (pt.Y == 11)
                        pt.Y = 0;

                    var pnl = this.Controls.Find($"{x}_{y}", false).First() as Panel;
                    if (selectedLevel.Exits.Contains(pt))
                        SetPanelType(0, pnl);
                    else
                        SetPanelType(1, pnl);
                }
            }
        }

        private void eliminarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (selectedLevel == null)
                return;

            var used = lstOrder.Controls.Cast<PictureBox>().Where(pb => (pb.Tag as LevelData).ID == selectedLevel.ID).FirstOrDefault();

            if (used != null)
            {
                if (MessageBox.Show("Atención, la pantalla está en uso, eliminarla puede crear incongruencias de entradas/salidas, ¿quieres continuar?", "En uso", MessageBoxButtons.OKCancel) == DialogResult.Cancel)
                    return;
            }

            var pbScreen = lstScreens.Controls.Cast<PictureBox>().Where(pb => (pb.Tag as LevelData).ID == selectedLevel.ID).FirstOrDefault();
            lstScreens.Controls.Remove(pbScreen);
            pbScreen.Dispose();

            foreach (var useds in lstOrder.Controls.Cast<PictureBox>().Where(pb => (pb.Tag as LevelData).ID == selectedLevel.ID).ToArray())
            {
                lstOrder.Controls.Remove(useds);
                useds.Dispose();
            }

            selectedLevel.Image.Dispose();

            renumberSequence(lstScreens);
        }

        private void eliminarToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            if (selectedPb == null)
                return;

            var items = lstOrder.Controls.Cast<PictureBox>().ToList();

            var lastItem = items.Last();

            if (!selectedPb.Equals(lastItem))
            {
                if (MessageBox.Show("Atención, eliminar la pantalla puede crear incongruencias de entradas/salidas, ¿quieres continuar?", "Conectada", MessageBoxButtons.OKCancel) == DialogResult.Cancel)
                    return;
            }

            lstOrder.Controls.Remove(selectedPb);
            selectedPb.Dispose();

            renumberSequence(lstOrder);
        }

        private void btnNew_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("¿Seguro que deseas crear un nuevo conjunto de mapa?", "Confirmar", MessageBoxButtons.OKCancel) == DialogResult.Cancel)
                return;

            newMap();
        }

        private void newMap()
        {
            Control[] tmpArr = lstScreens.Controls.Cast<Control>().ToArray();
            foreach (var ctl in tmpArr)
            {
                ctl.Dispose();
                lstScreens.Controls.Remove(ctl);
                var lv = ctl.Tag as LevelData;
                lv.Image.Dispose();
            }

            tmpArr = lstOrder.Controls.Cast<Control>().ToArray();
            foreach (var ctl in tmpArr)
            {   
                var lv = ctl.Tag as LevelData;
                lv.Image.Dispose();
                ctl.Dispose();
                lstOrder.Controls.Remove(ctl);
            }

            for (int x = 0; x < 32; x++)
            {
                for (int y = 0; y < 12; y++)
                {
                    var pnl = this.Controls.Find($"{x}_{y}", false).First() as Panel;
                    SetPanelType(0, pnl);
                }
            }
        }

        private void btnOpen_Click(object sender, EventArgs e)
        {

            using (OpenFileDialog ofd = new OpenFileDialog())
            {
                ofd.Filter = "Archivo de niveles de HERO | *.hmp";

                if (ofd.ShowDialog() != DialogResult.OK)
                    return;

                clearScreen();

                string data = File.ReadAllText(ofd.FileName);
                var map = JsonConvert.DeserializeObject<HeroMap>(data);
                
                lstOrder.SuspendLayout();
                lstScreens.SuspendLayout();

                for (int buc = 0; buc < map.Levels.Length; buc++)
                {
                    var lvl = map.Levels[buc];
                    lvl.Image = getMapImage(lvl.Map, lvl.BGColor, lvl.SolidFGColor, lvl.SolidBGColor, lvl.SolidPattern);
                    
                    PictureBox pbNew = new PictureBox();
                    pbNew.Image = lvl.Image;
                    pbNew.SizeMode = PictureBoxSizeMode.CenterImage;
                    pbNew.Width = 256;
                    pbNew.Height = 96;
                    pbNew.BackColor = Color.LightGray;
                    pbNew.Tag = lvl;
                    pbNew.MouseDown += PbNew_MouseDown;
                    pbNew.MouseUp += PbNew_MouseUp;

                    Label lblNumber = new Label();
                    lblNumber.Visible = true;
                    lblNumber.Location = Point.Empty;
                    lblNumber.AutoSize = true;

                    pbNew.Controls.Add(lblNumber);

                    lstScreens.Controls.Add(pbNew);
                }

                for (int buc = 0; buc < map.MapOrder.Length; buc++)
                {
                    var lvl = map.Levels.FirstOrDefault(lv => lv.ID == map.MapOrder[buc]);

                    PictureBox pbNew = new PictureBox();
                    pbNew.Image = lvl.Image;
                    pbNew.SizeMode = PictureBoxSizeMode.CenterImage;
                    pbNew.Width = 256;
                    pbNew.Height = 96;
                    pbNew.BackColor = Color.LightGray;
                    pbNew.Tag = lvl;
                    pbNew.Margin = new Padding(0, 5, 32, 0);
                    pbNew.MouseUp += PbNewMap_MouseUp;

                    Label lblNumber = new Label();
                    lblNumber.Visible = true;
                    lblNumber.Location = Point.Empty;
                    lblNumber.AutoSize = true;

                    pbNew.Controls.Add(lblNumber);

                    lstOrder.Controls.Add(pbNew);
                }

                renumberSequence(lstOrder);
                renumberSequence(lstScreens);

                lstOrder.ResumeLayout();
                lstScreens.ResumeLayout();

                //Correct flowlayoutpanel bug, cheese
                lstOrder.Refresh();
                lstOrder.ScrollControlIntoView(lstOrder.Controls.Cast<Control>().Last());
                Panel pnl = new Panel();
                pnl.Size = Size.Empty;
                lstOrder.Controls.Add(pnl);
                lstOrder.Refresh();
                lstOrder.Controls.Remove(pnl);
                lstOrder.ScrollControlIntoView(lstOrder.Controls.Cast<Control>().First());
            }
            
        }

        private void btnExport_Click(object sender, EventArgs e)
        {
            int exportIndex = 0;

            using (exportForm eFrm = new exportForm())
            {
                if (eFrm.ShowDialog() != DialogResult.OK)
                    return;

                exportIndex = eFrm.ExportIndex;
            }

            using (SaveFileDialog sf = new SaveFileDialog())
            {

                sf.Filter = "Archivode cinta | *.tap";

                if (sf.ShowDialog() != DialogResult.OK)
                    return;

                List<byte> levelBuffer = new List<byte>();
                List<Guid> levelIds = new List<Guid>();
                List<byte> sequenceBuffer = new List<byte>();

                foreach (PictureBox item in lstScreens.Controls)
                {
                    var lvl = item.Tag as LevelData;
                    levelBuffer.AddRange(lvl.Data);
                    levelIds.Add(lvl.ID);
                }

                int cnt = 0;

                foreach (PictureBox item in lstOrder.Controls)
                {
                    if (cnt < exportIndex)
                    {
                        cnt++;
                        continue;
                    }

                    var lvl = item.Tag as LevelData;
                    byte idx = (byte)levelIds.IndexOf(lvl.ID);
                    sequenceBuffer.Add((byte)(idx + 1));
                }

                List<byte> finalBuffer = new List<byte>();
                levelBuffer.AddRange(Enumerable.Repeat((byte)0, 70 * 116 - levelBuffer.Count));
                sequenceBuffer.AddRange(Enumerable.Repeat((byte)0, 300 - sequenceBuffer.Count));
                finalBuffer.AddRange(levelBuffer);
                finalBuffer.AddRange(sequenceBuffer);

                string tmpPath = Path.GetTempPath();
                string tmpFile = Path.Combine(tmpPath, "HEROLVL.bin");
                string tmpFile2 = Path.Combine(tmpPath, "HEROLVL.tap");
                File.WriteAllBytes(tmpFile, finalBuffer.ToArray());
                
                string exeFile = tmpFile + ".exe";

                File.WriteAllBytes(exeFile, BinResources.bin2tap);

                ProcessStartInfo pi = new ProcessStartInfo(exeFile, tmpFile + " -a 24200 -o " + tmpFile2);
                pi.WorkingDirectory = tmpPath;
                Process p = Process.Start(pi);
                p.Start();
                p.WaitForExit();

                try
                {

                    File.Delete(tmpFile);
                    File.Delete(exeFile);
                }
                catch { }

                byte[] data = File.ReadAllBytes(tmpFile2);
                finalBuffer.Clear();
                finalBuffer.AddRange(BinResources.HERO);
                finalBuffer.AddRange(data);

                File.Delete(tmpFile2);

                File.WriteAllBytes(sf.FileName, finalBuffer.ToArray());

                string newFilename = Path.Combine(Path.GetDirectoryName(sf.FileName),
                    Path.GetFileNameWithoutExtension(sf.FileName) + "_with_intro.tap");

                finalBuffer.Clear();
                finalBuffer.AddRange(BinResources.HERO_WITH_INTRO);
                finalBuffer.AddRange(data);

                File.WriteAllBytes(newFilename, finalBuffer.ToArray());

                MessageBox.Show("Mapa exportado");
            }
        }

        private void buscarEntradasCoincidentesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            doSearch(true);
        }

        void doSearch(bool Exits)
        {
            if (selectedLevel == null)
                return;

            List<LevelData> levels = lstScreens.Controls.Cast<PictureBox>().Select(pb => pb.Tag as LevelData).ToList();

            if (matchFrm == null)
            {
                matchFrm = new MatchesForm();
                matchFrm.FormClosed += MatchFrm_FormClosed;
            }

            matchFrm.Show();
            matchFrm.BringToFront();

            matchFrm.ShowMatches(selectedLevel, levels, Exits);
        }

        private void MatchFrm_FormClosed(object sender, FormClosedEventArgs e)
        {
            matchFrm.Dispose();
            matchFrm = null;
        }

        private void buscarSalidasCoincidentesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            doSearch(false);
        }

        private void mostrarPantallasNoUsadasToolStripMenuItem_Click(object sender, EventArgs e)
        {
            List<LevelData> levels = lstScreens.Controls.Cast<PictureBox>().Select(pb => pb.Tag as LevelData).ToList();
            List<LevelData> used = lstOrder.Controls.Cast<PictureBox>().Select(pb => pb.Tag as LevelData).ToList();

            if (matchFrm == null)
            {
                matchFrm = new MatchesForm();
                matchFrm.FormClosed += MatchFrm_FormClosed;
            }

            matchFrm.Show();
            matchFrm.BringToFront();

            matchFrm.ShowNotUsed(levels, used);
        }
    }

    public class HeroMap
    {
        public LevelData[] Levels { get; set; }
        public Guid[] MapOrder { get; set; }
    }

    public class LevelData
    {
        public Guid ID { get; set; } = Guid.NewGuid();
        public byte[] Data { get; set; }
        [JsonIgnore]
        public Bitmap Image { get; set; }
        public Point[] Entrances { get; set; }
        public Point[] Exits { get; set; }
        public int[,] Map { get; set; }
        public int BGColor { get; set; }
        public int FGColor { get; set; }
        public int SolidBGColor { get; set; }
        public int SolidFGColor { get; set; }
        public int SolidPattern { get; set; }
    }

}
