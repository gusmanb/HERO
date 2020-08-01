using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics.PerformanceData;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace EditorPantallas
{
    public partial class MatchesForm : Form
    {
        public MatchesForm()
        {
            InitializeComponent();
        }

        private void MatchesForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            foreach (PictureBox pb in lstMatches.Controls)
            {
                pb.Image = null;
                pb.Tag = null;
                pb.Dispose();
            }

            lstMatches.Controls.Clear();

        }

        public void ShowMatches(LevelData ToMatch, IEnumerable<LevelData> WhereToMatch, bool MatchExits)
        {
            foreach (PictureBox pb in lstMatches.Controls)
            {
                pb.Image = null;
                pb.Tag = null;
                pb.Dispose();
            }

            lstMatches.Controls.Clear();

            List<Point> pointsToMatch = new List<Point>();

            IEnumerable<Point> pointsSource;
            IEnumerable<Point> pointsTarget;

            if (MatchExits)
                pointsSource = ToMatch.Exits;
            else
                pointsSource = ToMatch.Entrances;

            if (pointsSource.Count() == 0)
                return;

            if (pointsSource.First().X == 0)
            {
                foreach (var pt in pointsSource)
                    pointsToMatch.Add(new Point(31, pt.Y));
            }
            else if (pointsSource.First().X == 31)
            {
                foreach (var pt in pointsSource)
                    pointsToMatch.Add(new Point(0, pt.Y));
            }
            else if (pointsSource.First().Y == 0)
            {
                foreach (var pt in pointsSource)
                    pointsToMatch.Add(new Point(pt.X, 11));
            }
            else
            {
                foreach (var pt in pointsSource)
                    pointsToMatch.Add(new Point(pt.X, 0));
            }

            foreach (var test in WhereToMatch)
            {
                if (MatchExits)
                    pointsTarget = test.Entrances;
                else
                    pointsTarget = test.Exits;

                if (pointsToMatch.Count() != pointsTarget.Count())
                    continue;

                bool found = true;

                foreach (var pt in pointsToMatch)
                {
                    if (!pointsTarget.Contains(pt))
                    {
                        found = false;
                        break;
                    }
                }

                if (!found)
                    continue;

                PictureBox pbNew = new PictureBox();
                pbNew.Image = test.Image;
                pbNew.SizeMode = PictureBoxSizeMode.CenterImage;
                pbNew.Width = 256;
                pbNew.Height = 96;
                pbNew.BackColor = Color.LightGray;
                pbNew.Tag = test;
                pbNew.MouseDown += PbNew_MouseDown;
                lstMatches.Controls.Add(pbNew);

            }

        }

        public void ShowNotUsed(List<LevelData> Screens, List<LevelData> Used)
        {

            foreach (PictureBox pb in lstMatches.Controls)
            {
                pb.Image = null;
                pb.Tag = null;
                pb.Dispose();
            }

            lstMatches.Controls.Clear();

            foreach (var test in Screens)
            {
                if (Used.Where(lv => lv.ID == test.ID).Any())
                    continue;

                PictureBox pbNew = new PictureBox();
                pbNew.Image = test.Image;
                pbNew.SizeMode = PictureBoxSizeMode.CenterImage;
                pbNew.Width = 256;
                pbNew.Height = 96;
                pbNew.BackColor = Color.LightGray;
                pbNew.Tag = test;
                pbNew.MouseDown += PbNew_MouseDown;
                lstMatches.Controls.Add(pbNew);

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
    }
}
