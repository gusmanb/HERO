namespace EditorPantallas
{
    partial class MainForm
    {
        /// <summary>
        /// Variable del diseñador necesaria.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén usando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben desechar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido de este método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            this.tsMain = new System.Windows.Forms.ToolStrip();
            this.btnNew = new System.Windows.Forms.ToolStripButton();
            this.btnOpen = new System.Windows.Forms.ToolStripButton();
            this.btnSave = new System.Windows.Forms.ToolStripButton();
            this.btnExport = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.btnBorder = new System.Windows.Forms.ToolStripButton();
            this.btnClear = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator5 = new System.Windows.Forms.ToolStripSeparator();
            this.btnClipTest = new System.Windows.Forms.ToolStripButton();
            this.btnSaveScreen = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripLabel1 = new System.Windows.Forms.ToolStripLabel();
            this.cbType = new System.Windows.Forms.ToolStripComboBox();
            this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripLabel2 = new System.Windows.Forms.ToolStripLabel();
            this.toolStripLabel6 = new System.Windows.Forms.ToolStripLabel();
            this.cbScreenFG = new System.Windows.Forms.ToolStripComboBox();
            this.toolStripLabel3 = new System.Windows.Forms.ToolStripLabel();
            this.cbScreenBG = new System.Windows.Forms.ToolStripComboBox();
            this.toolStripSeparator4 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripLabel4 = new System.Windows.Forms.ToolStripLabel();
            this.toolStripLabel7 = new System.Windows.Forms.ToolStripLabel();
            this.cbSolidFG = new System.Windows.Forms.ToolStripComboBox();
            this.toolStripLabel5 = new System.Windows.Forms.ToolStripLabel();
            this.cbSolidBG = new System.Windows.Forms.ToolStripComboBox();
            this.toolStripLabel8 = new System.Windows.Forms.ToolStripLabel();
            this.cbSolidPT = new System.Windows.Forms.ToolStripComboBox();
            this.lstScreens = new System.Windows.Forms.FlowLayoutPanel();
            this.lstOrder = new System.Windows.Forms.FlowLayoutPanel();
            this.imgObjects = new System.Windows.Forms.ImageList(this.components);
            this.cmLevel = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.cargarToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.actualizarToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.eliminarToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripSeparator();
            this.coincidirEntradaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.coincidirSalidaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem2 = new System.Windows.Forms.ToolStripSeparator();
            this.buscarEntradasCoincidentesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.buscarSalidasCoincidentesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem3 = new System.Windows.Forms.ToolStripSeparator();
            this.mostrarPantallasNoUsadasToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.cmMap = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.eliminarToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.tsMain.SuspendLayout();
            this.cmLevel.SuspendLayout();
            this.cmMap.SuspendLayout();
            this.SuspendLayout();
            // 
            // tsMain
            // 
            this.tsMain.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.btnNew,
            this.btnOpen,
            this.btnSave,
            this.btnExport,
            this.toolStripSeparator1,
            this.btnBorder,
            this.btnClear,
            this.toolStripSeparator5,
            this.btnClipTest,
            this.btnSaveScreen,
            this.toolStripSeparator2,
            this.toolStripLabel1,
            this.cbType,
            this.toolStripSeparator3,
            this.toolStripLabel2,
            this.toolStripLabel6,
            this.cbScreenFG,
            this.toolStripLabel3,
            this.cbScreenBG,
            this.toolStripSeparator4,
            this.toolStripLabel4,
            this.toolStripLabel7,
            this.cbSolidFG,
            this.toolStripLabel5,
            this.cbSolidBG,
            this.toolStripLabel8,
            this.cbSolidPT});
            this.tsMain.Location = new System.Drawing.Point(0, 0);
            this.tsMain.Name = "tsMain";
            this.tsMain.Size = new System.Drawing.Size(1161, 25);
            this.tsMain.TabIndex = 0;
            this.tsMain.Text = "toolStrip1";
            // 
            // btnNew
            // 
            this.btnNew.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnNew.Image = ((System.Drawing.Image)(resources.GetObject("btnNew.Image")));
            this.btnNew.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnNew.Name = "btnNew";
            this.btnNew.Size = new System.Drawing.Size(23, 22);
            this.btnNew.Text = "toolStripButton2";
            this.btnNew.ToolTipText = "Nuevo";
            this.btnNew.Click += new System.EventHandler(this.btnNew_Click);
            // 
            // btnOpen
            // 
            this.btnOpen.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnOpen.Image = ((System.Drawing.Image)(resources.GetObject("btnOpen.Image")));
            this.btnOpen.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnOpen.Name = "btnOpen";
            this.btnOpen.Size = new System.Drawing.Size(23, 22);
            this.btnOpen.Text = "toolStripButton3";
            this.btnOpen.ToolTipText = "Abrir";
            this.btnOpen.Click += new System.EventHandler(this.btnOpen_Click);
            // 
            // btnSave
            // 
            this.btnSave.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnSave.Image = ((System.Drawing.Image)(resources.GetObject("btnSave.Image")));
            this.btnSave.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(23, 22);
            this.btnSave.Text = "toolStripButton1";
            this.btnSave.ToolTipText = "Guardar";
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // btnExport
            // 
            this.btnExport.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnExport.Image = ((System.Drawing.Image)(resources.GetObject("btnExport.Image")));
            this.btnExport.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnExport.Name = "btnExport";
            this.btnExport.Size = new System.Drawing.Size(23, 22);
            this.btnExport.Text = "toolStripButton1";
            this.btnExport.ToolTipText = "Exportar";
            this.btnExport.Click += new System.EventHandler(this.btnExport_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // btnBorder
            // 
            this.btnBorder.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnBorder.Image = ((System.Drawing.Image)(resources.GetObject("btnBorder.Image")));
            this.btnBorder.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnBorder.Name = "btnBorder";
            this.btnBorder.Size = new System.Drawing.Size(23, 22);
            this.btnBorder.Text = "toolStripButton1";
            this.btnBorder.ToolTipText = "Borde";
            this.btnBorder.Click += new System.EventHandler(this.btnBorder_Click);
            // 
            // btnClear
            // 
            this.btnClear.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnClear.Image = ((System.Drawing.Image)(resources.GetObject("btnClear.Image")));
            this.btnClear.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(23, 22);
            this.btnClear.Text = "toolStripButton7";
            this.btnClear.ToolTipText = "Limpiar";
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // toolStripSeparator5
            // 
            this.toolStripSeparator5.Name = "toolStripSeparator5";
            this.toolStripSeparator5.Size = new System.Drawing.Size(6, 25);
            // 
            // btnClipTest
            // 
            this.btnClipTest.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnClipTest.Image = ((System.Drawing.Image)(resources.GetObject("btnClipTest.Image")));
            this.btnClipTest.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnClipTest.Name = "btnClipTest";
            this.btnClipTest.Size = new System.Drawing.Size(23, 22);
            this.btnClipTest.Text = "toolStripButton8";
            this.btnClipTest.ToolTipText = "Copiar a portapapeles";
            this.btnClipTest.Click += new System.EventHandler(this.btnClipTest_Click);
            // 
            // btnSaveScreen
            // 
            this.btnSaveScreen.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnSaveScreen.Image = ((System.Drawing.Image)(resources.GetObject("btnSaveScreen.Image")));
            this.btnSaveScreen.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnSaveScreen.Name = "btnSaveScreen";
            this.btnSaveScreen.Size = new System.Drawing.Size(23, 22);
            this.btnSaveScreen.Text = "toolStripButton6";
            this.btnSaveScreen.ToolTipText = "Guardar nivel";
            this.btnSaveScreen.Click += new System.EventHandler(this.btnSaveScreen_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(6, 25);
            // 
            // toolStripLabel1
            // 
            this.toolStripLabel1.Name = "toolStripLabel1";
            this.toolStripLabel1.Size = new System.Drawing.Size(57, 22);
            this.toolStripLabel1.Text = "Elemento";
            // 
            // cbType
            // 
            this.cbType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbType.DropDownWidth = 121;
            this.cbType.Items.AddRange(new object[] {
            "0 - Vacío",
            "1 - Sólido",
            "2 - Lava/agua",
            "3 - Muro",
            "4 - Salida",
            "5 - Murcielago",
            "6 - Araña",
            "7 - Mosca",
            "8 - Cucaracha",
            "9 - Cangrejo",
            "10 - Serpiente",
            "11 - Cocodrilo",
            "12 - Lampara",
            "13 - Persona"});
            this.cbType.Name = "cbType";
            this.cbType.Size = new System.Drawing.Size(100, 25);
            // 
            // toolStripSeparator3
            // 
            this.toolStripSeparator3.Name = "toolStripSeparator3";
            this.toolStripSeparator3.Size = new System.Drawing.Size(6, 25);
            // 
            // toolStripLabel2
            // 
            this.toolStripLabel2.Name = "toolStripLabel2";
            this.toolStripLabel2.Size = new System.Drawing.Size(49, 22);
            this.toolStripLabel2.Text = "Pantalla";
            // 
            // toolStripLabel6
            // 
            this.toolStripLabel6.Name = "toolStripLabel6";
            this.toolStripLabel6.Size = new System.Drawing.Size(21, 22);
            this.toolStripLabel6.Text = "FG";
            // 
            // cbScreenFG
            // 
            this.cbScreenFG.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbScreenFG.Items.AddRange(new object[] {
            "0 - Negro",
            "1 - Azul",
            "2 - Rojo",
            "3 - Fuxia",
            "4 - Verde",
            "5 - Cian",
            "6 - Amarillo",
            "7 - Blanco"});
            this.cbScreenFG.Name = "cbScreenFG";
            this.cbScreenFG.Size = new System.Drawing.Size(90, 25);
            // 
            // toolStripLabel3
            // 
            this.toolStripLabel3.Name = "toolStripLabel3";
            this.toolStripLabel3.Size = new System.Drawing.Size(22, 22);
            this.toolStripLabel3.Text = "BG";
            // 
            // cbScreenBG
            // 
            this.cbScreenBG.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbScreenBG.Items.AddRange(new object[] {
            "0 - Negro",
            "1 - Azul",
            "2 - Rojo",
            "3 - Fuxia",
            "4 - Verde",
            "5 - Cian",
            "6 - Amarillo",
            "7 - Blanco"});
            this.cbScreenBG.Name = "cbScreenBG";
            this.cbScreenBG.Size = new System.Drawing.Size(90, 25);
            // 
            // toolStripSeparator4
            // 
            this.toolStripSeparator4.Name = "toolStripSeparator4";
            this.toolStripSeparator4.Size = new System.Drawing.Size(6, 25);
            // 
            // toolStripLabel4
            // 
            this.toolStripLabel4.Name = "toolStripLabel4";
            this.toolStripLabel4.Size = new System.Drawing.Size(40, 22);
            this.toolStripLabel4.Text = "Sólido";
            // 
            // toolStripLabel7
            // 
            this.toolStripLabel7.Name = "toolStripLabel7";
            this.toolStripLabel7.Size = new System.Drawing.Size(21, 22);
            this.toolStripLabel7.Text = "FG";
            // 
            // cbSolidFG
            // 
            this.cbSolidFG.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbSolidFG.Items.AddRange(new object[] {
            "0 - Negro",
            "1 - Azul",
            "2 - Rojo",
            "3 - Fuxia",
            "4 - Verde",
            "5 - Cian",
            "6 - Amarillo",
            "7 - Blanco"});
            this.cbSolidFG.Name = "cbSolidFG";
            this.cbSolidFG.Size = new System.Drawing.Size(90, 25);
            // 
            // toolStripLabel5
            // 
            this.toolStripLabel5.Name = "toolStripLabel5";
            this.toolStripLabel5.Size = new System.Drawing.Size(22, 22);
            this.toolStripLabel5.Text = "BG";
            // 
            // cbSolidBG
            // 
            this.cbSolidBG.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbSolidBG.Items.AddRange(new object[] {
            "0 - Negro",
            "1 - Azul",
            "2 - Rojo",
            "3 - Fuxia",
            "4 - Verde",
            "5 - Cian",
            "6 - Amarillo",
            "7 - Blanco"});
            this.cbSolidBG.Name = "cbSolidBG";
            this.cbSolidBG.Size = new System.Drawing.Size(90, 25);
            // 
            // toolStripLabel8
            // 
            this.toolStripLabel8.Name = "toolStripLabel8";
            this.toolStripLabel8.Size = new System.Drawing.Size(42, 22);
            this.toolStripLabel8.Text = "Patrón";
            // 
            // cbSolidPT
            // 
            this.cbSolidPT.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbSolidPT.Items.AddRange(new object[] {
            "0 - Ninguna",
            "1 - Rocas",
            "2 - Estrellas",
            "3 - Puntos"});
            this.cbSolidPT.Name = "cbSolidPT";
            this.cbSolidPT.Size = new System.Drawing.Size(90, 25);
            // 
            // lstScreens
            // 
            this.lstScreens.AutoScroll = true;
            this.lstScreens.BackColor = System.Drawing.Color.White;
            this.lstScreens.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lstScreens.Dock = System.Windows.Forms.DockStyle.Right;
            this.lstScreens.Location = new System.Drawing.Point(875, 25);
            this.lstScreens.Name = "lstScreens";
            this.lstScreens.Size = new System.Drawing.Size(286, 675);
            this.lstScreens.TabIndex = 1;
            // 
            // lstOrder
            // 
            this.lstOrder.AllowDrop = true;
            this.lstOrder.AutoScroll = true;
            this.lstOrder.BackColor = System.Drawing.Color.White;
            this.lstOrder.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lstOrder.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.lstOrder.FlowDirection = System.Windows.Forms.FlowDirection.TopDown;
            this.lstOrder.Location = new System.Drawing.Point(0, 574);
            this.lstOrder.Name = "lstOrder";
            this.lstOrder.Size = new System.Drawing.Size(875, 126);
            this.lstOrder.TabIndex = 2;
            this.lstOrder.DragDrop += new System.Windows.Forms.DragEventHandler(this.lstOrder_DragDrop);
            this.lstOrder.DragEnter += new System.Windows.Forms.DragEventHandler(this.lstOrder_DragEnter);
            // 
            // imgObjects
            // 
            this.imgObjects.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imgObjects.ImageStream")));
            this.imgObjects.TransparentColor = System.Drawing.Color.Transparent;
            this.imgObjects.Images.SetKeyName(0, "aranya");
            this.imgObjects.Images.SetKeyName(1, "bicho");
            this.imgObjects.Images.SetKeyName(2, "cangrejo");
            this.imgObjects.Images.SetKeyName(3, "cocodrilo");
            this.imgObjects.Images.SetKeyName(4, "lampara");
            this.imgObjects.Images.SetKeyName(5, "mosca");
            this.imgObjects.Images.SetKeyName(6, "murcielago");
            this.imgObjects.Images.SetKeyName(7, "persona");
            this.imgObjects.Images.SetKeyName(8, "serpiente");
            this.imgObjects.Images.SetKeyName(9, "patron1");
            this.imgObjects.Images.SetKeyName(10, "patron2");
            this.imgObjects.Images.SetKeyName(11, "patron3");
            // 
            // cmLevel
            // 
            this.cmLevel.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.cargarToolStripMenuItem,
            this.actualizarToolStripMenuItem,
            this.eliminarToolStripMenuItem,
            this.toolStripMenuItem1,
            this.coincidirEntradaToolStripMenuItem,
            this.coincidirSalidaToolStripMenuItem,
            this.toolStripMenuItem2,
            this.buscarEntradasCoincidentesToolStripMenuItem,
            this.buscarSalidasCoincidentesToolStripMenuItem,
            this.toolStripMenuItem3,
            this.mostrarPantallasNoUsadasToolStripMenuItem});
            this.cmLevel.Name = "cmLevel";
            this.cmLevel.Size = new System.Drawing.Size(228, 198);
            // 
            // cargarToolStripMenuItem
            // 
            this.cargarToolStripMenuItem.Name = "cargarToolStripMenuItem";
            this.cargarToolStripMenuItem.Size = new System.Drawing.Size(227, 22);
            this.cargarToolStripMenuItem.Text = "Cargar";
            this.cargarToolStripMenuItem.Click += new System.EventHandler(this.cargarToolStripMenuItem_Click);
            // 
            // actualizarToolStripMenuItem
            // 
            this.actualizarToolStripMenuItem.Name = "actualizarToolStripMenuItem";
            this.actualizarToolStripMenuItem.Size = new System.Drawing.Size(227, 22);
            this.actualizarToolStripMenuItem.Text = "Actualizar";
            this.actualizarToolStripMenuItem.Click += new System.EventHandler(this.actualizarToolStripMenuItem_Click);
            // 
            // eliminarToolStripMenuItem
            // 
            this.eliminarToolStripMenuItem.Name = "eliminarToolStripMenuItem";
            this.eliminarToolStripMenuItem.Size = new System.Drawing.Size(227, 22);
            this.eliminarToolStripMenuItem.Text = "Eliminar";
            this.eliminarToolStripMenuItem.Click += new System.EventHandler(this.eliminarToolStripMenuItem_Click);
            // 
            // toolStripMenuItem1
            // 
            this.toolStripMenuItem1.Name = "toolStripMenuItem1";
            this.toolStripMenuItem1.Size = new System.Drawing.Size(224, 6);
            // 
            // coincidirEntradaToolStripMenuItem
            // 
            this.coincidirEntradaToolStripMenuItem.Name = "coincidirEntradaToolStripMenuItem";
            this.coincidirEntradaToolStripMenuItem.Size = new System.Drawing.Size(227, 22);
            this.coincidirEntradaToolStripMenuItem.Text = "Coincidir entrada";
            this.coincidirEntradaToolStripMenuItem.Click += new System.EventHandler(this.coincidirEntradaToolStripMenuItem_Click);
            // 
            // coincidirSalidaToolStripMenuItem
            // 
            this.coincidirSalidaToolStripMenuItem.Name = "coincidirSalidaToolStripMenuItem";
            this.coincidirSalidaToolStripMenuItem.Size = new System.Drawing.Size(227, 22);
            this.coincidirSalidaToolStripMenuItem.Text = "Coincidir salida";
            this.coincidirSalidaToolStripMenuItem.Click += new System.EventHandler(this.coincidirSalidaToolStripMenuItem_Click);
            // 
            // toolStripMenuItem2
            // 
            this.toolStripMenuItem2.Name = "toolStripMenuItem2";
            this.toolStripMenuItem2.Size = new System.Drawing.Size(224, 6);
            // 
            // buscarEntradasCoincidentesToolStripMenuItem
            // 
            this.buscarEntradasCoincidentesToolStripMenuItem.Name = "buscarEntradasCoincidentesToolStripMenuItem";
            this.buscarEntradasCoincidentesToolStripMenuItem.Size = new System.Drawing.Size(227, 22);
            this.buscarEntradasCoincidentesToolStripMenuItem.Text = "Buscar entradas coincidentes";
            this.buscarEntradasCoincidentesToolStripMenuItem.Click += new System.EventHandler(this.buscarEntradasCoincidentesToolStripMenuItem_Click);
            // 
            // buscarSalidasCoincidentesToolStripMenuItem
            // 
            this.buscarSalidasCoincidentesToolStripMenuItem.Name = "buscarSalidasCoincidentesToolStripMenuItem";
            this.buscarSalidasCoincidentesToolStripMenuItem.Size = new System.Drawing.Size(227, 22);
            this.buscarSalidasCoincidentesToolStripMenuItem.Text = "Buscar salidas coincidentes";
            this.buscarSalidasCoincidentesToolStripMenuItem.Click += new System.EventHandler(this.buscarSalidasCoincidentesToolStripMenuItem_Click);
            // 
            // toolStripMenuItem3
            // 
            this.toolStripMenuItem3.Name = "toolStripMenuItem3";
            this.toolStripMenuItem3.Size = new System.Drawing.Size(224, 6);
            // 
            // mostrarPantallasNoUsadasToolStripMenuItem
            // 
            this.mostrarPantallasNoUsadasToolStripMenuItem.Name = "mostrarPantallasNoUsadasToolStripMenuItem";
            this.mostrarPantallasNoUsadasToolStripMenuItem.Size = new System.Drawing.Size(227, 22);
            this.mostrarPantallasNoUsadasToolStripMenuItem.Text = "Mostrar pantallas no usadas";
            this.mostrarPantallasNoUsadasToolStripMenuItem.Click += new System.EventHandler(this.mostrarPantallasNoUsadasToolStripMenuItem_Click);
            // 
            // cmMap
            // 
            this.cmMap.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.eliminarToolStripMenuItem1});
            this.cmMap.Name = "cmMap";
            this.cmMap.Size = new System.Drawing.Size(118, 26);
            // 
            // eliminarToolStripMenuItem1
            // 
            this.eliminarToolStripMenuItem1.Name = "eliminarToolStripMenuItem1";
            this.eliminarToolStripMenuItem1.Size = new System.Drawing.Size(117, 22);
            this.eliminarToolStripMenuItem1.Text = "Eliminar";
            this.eliminarToolStripMenuItem1.Click += new System.EventHandler(this.eliminarToolStripMenuItem1_Click);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ControlDark;
            this.ClientSize = new System.Drawing.Size(1161, 700);
            this.Controls.Add(this.lstOrder);
            this.Controls.Add(this.lstScreens);
            this.Controls.Add(this.tsMain);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Editor de niveles de H.E.R.O. Returns";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.tsMain.ResumeLayout(false);
            this.tsMain.PerformLayout();
            this.cmLevel.ResumeLayout(false);
            this.cmMap.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.ToolStrip tsMain;
        private System.Windows.Forms.ToolStripButton btnNew;
        private System.Windows.Forms.ToolStripButton btnOpen;
        private System.Windows.Forms.ToolStripButton btnSave;
        private System.Windows.Forms.ToolStripButton btnClipTest;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripButton btnSaveScreen;
        private System.Windows.Forms.ToolStripButton btnClear;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripComboBox cbType;
        private System.Windows.Forms.ToolStripLabel toolStripLabel1;
        private System.Windows.Forms.ToolStripLabel toolStripLabel2;
        private System.Windows.Forms.ToolStripComboBox cbScreenBG;
        private System.Windows.Forms.FlowLayoutPanel lstScreens;
        private System.Windows.Forms.FlowLayoutPanel lstOrder;
        private System.Windows.Forms.ToolStripLabel toolStripLabel3;
        private System.Windows.Forms.ToolStripComboBox cbScreenFG;
        private System.Windows.Forms.ToolStripLabel toolStripLabel4;
        private System.Windows.Forms.ToolStripComboBox cbSolidFG;
        private System.Windows.Forms.ToolStripLabel toolStripLabel5;
        private System.Windows.Forms.ToolStripComboBox cbSolidBG;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
        private System.Windows.Forms.ToolStripLabel toolStripLabel6;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator4;
        private System.Windows.Forms.ToolStripLabel toolStripLabel7;
        private System.Windows.Forms.ToolStripLabel toolStripLabel8;
        private System.Windows.Forms.ToolStripComboBox cbSolidPT;
        private System.Windows.Forms.ImageList imgObjects;
        private System.Windows.Forms.ContextMenuStrip cmLevel;
        private System.Windows.Forms.ToolStripMenuItem cargarToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem actualizarToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem eliminarToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem coincidirEntradaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem coincidirSalidaToolStripMenuItem;
        private System.Windows.Forms.ToolStripButton btnBorder;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator5;
        private System.Windows.Forms.ContextMenuStrip cmMap;
        private System.Windows.Forms.ToolStripMenuItem eliminarToolStripMenuItem1;
        private System.Windows.Forms.ToolStripButton btnExport;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem2;
        private System.Windows.Forms.ToolStripMenuItem buscarEntradasCoincidentesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem buscarSalidasCoincidentesToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem3;
        private System.Windows.Forms.ToolStripMenuItem mostrarPantallasNoUsadasToolStripMenuItem;
    }
}

