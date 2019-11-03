namespace WindowsFormsApp1
{
    partial class CidPrinterApp
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(CidPrinterApp));
            this.btnInit = new System.Windows.Forms.Button();
            this.btnPrint = new System.Windows.Forms.Button();
            this.btnCutPartial = new System.Windows.Forms.Button();
            this.btnCutTotal = new System.Windows.Forms.Button();
            this.btnBar = new System.Windows.Forms.Button();
            this.btnReset = new System.Windows.Forms.Button();
            this.btnTest = new System.Windows.Forms.Button();
            this.txtQrCode = new System.Windows.Forms.TextBox();
            this.txtBar = new System.Windows.Forms.TextBox();
            this.richtxtMain = new System.Windows.Forms.RichTextBox();
            this.cmbBoxBar = new System.Windows.Forms.ComboBox();
            this.btnQr = new System.Windows.Forms.Button();
            this.chkSub = new System.Windows.Forms.CheckBox();
            this.chkItalico = new System.Windows.Forms.CheckBox();
            this.chkNeg = new System.Windows.Forms.CheckBox();
            this.SuspendLayout();
            // 
            // btnInit
            // 
            this.btnInit.Location = new System.Drawing.Point(12, 23);
            this.btnInit.Name = "btnInit";
            this.btnInit.Size = new System.Drawing.Size(99, 39);
            this.btnInit.TabIndex = 0;
            this.btnInit.Text = "Inicializa";
            this.btnInit.UseVisualStyleBackColor = true;
            this.btnInit.Click += new System.EventHandler(this.Init_Click);
            // 
            // btnPrint
            // 
            this.btnPrint.Location = new System.Drawing.Point(257, 276);
            this.btnPrint.Name = "btnPrint";
            this.btnPrint.Size = new System.Drawing.Size(100, 39);
            this.btnPrint.TabIndex = 1;
            this.btnPrint.Text = "Imprime";
            this.btnPrint.UseVisualStyleBackColor = true;
            this.btnPrint.Click += new System.EventHandler(this.Print_Click);
            // 
            // btnCutPartial
            // 
            this.btnCutPartial.Location = new System.Drawing.Point(12, 276);
            this.btnCutPartial.Name = "btnCutPartial";
            this.btnCutPartial.Size = new System.Drawing.Size(99, 39);
            this.btnCutPartial.TabIndex = 2;
            this.btnCutPartial.Text = "Guilhotina Parcial";
            this.btnCutPartial.UseVisualStyleBackColor = true;
            this.btnCutPartial.Click += new System.EventHandler(this.CutParcial_Click);
            // 
            // btnCutTotal
            // 
            this.btnCutTotal.Location = new System.Drawing.Point(138, 276);
            this.btnCutTotal.Name = "btnCutTotal";
            this.btnCutTotal.Size = new System.Drawing.Size(99, 39);
            this.btnCutTotal.TabIndex = 3;
            this.btnCutTotal.Text = "Guilhotina Completa";
            this.btnCutTotal.UseVisualStyleBackColor = true;
            this.btnCutTotal.Click += new System.EventHandler(this.CutTotal_Click);
            // 
            // btnBar
            // 
            this.btnBar.Location = new System.Drawing.Point(258, 376);
            this.btnBar.Name = "btnBar";
            this.btnBar.Size = new System.Drawing.Size(99, 21);
            this.btnBar.TabIndex = 5;
            this.btnBar.Text = "Código de Barras";
            this.btnBar.UseVisualStyleBackColor = true;
            this.btnBar.Click += new System.EventHandler(this.Bar_Click);
            // 
            // btnReset
            // 
            this.btnReset.Location = new System.Drawing.Point(138, 23);
            this.btnReset.Name = "btnReset";
            this.btnReset.Size = new System.Drawing.Size(99, 39);
            this.btnReset.TabIndex = 6;
            this.btnReset.Text = "Reset";
            this.btnReset.UseVisualStyleBackColor = true;
            this.btnReset.Click += new System.EventHandler(this.Reset_Click);
            // 
            // btnTest
            // 
            this.btnTest.Location = new System.Drawing.Point(257, 23);
            this.btnTest.Name = "btnTest";
            this.btnTest.Size = new System.Drawing.Size(99, 39);
            this.btnTest.TabIndex = 10;
            this.btnTest.Text = "Testar Impressora";
            this.btnTest.UseVisualStyleBackColor = true;
            this.btnTest.Click += new System.EventHandler(this.PrintTest_Click);
            // 
            // txtQrCode
            // 
            this.txtQrCode.Location = new System.Drawing.Point(12, 404);
            this.txtQrCode.Name = "txtQrCode";
            this.txtQrCode.Size = new System.Drawing.Size(240, 20);
            this.txtQrCode.TabIndex = 11;
            // 
            // txtBar
            // 
            this.txtBar.Location = new System.Drawing.Point(12, 378);
            this.txtBar.Name = "txtBar";
            this.txtBar.Size = new System.Drawing.Size(146, 20);
            this.txtBar.TabIndex = 12;
            // 
            // richtxtMain
            // 
            this.richtxtMain.Location = new System.Drawing.Point(12, 82);
            this.richtxtMain.Name = "richtxtMain";
            this.richtxtMain.Size = new System.Drawing.Size(344, 168);
            this.richtxtMain.TabIndex = 14;
            this.richtxtMain.Text = "";
            // 
            // cmbBoxBar
            // 
            this.cmbBoxBar.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbBoxBar.FormattingEnabled = true;
            this.cmbBoxBar.Items.AddRange(new object[] {
            "UPC_A",
            "EAN13",
            "EAN8",
            "CODE39",
            "ITF",
            "CODABAR",
            "CODE93",
            "CODE128"});
            this.cmbBoxBar.Location = new System.Drawing.Point(164, 377);
            this.cmbBoxBar.Name = "cmbBoxBar";
            this.cmbBoxBar.Size = new System.Drawing.Size(88, 21);
            this.cmbBoxBar.TabIndex = 15;
            // 
            // btnQr
            // 
            this.btnQr.Location = new System.Drawing.Point(258, 403);
            this.btnQr.Name = "btnQr";
            this.btnQr.Size = new System.Drawing.Size(98, 21);
            this.btnQr.TabIndex = 16;
            this.btnQr.Text = "Código QR";
            this.btnQr.UseVisualStyleBackColor = true;
            this.btnQr.Click += new System.EventHandler(this.BtnQr_Click);
            // 
            // chkSub
            // 
            this.chkSub.AutoSize = true;
            this.chkSub.Location = new System.Drawing.Point(17, 339);
            this.chkSub.Name = "chkSub";
            this.chkSub.Size = new System.Drawing.Size(79, 17);
            this.chkSub.TabIndex = 17;
            this.chkSub.Text = "Sublinhado";
            this.chkSub.UseVisualStyleBackColor = true;
            // 
            // chkItalico
            // 
            this.chkItalico.AutoSize = true;
            this.chkItalico.Location = new System.Drawing.Point(141, 339);
            this.chkItalico.Name = "chkItalico";
            this.chkItalico.Size = new System.Drawing.Size(54, 17);
            this.chkItalico.TabIndex = 18;
            this.chkItalico.Text = "Itálico";
            this.chkItalico.UseVisualStyleBackColor = true;
            // 
            // chkNeg
            // 
            this.chkNeg.AutoSize = true;
            this.chkNeg.Location = new System.Drawing.Point(260, 337);
            this.chkNeg.Name = "chkNeg";
            this.chkNeg.Size = new System.Drawing.Size(60, 17);
            this.chkNeg.TabIndex = 19;
            this.chkNeg.Text = "Negrito";
            this.chkNeg.UseVisualStyleBackColor = true;
            // 
            // CidPrinterApp
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(370, 440);
            this.Controls.Add(this.chkNeg);
            this.Controls.Add(this.chkItalico);
            this.Controls.Add(this.chkSub);
            this.Controls.Add(this.btnQr);
            this.Controls.Add(this.cmbBoxBar);
            this.Controls.Add(this.richtxtMain);
            this.Controls.Add(this.txtBar);
            this.Controls.Add(this.txtQrCode);
            this.Controls.Add(this.btnTest);
            this.Controls.Add(this.btnReset);
            this.Controls.Add(this.btnBar);
            this.Controls.Add(this.btnCutTotal);
            this.Controls.Add(this.btnCutPartial);
            this.Controls.Add(this.btnPrint);
            this.Controls.Add(this.btnInit);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "CidPrinterApp";
            this.Text = "Exemplo Print iD";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnInit;
        private System.Windows.Forms.Button btnPrint;
        private System.Windows.Forms.Button btnCutPartial;
        private System.Windows.Forms.Button btnCutTotal;
        private System.Windows.Forms.Button btnBar;
        private System.Windows.Forms.Button btnReset;
        private System.Windows.Forms.Button btnTest;
        private System.Windows.Forms.TextBox txtQrCode;
        private System.Windows.Forms.TextBox txtBar;
        private System.Windows.Forms.RichTextBox richtxtMain;
        private System.Windows.Forms.ComboBox cmbBoxBar;
        private System.Windows.Forms.Button btnQr;
        private System.Windows.Forms.CheckBox chkSub;
        private System.Windows.Forms.CheckBox chkItalico;
        private System.Windows.Forms.CheckBox chkNeg;
    }
}

