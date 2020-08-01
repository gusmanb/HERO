namespace EditorPantallas
{
    partial class MatchesForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lstMatches = new System.Windows.Forms.FlowLayoutPanel();
            this.SuspendLayout();
            // 
            // lstMatches
            // 
            this.lstMatches.AutoScroll = true;
            this.lstMatches.BackColor = System.Drawing.Color.White;
            this.lstMatches.Dock = System.Windows.Forms.DockStyle.Right;
            this.lstMatches.Location = new System.Drawing.Point(0, 0);
            this.lstMatches.Name = "lstMatches";
            this.lstMatches.Size = new System.Drawing.Size(286, 531);
            this.lstMatches.TabIndex = 2;
            // 
            // MatchesForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(286, 531);
            this.Controls.Add(this.lstMatches);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(302, 4096);
            this.MinimizeBox = false;
            this.MinimumSize = new System.Drawing.Size(302, 39);
            this.Name = "MatchesForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Coincidencias";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.MatchesForm_FormClosing);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.FlowLayoutPanel lstMatches;
    }
}