namespace TesteRepCid
{
    partial class frmConfig
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
            System.Windows.Forms.Label label1;
            System.Windows.Forms.Label label4;
            System.Windows.Forms.Label label6;
            System.Windows.Forms.Label label7;
            System.Windows.Forms.Label label10;
            System.Windows.Forms.Label label9;
            System.Windows.Forms.Label label2;
            System.Windows.Forms.Label label5;
            System.Windows.Forms.Label label11;
            System.Windows.Forms.Label label12;
            this.lblInfo = new System.Windows.Forms.Label();
            this.btnNow = new System.Windows.Forms.Button();
            this.chkVeraoIni = new System.Windows.Forms.CheckBox();
            this.dtpVeraoFim = new System.Windows.Forms.DateTimePicker();
            this.dtpVeraoInicio = new System.Windows.Forms.DateTimePicker();
            this.txtData = new System.Windows.Forms.DateTimePicker();
            this.txtHora = new System.Windows.Forms.MaskedTextBox();
            this.txtGateway = new System.Windows.Forms.MaskedTextBox();
            this.txtMascara = new System.Windows.Forms.MaskedTextBox();
            this.txtIP = new System.Windows.Forms.MaskedTextBox();
            this.nudPort = new System.Windows.Forms.NumericUpDown();
            this.txtRazaoSocial = new System.Windows.Forms.TextBox();
            this.txtEndereco = new System.Windows.Forms.TextBox();
            this.txtCEI = new System.Windows.Forms.TextBox();
            this.txtCPFCNPJ = new System.Windows.Forms.TextBox();
            this.grpLoad = new System.Windows.Forms.GroupBox();
            this.load = new System.ComponentModel.BackgroundWorker();
            this.tb = new System.Windows.Forms.TabControl();
            this.tbH = new System.Windows.Forms.TabPage();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.chkVeraoFim = new System.Windows.Forms.CheckBox();
            this.btnHorario = new System.Windows.Forms.Button();
            this.tbE = new System.Windows.Forms.TabPage();
            this.btnEmpresa = new System.Windows.Forms.Button();
            this.tbR = new System.Windows.Forms.TabPage();
            this.btnRede = new System.Windows.Forms.Button();
            label1 = new System.Windows.Forms.Label();
            label4 = new System.Windows.Forms.Label();
            label6 = new System.Windows.Forms.Label();
            label7 = new System.Windows.Forms.Label();
            label10 = new System.Windows.Forms.Label();
            label9 = new System.Windows.Forms.Label();
            label2 = new System.Windows.Forms.Label();
            label5 = new System.Windows.Forms.Label();
            label11 = new System.Windows.Forms.Label();
            label12 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.nudPort)).BeginInit();
            this.grpLoad.SuspendLayout();
            this.tb.SuspendLayout();
            this.tbH.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.tbE.SuspendLayout();
            this.tbR.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            label1.Location = new System.Drawing.Point(93, 13);
            label1.Name = "label1";
            label1.Size = new System.Drawing.Size(38, 13);
            label1.TabIndex = 1;
            label1.Text = "Hora:";
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            label4.Location = new System.Drawing.Point(4, 13);
            label4.Name = "label4";
            label4.Size = new System.Drawing.Size(38, 13);
            label4.TabIndex = 8;
            label4.Text = "Data:";
            // 
            // label6
            // 
            label6.AutoSize = true;
            label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold);
            label6.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            label6.Location = new System.Drawing.Point(110, 13);
            label6.Name = "label6";
            label6.Size = new System.Drawing.Size(41, 13);
            label6.TabIndex = 7;
            label6.Text = "Porta:";
            // 
            // label7
            // 
            label7.AutoSize = true;
            label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold);
            label7.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            label7.Location = new System.Drawing.Point(6, 13);
            label7.Name = "label7";
            label7.Size = new System.Drawing.Size(23, 13);
            label7.TabIndex = 6;
            label7.Text = "IP:";
            // 
            // label10
            // 
            label10.AutoSize = true;
            label10.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold);
            label10.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            label10.Location = new System.Drawing.Point(4, 129);
            label10.Name = "label10";
            label10.Size = new System.Drawing.Size(86, 13);
            label10.TabIndex = 20;
            label10.Text = "Razão Social:";
            // 
            // label9
            // 
            label9.AutoSize = true;
            label9.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold);
            label9.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            label9.Location = new System.Drawing.Point(4, 90);
            label9.Name = "label9";
            label9.Size = new System.Drawing.Size(65, 13);
            label9.TabIndex = 18;
            label9.Text = "Endereço:";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold);
            label2.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            label2.Location = new System.Drawing.Point(4, 51);
            label2.Name = "label2";
            label2.Size = new System.Drawing.Size(31, 13);
            label2.TabIndex = 16;
            label2.Text = "CEI:";
            // 
            // label5
            // 
            label5.AutoSize = true;
            label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold);
            label5.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            label5.Location = new System.Drawing.Point(4, 12);
            label5.Name = "label5";
            label5.Size = new System.Drawing.Size(79, 13);
            label5.TabIndex = 6;
            label5.Text = "CPF / CNPJ:";
            // 
            // label11
            // 
            label11.AutoSize = true;
            label11.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold);
            label11.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            label11.Location = new System.Drawing.Point(6, 53);
            label11.Name = "label11";
            label11.Size = new System.Drawing.Size(59, 13);
            label11.TabIndex = 10;
            label11.Text = "Mascara:";
            // 
            // label12
            // 
            label12.AutoSize = true;
            label12.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold);
            label12.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            label12.Location = new System.Drawing.Point(6, 92);
            label12.Name = "label12";
            label12.Size = new System.Drawing.Size(60, 13);
            label12.TabIndex = 12;
            label12.Text = "Gateway:";
            // 
            // lblInfo
            // 
            this.lblInfo.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblInfo.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblInfo.Location = new System.Drawing.Point(3, 16);
            this.lblInfo.Name = "lblInfo";
            this.lblInfo.Size = new System.Drawing.Size(283, 234);
            this.lblInfo.TabIndex = 0;
            this.lblInfo.Text = "Lendo Informações";
            this.lblInfo.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // btnNow
            // 
            this.btnNow.Location = new System.Drawing.Point(156, 29);
            this.btnNow.Name = "btnNow";
            this.btnNow.Size = new System.Drawing.Size(46, 23);
            this.btnNow.TabIndex = 14;
            this.btnNow.Text = "Agora";
            this.btnNow.UseVisualStyleBackColor = true;
            this.btnNow.Click += new System.EventHandler(this.btnNow_Click);
            // 
            // chkVeraoIni
            // 
            this.chkVeraoIni.AutoSize = true;
            this.chkVeraoIni.Location = new System.Drawing.Point(9, 21);
            this.chkVeraoIni.Name = "chkVeraoIni";
            this.chkVeraoIni.Size = new System.Drawing.Size(56, 17);
            this.chkVeraoIni.TabIndex = 9;
            this.chkVeraoIni.Text = "Início:";
            this.chkVeraoIni.UseVisualStyleBackColor = true;
            this.chkVeraoIni.CheckedChanged += new System.EventHandler(this.chkVeraoIni_CheckedChanged);
            // 
            // dtpVeraoFim
            // 
            this.dtpVeraoFim.CustomFormat = "";
            this.dtpVeraoFim.Enabled = false;
            this.dtpVeraoFim.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpVeraoFim.Location = new System.Drawing.Point(71, 46);
            this.dtpVeraoFim.Name = "dtpVeraoFim";
            this.dtpVeraoFim.Size = new System.Drawing.Size(83, 20);
            this.dtpVeraoFim.TabIndex = 3;
            // 
            // dtpVeraoInicio
            // 
            this.dtpVeraoInicio.CustomFormat = "";
            this.dtpVeraoInicio.Enabled = false;
            this.dtpVeraoInicio.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpVeraoInicio.Location = new System.Drawing.Point(71, 20);
            this.dtpVeraoInicio.Name = "dtpVeraoInicio";
            this.dtpVeraoInicio.Size = new System.Drawing.Size(83, 20);
            this.dtpVeraoInicio.TabIndex = 2;
            // 
            // txtData
            // 
            this.txtData.CustomFormat = "";
            this.txtData.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.txtData.Location = new System.Drawing.Point(7, 31);
            this.txtData.Name = "txtData";
            this.txtData.Size = new System.Drawing.Size(86, 20);
            this.txtData.TabIndex = 0;
            // 
            // txtHora
            // 
            this.txtHora.Location = new System.Drawing.Point(99, 31);
            this.txtHora.Mask = "00:00:00";
            this.txtHora.Name = "txtHora";
            this.txtHora.Size = new System.Drawing.Size(53, 20);
            this.txtHora.TabIndex = 1;
            // 
            // txtGateway
            // 
            this.txtGateway.Culture = new System.Globalization.CultureInfo("");
            this.txtGateway.Location = new System.Drawing.Point(9, 108);
            this.txtGateway.Mask = "000.000.000.000";
            this.txtGateway.Name = "txtGateway";
            this.txtGateway.Size = new System.Drawing.Size(98, 20);
            this.txtGateway.TabIndex = 3;
            // 
            // txtMascara
            // 
            this.txtMascara.Culture = new System.Globalization.CultureInfo("");
            this.txtMascara.Location = new System.Drawing.Point(9, 69);
            this.txtMascara.Mask = "000.000.000.000";
            this.txtMascara.Name = "txtMascara";
            this.txtMascara.Size = new System.Drawing.Size(98, 20);
            this.txtMascara.TabIndex = 2;
            // 
            // txtIP
            // 
            this.txtIP.Culture = new System.Globalization.CultureInfo("");
            this.txtIP.Location = new System.Drawing.Point(9, 30);
            this.txtIP.Mask = "000.000.000.000";
            this.txtIP.Name = "txtIP";
            this.txtIP.Size = new System.Drawing.Size(98, 20);
            this.txtIP.TabIndex = 0;
            // 
            // nudPort
            // 
            this.nudPort.Location = new System.Drawing.Point(113, 30);
            this.nudPort.Maximum = new decimal(new int[] {
            65535,
            0,
            0,
            0});
            this.nudPort.Name = "nudPort";
            this.nudPort.Size = new System.Drawing.Size(53, 20);
            this.nudPort.TabIndex = 1;
            this.nudPort.Value = new decimal(new int[] {
            1818,
            0,
            0,
            0});
            // 
            // txtRazaoSocial
            // 
            this.txtRazaoSocial.Location = new System.Drawing.Point(7, 145);
            this.txtRazaoSocial.Name = "txtRazaoSocial";
            this.txtRazaoSocial.Size = new System.Drawing.Size(187, 20);
            this.txtRazaoSocial.TabIndex = 3;
            // 
            // txtEndereco
            // 
            this.txtEndereco.Location = new System.Drawing.Point(7, 106);
            this.txtEndereco.Name = "txtEndereco";
            this.txtEndereco.Size = new System.Drawing.Size(187, 20);
            this.txtEndereco.TabIndex = 2;
            // 
            // txtCEI
            // 
            this.txtCEI.Location = new System.Drawing.Point(7, 67);
            this.txtCEI.MaxLength = 12;
            this.txtCEI.Name = "txtCEI";
            this.txtCEI.Size = new System.Drawing.Size(187, 20);
            this.txtCEI.TabIndex = 1;
            // 
            // txtCPFCNPJ
            // 
            this.txtCPFCNPJ.Location = new System.Drawing.Point(7, 28);
            this.txtCPFCNPJ.MaxLength = 14;
            this.txtCPFCNPJ.Name = "txtCPFCNPJ";
            this.txtCPFCNPJ.Size = new System.Drawing.Size(187, 20);
            this.txtCPFCNPJ.TabIndex = 0;
            // 
            // grpLoad
            // 
            this.grpLoad.Controls.Add(this.lblInfo);
            this.grpLoad.Location = new System.Drawing.Point(12, 258);
            this.grpLoad.Name = "grpLoad";
            this.grpLoad.Size = new System.Drawing.Size(289, 253);
            this.grpLoad.TabIndex = 13;
            this.grpLoad.TabStop = false;
            // 
            // load
            // 
            this.load.DoWork += new System.ComponentModel.DoWorkEventHandler(this.load_DoWork);
            this.load.RunWorkerCompleted += new System.ComponentModel.RunWorkerCompletedEventHandler(this.load_RunWorkerCompleted);
            // 
            // tb
            // 
            this.tb.Controls.Add(this.tbH);
            this.tb.Controls.Add(this.tbE);
            this.tb.Controls.Add(this.tbR);
            this.tb.Location = new System.Drawing.Point(12, 12);
            this.tb.Name = "tb";
            this.tb.SelectedIndex = 0;
            this.tb.Size = new System.Drawing.Size(223, 240);
            this.tb.TabIndex = 14;
            // 
            // tbH
            // 
            this.tbH.Controls.Add(this.groupBox1);
            this.tbH.Controls.Add(this.btnHorario);
            this.tbH.Controls.Add(this.btnNow);
            this.tbH.Controls.Add(label4);
            this.tbH.Controls.Add(label1);
            this.tbH.Controls.Add(this.txtHora);
            this.tbH.Controls.Add(this.txtData);
            this.tbH.Location = new System.Drawing.Point(4, 22);
            this.tbH.Name = "tbH";
            this.tbH.Padding = new System.Windows.Forms.Padding(3);
            this.tbH.Size = new System.Drawing.Size(215, 214);
            this.tbH.TabIndex = 1;
            this.tbH.Text = "Horario";
            this.tbH.UseVisualStyleBackColor = true;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.chkVeraoFim);
            this.groupBox1.Controls.Add(this.chkVeraoIni);
            this.groupBox1.Controls.Add(this.dtpVeraoInicio);
            this.groupBox1.Controls.Add(this.dtpVeraoFim);
            this.groupBox1.Location = new System.Drawing.Point(6, 80);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(203, 76);
            this.groupBox1.TabIndex = 16;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Programar Horário de Verão";
            // 
            // chkVeraoFim
            // 
            this.chkVeraoFim.AutoSize = true;
            this.chkVeraoFim.Location = new System.Drawing.Point(9, 46);
            this.chkVeraoFim.Name = "chkVeraoFim";
            this.chkVeraoFim.Size = new System.Drawing.Size(45, 17);
            this.chkVeraoFim.TabIndex = 9;
            this.chkVeraoFim.Text = "Fim:";
            this.chkVeraoFim.UseVisualStyleBackColor = true;
            this.chkVeraoFim.CheckedChanged += new System.EventHandler(this.chkVeraoFim_CheckedChanged);
            // 
            // btnHorario
            // 
            this.btnHorario.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnHorario.Location = new System.Drawing.Point(94, 184);
            this.btnHorario.Name = "btnHorario";
            this.btnHorario.Size = new System.Drawing.Size(115, 24);
            this.btnHorario.TabIndex = 15;
            this.btnHorario.Text = "Atualizar o REP";
            this.btnHorario.UseVisualStyleBackColor = true;
            this.btnHorario.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // tbE
            // 
            this.tbE.Controls.Add(this.btnEmpresa);
            this.tbE.Controls.Add(this.txtRazaoSocial);
            this.tbE.Controls.Add(label10);
            this.tbE.Controls.Add(label5);
            this.tbE.Controls.Add(this.txtEndereco);
            this.tbE.Controls.Add(this.txtCPFCNPJ);
            this.tbE.Controls.Add(label9);
            this.tbE.Controls.Add(label2);
            this.tbE.Controls.Add(this.txtCEI);
            this.tbE.Location = new System.Drawing.Point(4, 22);
            this.tbE.Name = "tbE";
            this.tbE.Padding = new System.Windows.Forms.Padding(3);
            this.tbE.Size = new System.Drawing.Size(215, 214);
            this.tbE.TabIndex = 2;
            this.tbE.Text = "Empresa";
            this.tbE.UseVisualStyleBackColor = true;
            // 
            // btnEmpresa
            // 
            this.btnEmpresa.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnEmpresa.Location = new System.Drawing.Point(94, 184);
            this.btnEmpresa.Name = "btnEmpresa";
            this.btnEmpresa.Size = new System.Drawing.Size(115, 24);
            this.btnEmpresa.TabIndex = 21;
            this.btnEmpresa.Text = "Atualizar o REP";
            this.btnEmpresa.UseVisualStyleBackColor = true;
            this.btnEmpresa.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // tbR
            // 
            this.tbR.Controls.Add(this.btnRede);
            this.tbR.Controls.Add(this.txtGateway);
            this.tbR.Controls.Add(label12);
            this.tbR.Controls.Add(label7);
            this.tbR.Controls.Add(this.txtMascara);
            this.tbR.Controls.Add(this.nudPort);
            this.tbR.Controls.Add(label11);
            this.tbR.Controls.Add(label6);
            this.tbR.Controls.Add(this.txtIP);
            this.tbR.Location = new System.Drawing.Point(4, 22);
            this.tbR.Name = "tbR";
            this.tbR.Padding = new System.Windows.Forms.Padding(3);
            this.tbR.Size = new System.Drawing.Size(215, 214);
            this.tbR.TabIndex = 0;
            this.tbR.Text = "Rede";
            this.tbR.UseVisualStyleBackColor = true;
            // 
            // btnRede
            // 
            this.btnRede.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnRede.Location = new System.Drawing.Point(94, 184);
            this.btnRede.Name = "btnRede";
            this.btnRede.Size = new System.Drawing.Size(115, 24);
            this.btnRede.TabIndex = 16;
            this.btnRede.Text = "Atualizar o REP";
            this.btnRede.UseVisualStyleBackColor = true;
            this.btnRede.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // frmConfig
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(237, 261);
            this.Controls.Add(this.grpLoad);
            this.Controls.Add(this.tb);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Name = "frmConfig";
            this.Text = "Configurações";
            this.Load += new System.EventHandler(this.frmConfig_Load);
            ((System.ComponentModel.ISupportInitialize)(this.nudPort)).EndInit();
            this.grpLoad.ResumeLayout(false);
            this.tb.ResumeLayout(false);
            this.tbH.ResumeLayout(false);
            this.tbH.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.tbE.ResumeLayout(false);
            this.tbE.PerformLayout();
            this.tbR.ResumeLayout(false);
            this.tbR.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DateTimePicker dtpVeraoFim;
        private System.Windows.Forms.DateTimePicker dtpVeraoInicio;
        private System.Windows.Forms.DateTimePicker txtData;
        private System.Windows.Forms.MaskedTextBox txtHora;
        private System.Windows.Forms.MaskedTextBox txtIP;
        private System.Windows.Forms.NumericUpDown nudPort;
        private System.Windows.Forms.TextBox txtRazaoSocial;
        private System.Windows.Forms.TextBox txtEndereco;
        private System.Windows.Forms.TextBox txtCEI;
        private System.Windows.Forms.TextBox txtCPFCNPJ;
        private System.Windows.Forms.MaskedTextBox txtGateway;
        private System.Windows.Forms.MaskedTextBox txtMascara;
        private System.Windows.Forms.GroupBox grpLoad;
        private System.ComponentModel.BackgroundWorker load;
        private System.Windows.Forms.Label lblInfo;
        private System.Windows.Forms.CheckBox chkVeraoIni;
        private System.Windows.Forms.Button btnNow;
        private System.Windows.Forms.TabControl tb;
        private System.Windows.Forms.TabPage tbH;
        private System.Windows.Forms.Button btnHorario;
        private System.Windows.Forms.TabPage tbE;
        private System.Windows.Forms.Button btnEmpresa;
        private System.Windows.Forms.TabPage tbR;
        private System.Windows.Forms.Button btnRede;
		private System.Windows.Forms.GroupBox groupBox1;
		private System.Windows.Forms.CheckBox chkVeraoFim;
    }
}