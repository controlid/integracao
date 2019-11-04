namespace TesteRepCid
{
    partial class frmMain
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

        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmMain));
            this.btnTest = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.nudPort = new System.Windows.Forms.NumericUpDown();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.btnTestUsb = new System.Windows.Forms.Button();
            this.txtIP = new System.Windows.Forms.TextBox();
            this.nudPassCode = new System.Windows.Forms.NumericUpDown();
            this.label3 = new System.Windows.Forms.Label();
            this.btnUSR = new System.Windows.Forms.Button();
            this.btnCFG = new System.Windows.Forms.Button();
            this.btnAFD = new System.Windows.Forms.Button();
            this.sfd = new System.Windows.Forms.SaveFileDialog();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.ofd = new System.Windows.Forms.OpenFileDialog();
            ((System.ComponentModel.ISupportInitialize)(this.nudPort)).BeginInit();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudPassCode)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            this.SuspendLayout();
            // 
            // btnTest
            // 
            resources.ApplyResources(this.btnTest, "btnTest");
            this.btnTest.Name = "btnTest";
            this.btnTest.UseVisualStyleBackColor = true;
            this.btnTest.Click += new System.EventHandler(this.btnTest_Click);
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // label2
            // 
            resources.ApplyResources(this.label2, "label2");
            this.label2.Name = "label2";
            // 
            // nudPort
            // 
            resources.ApplyResources(this.nudPort, "nudPort");
            this.nudPort.Maximum = new decimal(new int[] {
            99999,
            0,
            0,
            0});
            this.nudPort.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.nudPort.Name = "nudPort";
            this.nudPort.Value = new decimal(new int[] {
            1818,
            0,
            0,
            0});
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.btnTestUsb);
            this.groupBox1.Controls.Add(this.txtIP);
            this.groupBox1.Controls.Add(this.nudPassCode);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.btnTest);
            this.groupBox1.Controls.Add(this.nudPort);
            this.groupBox1.Controls.Add(this.label1);
            resources.ApplyResources(this.groupBox1, "groupBox1");
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.TabStop = false;
            // 
            // btnTestUsb
            // 
            resources.ApplyResources(this.btnTestUsb, "btnTestUsb");
            this.btnTestUsb.Name = "btnTestUsb";
            this.btnTestUsb.UseVisualStyleBackColor = true;
            this.btnTestUsb.Click += new System.EventHandler(this.btnTestUsb_Click);
            // 
            // txtIP
            // 
            resources.ApplyResources(this.txtIP, "txtIP");
            this.txtIP.Name = "txtIP";
            // 
            // nudPassCode
            // 
            resources.ApplyResources(this.nudPassCode, "nudPassCode");
            this.nudPassCode.Maximum = new decimal(new int[] {
            999999999,
            0,
            0,
            0});
            this.nudPassCode.Name = "nudPassCode";
            // 
            // label3
            // 
            resources.ApplyResources(this.label3, "label3");
            this.label3.Name = "label3";
            // 
            // btnUSR
            // 
            resources.ApplyResources(this.btnUSR, "btnUSR");
            this.btnUSR.Name = "btnUSR";
            this.btnUSR.UseVisualStyleBackColor = true;
            this.btnUSR.Click += new System.EventHandler(this.btnUSR_Click);
            // 
            // btnCFG
            // 
            resources.ApplyResources(this.btnCFG, "btnCFG");
            this.btnCFG.Name = "btnCFG";
            this.btnCFG.UseVisualStyleBackColor = true;
            this.btnCFG.Click += new System.EventHandler(this.btnCFG_Click);
            // 
            // btnAFD
            // 
            resources.ApplyResources(this.btnAFD, "btnAFD");
            this.btnAFD.Name = "btnAFD";
            this.btnAFD.UseVisualStyleBackColor = true;
            this.btnAFD.Click += new System.EventHandler(this.btnAFD_Click);
            // 
            // sfd
            // 
            this.sfd.DefaultExt = "txt";
            resources.ApplyResources(this.sfd, "sfd");
            this.sfd.RestoreDirectory = true;
            // 
            // pictureBox2
            // 
            resources.ApplyResources(this.pictureBox2, "pictureBox2");
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.TabStop = false;
            // 
            // frmMain
            // 
            this.AcceptButton = this.btnTest;
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.pictureBox2);
            this.Controls.Add(this.btnAFD);
            this.Controls.Add(this.btnCFG);
            this.Controls.Add(this.btnUSR);
            this.Controls.Add(this.groupBox1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Name = "frmMain";
            this.Load += new System.EventHandler(this.frmMain_Load);
            ((System.ComponentModel.ISupportInitialize)(this.nudPort)).EndInit();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudPassCode)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnTest;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
		private System.Windows.Forms.NumericUpDown nudPort;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button btnUSR;
        private System.Windows.Forms.Button btnCFG;
		private System.Windows.Forms.Button btnAFD;
        private System.Windows.Forms.SaveFileDialog sfd;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.NumericUpDown nudPassCode;
		private System.Windows.Forms.PictureBox pictureBox2;
		private System.Windows.Forms.OpenFileDialog ofd;
		private System.Windows.Forms.TextBox txtIP;
        private System.Windows.Forms.Button btnTestUsb;
    }
}