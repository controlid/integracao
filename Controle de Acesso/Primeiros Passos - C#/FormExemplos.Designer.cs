namespace ExemploAPI
{
    partial class frmExemplos
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmExemplos));
            this.tbc = new System.Windows.Forms.TabControl();
            this.tbDevice = new System.Windows.Forms.TabPage();
            this.txtPassword = new System.Windows.Forms.TextBox();
            this.txtUser = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.chkSSL = new System.Windows.Forms.CheckBox();
            this.nmPort = new System.Windows.Forms.NumericUpDown();
            this.txtIP = new System.Windows.Forms.TextBox();
            this.btnLogin = new System.Windows.Forms.Button();
            this.tbAcoes = new System.Windows.Forms.TabPage();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.btnReboot = new System.Windows.Forms.Button();
            this.cmbGiro = new System.Windows.Forms.ComboBox();
            this.btnInfo = new System.Windows.Forms.Button();
            this.btnGiro = new System.Windows.Forms.Button();
            this.btnRele2 = new System.Windows.Forms.Button();
            this.btnRele3 = new System.Windows.Forms.Button();
            this.btnRele1 = new System.Windows.Forms.Button();
            this.btnRele4 = new System.Windows.Forms.Button();
            this.tbConfig = new System.Windows.Forms.TabPage();
            this.btnAgora = new System.Windows.Forms.Button();
            this.dateTimePicker1 = new System.Windows.Forms.DateTimePicker();
            this.btnDataHora = new System.Windows.Forms.Button();
            this.tbUsers = new System.Windows.Forms.TabPage();
            this.btnUserListParse = new System.Windows.Forms.Button();
            this.btnUserBioList = new System.Windows.Forms.Button();
            this.btnUserCardList = new System.Windows.Forms.Button();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.btnUserModify = new System.Windows.Forms.Button();
            this.label11 = new System.Windows.Forms.Label();
            this.label12 = new System.Windows.Forms.Label();
            this.btnUserRead = new System.Windows.Forms.Button();
            this.btnUserDelete = new System.Windows.Forms.Button();
            this.btnUserAdd = new System.Windows.Forms.Button();
            this.txtUserRegistration = new System.Windows.Forms.TextBox();
            this.txtUserID = new System.Windows.Forms.TextBox();
            this.label13 = new System.Windows.Forms.Label();
            this.txtUserName = new System.Windows.Forms.TextBox();
            this.btnUserList = new System.Windows.Forms.Button();
            this.tbLogs = new System.Windows.Forms.TabPage();
            this.btnLogs2 = new System.Windows.Forms.Button();
            this.btnLogs = new System.Windows.Forms.Button();
            this.txtOut = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.btnPT = new System.Windows.Forms.Button();
            this.btEN = new System.Windows.Forms.Button();
            this.label8 = new System.Windows.Forms.Label();
            this.tbc.SuspendLayout();
            this.tbDevice.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nmPort)).BeginInit();
            this.tbAcoes.SuspendLayout();
            this.tbConfig.SuspendLayout();
            this.tbUsers.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.tbLogs.SuspendLayout();
            this.SuspendLayout();
            // 
            // tbc
            // 
            resources.ApplyResources(this.tbc, "tbc");
            this.tbc.Controls.Add(this.tbDevice);
            this.tbc.Controls.Add(this.tbAcoes);
            this.tbc.Controls.Add(this.tbConfig);
            this.tbc.Controls.Add(this.tbUsers);
            this.tbc.Controls.Add(this.tbLogs);
            this.tbc.Name = "tbc";
            this.tbc.SelectedIndex = 0;
            this.tbc.SelectedIndexChanged += new System.EventHandler(this.tbc_SelectedIndexChanged);
            // 
            // tbDevice
            // 
            resources.ApplyResources(this.tbDevice, "tbDevice");
            this.tbDevice.Controls.Add(this.txtPassword);
            this.tbDevice.Controls.Add(this.txtUser);
            this.tbDevice.Controls.Add(this.label4);
            this.tbDevice.Controls.Add(this.label3);
            this.tbDevice.Controls.Add(this.label2);
            this.tbDevice.Controls.Add(this.label1);
            this.tbDevice.Controls.Add(this.chkSSL);
            this.tbDevice.Controls.Add(this.nmPort);
            this.tbDevice.Controls.Add(this.txtIP);
            this.tbDevice.Controls.Add(this.btnLogin);
            this.tbDevice.Name = "tbDevice";
            this.tbDevice.UseVisualStyleBackColor = true;
            // 
            // txtPassword
            // 
            resources.ApplyResources(this.txtPassword, "txtPassword");
            this.txtPassword.Name = "txtPassword";
            // 
            // txtUser
            // 
            resources.ApplyResources(this.txtUser, "txtUser");
            this.txtUser.Name = "txtUser";
            // 
            // label4
            // 
            resources.ApplyResources(this.label4, "label4");
            this.label4.Name = "label4";
            // 
            // label3
            // 
            resources.ApplyResources(this.label3, "label3");
            this.label3.Name = "label3";
            // 
            // label2
            // 
            resources.ApplyResources(this.label2, "label2");
            this.label2.Name = "label2";
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // chkSSL
            // 
            resources.ApplyResources(this.chkSSL, "chkSSL");
            this.chkSSL.Name = "chkSSL";
            this.chkSSL.UseVisualStyleBackColor = true;
            // 
            // nmPort
            // 
            resources.ApplyResources(this.nmPort, "nmPort");
            this.nmPort.Maximum = new decimal(new int[] {
            100000,
            0,
            0,
            0});
            this.nmPort.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.nmPort.Name = "nmPort";
            this.nmPort.Value = new decimal(new int[] {
            80,
            0,
            0,
            0});
            // 
            // txtIP
            // 
            resources.ApplyResources(this.txtIP, "txtIP");
            this.txtIP.Name = "txtIP";
            // 
            // btnLogin
            // 
            resources.ApplyResources(this.btnLogin, "btnLogin");
            this.btnLogin.Name = "btnLogin";
            this.btnLogin.UseVisualStyleBackColor = true;
            this.btnLogin.Click += new System.EventHandler(this.btnLogin_Click);
            // 
            // tbAcoes
            // 
            resources.ApplyResources(this.tbAcoes, "tbAcoes");
            this.tbAcoes.Controls.Add(this.label6);
            this.tbAcoes.Controls.Add(this.label7);
            this.tbAcoes.Controls.Add(this.btnReboot);
            this.tbAcoes.Controls.Add(this.cmbGiro);
            this.tbAcoes.Controls.Add(this.btnInfo);
            this.tbAcoes.Controls.Add(this.btnGiro);
            this.tbAcoes.Controls.Add(this.btnRele2);
            this.tbAcoes.Controls.Add(this.btnRele3);
            this.tbAcoes.Controls.Add(this.btnRele1);
            this.tbAcoes.Controls.Add(this.btnRele4);
            this.tbAcoes.Name = "tbAcoes";
            this.tbAcoes.UseVisualStyleBackColor = true;
            // 
            // label6
            // 
            resources.ApplyResources(this.label6, "label6");
            this.label6.Name = "label6";
            // 
            // label7
            // 
            resources.ApplyResources(this.label7, "label7");
            this.label7.Name = "label7";
            // 
            // btnReboot
            // 
            resources.ApplyResources(this.btnReboot, "btnReboot");
            this.btnReboot.Name = "btnReboot";
            this.btnReboot.UseVisualStyleBackColor = true;
            this.btnReboot.Click += new System.EventHandler(this.btnReboot_Click);
            // 
            // cmbGiro
            // 
            resources.ApplyResources(this.cmbGiro, "cmbGiro");
            this.cmbGiro.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbGiro.FormattingEnabled = true;
            this.cmbGiro.Items.AddRange(new object[] {
            resources.GetString("cmbGiro.Items"),
            resources.GetString("cmbGiro.Items1"),
            resources.GetString("cmbGiro.Items2")});
            this.cmbGiro.Name = "cmbGiro";
            // 
            // btnInfo
            // 
            resources.ApplyResources(this.btnInfo, "btnInfo");
            this.btnInfo.Name = "btnInfo";
            this.btnInfo.UseVisualStyleBackColor = true;
            this.btnInfo.Click += new System.EventHandler(this.btnInfo_Click);
            // 
            // btnGiro
            // 
            resources.ApplyResources(this.btnGiro, "btnGiro");
            this.btnGiro.Name = "btnGiro";
            this.btnGiro.UseVisualStyleBackColor = true;
            this.btnGiro.Click += new System.EventHandler(this.btnGiro_Click);
            // 
            // btnRele2
            // 
            resources.ApplyResources(this.btnRele2, "btnRele2");
            this.btnRele2.Name = "btnRele2";
            this.btnRele2.UseVisualStyleBackColor = true;
            this.btnRele2.Click += new System.EventHandler(this.btnRele_Click);
            // 
            // btnRele3
            // 
            resources.ApplyResources(this.btnRele3, "btnRele3");
            this.btnRele3.Name = "btnRele3";
            this.btnRele3.UseVisualStyleBackColor = true;
            this.btnRele3.Click += new System.EventHandler(this.btnRele_Click);
            // 
            // btnRele1
            // 
            resources.ApplyResources(this.btnRele1, "btnRele1");
            this.btnRele1.Name = "btnRele1";
            this.btnRele1.UseVisualStyleBackColor = true;
            this.btnRele1.Click += new System.EventHandler(this.btnRele_Click);
            // 
            // btnRele4
            // 
            resources.ApplyResources(this.btnRele4, "btnRele4");
            this.btnRele4.Name = "btnRele4";
            this.btnRele4.UseVisualStyleBackColor = true;
            this.btnRele4.Click += new System.EventHandler(this.btnRele_Click);
            // 
            // tbConfig
            // 
            resources.ApplyResources(this.tbConfig, "tbConfig");
            this.tbConfig.Controls.Add(this.btnAgora);
            this.tbConfig.Controls.Add(this.dateTimePicker1);
            this.tbConfig.Controls.Add(this.btnDataHora);
            this.tbConfig.Name = "tbConfig";
            this.tbConfig.UseVisualStyleBackColor = true;
            // 
            // btnAgora
            // 
            resources.ApplyResources(this.btnAgora, "btnAgora");
            this.btnAgora.Name = "btnAgora";
            this.btnAgora.UseVisualStyleBackColor = true;
            this.btnAgora.Click += new System.EventHandler(this.btnAgora_Click);
            // 
            // dateTimePicker1
            // 
            resources.ApplyResources(this.dateTimePicker1, "dateTimePicker1");
            this.dateTimePicker1.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dateTimePicker1.Name = "dateTimePicker1";
            this.dateTimePicker1.ShowUpDown = true;
            // 
            // btnDataHora
            // 
            resources.ApplyResources(this.btnDataHora, "btnDataHora");
            this.btnDataHora.Name = "btnDataHora";
            this.btnDataHora.UseVisualStyleBackColor = true;
            this.btnDataHora.Click += new System.EventHandler(this.btnDataHora_Click);
            // 
            // tbUsers
            // 
            resources.ApplyResources(this.tbUsers, "tbUsers");
            this.tbUsers.Controls.Add(this.btnUserListParse);
            this.tbUsers.Controls.Add(this.btnUserBioList);
            this.tbUsers.Controls.Add(this.btnUserCardList);
            this.tbUsers.Controls.Add(this.groupBox2);
            this.tbUsers.Controls.Add(this.btnUserList);
            this.tbUsers.Name = "tbUsers";
            this.tbUsers.UseVisualStyleBackColor = true;
            // 
            // btnUserListParse
            // 
            resources.ApplyResources(this.btnUserListParse, "btnUserListParse");
            this.btnUserListParse.Name = "btnUserListParse";
            this.btnUserListParse.UseVisualStyleBackColor = true;
            this.btnUserListParse.Click += new System.EventHandler(this.btnUserListParse_Click);
            // 
            // btnUserBioList
            // 
            resources.ApplyResources(this.btnUserBioList, "btnUserBioList");
            this.btnUserBioList.Name = "btnUserBioList";
            this.btnUserBioList.UseVisualStyleBackColor = true;
            this.btnUserBioList.Click += new System.EventHandler(this.btnUserBioList_Click);
            // 
            // btnUserCardList
            // 
            resources.ApplyResources(this.btnUserCardList, "btnUserCardList");
            this.btnUserCardList.Name = "btnUserCardList";
            this.btnUserCardList.UseVisualStyleBackColor = true;
            this.btnUserCardList.Click += new System.EventHandler(this.btnUserCardList_Click);
            // 
            // groupBox2
            // 
            resources.ApplyResources(this.groupBox2, "groupBox2");
            this.groupBox2.Controls.Add(this.btnUserModify);
            this.groupBox2.Controls.Add(this.label11);
            this.groupBox2.Controls.Add(this.label12);
            this.groupBox2.Controls.Add(this.btnUserRead);
            this.groupBox2.Controls.Add(this.btnUserDelete);
            this.groupBox2.Controls.Add(this.btnUserAdd);
            this.groupBox2.Controls.Add(this.txtUserRegistration);
            this.groupBox2.Controls.Add(this.txtUserID);
            this.groupBox2.Controls.Add(this.label13);
            this.groupBox2.Controls.Add(this.txtUserName);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.TabStop = false;
            // 
            // btnUserModify
            // 
            resources.ApplyResources(this.btnUserModify, "btnUserModify");
            this.btnUserModify.Name = "btnUserModify";
            this.btnUserModify.UseVisualStyleBackColor = true;
            this.btnUserModify.Click += new System.EventHandler(this.btnUserModify_Click);
            // 
            // label11
            // 
            resources.ApplyResources(this.label11, "label11");
            this.label11.Name = "label11";
            // 
            // label12
            // 
            resources.ApplyResources(this.label12, "label12");
            this.label12.Name = "label12";
            // 
            // btnUserRead
            // 
            resources.ApplyResources(this.btnUserRead, "btnUserRead");
            this.btnUserRead.Name = "btnUserRead";
            this.btnUserRead.UseVisualStyleBackColor = true;
            this.btnUserRead.Click += new System.EventHandler(this.btnUserRead_Click);
            // 
            // btnUserDelete
            // 
            resources.ApplyResources(this.btnUserDelete, "btnUserDelete");
            this.btnUserDelete.Name = "btnUserDelete";
            this.btnUserDelete.UseVisualStyleBackColor = true;
            this.btnUserDelete.Click += new System.EventHandler(this.btnUserDelete_Click);
            // 
            // btnUserAdd
            // 
            resources.ApplyResources(this.btnUserAdd, "btnUserAdd");
            this.btnUserAdd.Name = "btnUserAdd";
            this.btnUserAdd.UseVisualStyleBackColor = true;
            this.btnUserAdd.Click += new System.EventHandler(this.btnUserAdd_Click);
            // 
            // txtUserRegistration
            // 
            resources.ApplyResources(this.txtUserRegistration, "txtUserRegistration");
            this.txtUserRegistration.Name = "txtUserRegistration";
            // 
            // txtUserID
            // 
            resources.ApplyResources(this.txtUserID, "txtUserID");
            this.txtUserID.Name = "txtUserID";
            // 
            // label13
            // 
            resources.ApplyResources(this.label13, "label13");
            this.label13.Name = "label13";
            // 
            // txtUserName
            // 
            resources.ApplyResources(this.txtUserName, "txtUserName");
            this.txtUserName.Name = "txtUserName";
            // 
            // btnUserList
            // 
            resources.ApplyResources(this.btnUserList, "btnUserList");
            this.btnUserList.Name = "btnUserList";
            this.btnUserList.UseVisualStyleBackColor = true;
            this.btnUserList.Click += new System.EventHandler(this.btnUserList_Click);
            // 
            // tbLogs
            // 
            resources.ApplyResources(this.tbLogs, "tbLogs");
            this.tbLogs.Controls.Add(this.btnLogs2);
            this.tbLogs.Controls.Add(this.btnLogs);
            this.tbLogs.Name = "tbLogs";
            this.tbLogs.UseVisualStyleBackColor = true;
            // 
            // btnLogs2
            // 
            resources.ApplyResources(this.btnLogs2, "btnLogs2");
            this.btnLogs2.Name = "btnLogs2";
            this.btnLogs2.UseVisualStyleBackColor = true;
            this.btnLogs2.Click += new System.EventHandler(this.btnLogs2_Click);
            // 
            // btnLogs
            // 
            resources.ApplyResources(this.btnLogs, "btnLogs");
            this.btnLogs.Name = "btnLogs";
            this.btnLogs.UseVisualStyleBackColor = true;
            this.btnLogs.Click += new System.EventHandler(this.btnLogs_Click);
            // 
            // txtOut
            // 
            resources.ApplyResources(this.txtOut, "txtOut");
            this.txtOut.Name = "txtOut";
            this.txtOut.ReadOnly = true;
            // 
            // label5
            // 
            resources.ApplyResources(this.label5, "label5");
            this.label5.Name = "label5";
            // 
            // btnPT
            // 
            resources.ApplyResources(this.btnPT, "btnPT");
            this.btnPT.Image = global::ExemploAPI.Properties.Resources.BR;
            this.btnPT.Name = "btnPT";
            this.btnPT.UseVisualStyleBackColor = true;
            this.btnPT.Click += new System.EventHandler(this.btnPT_Click);
            // 
            // btEN
            // 
            resources.ApplyResources(this.btEN, "btEN");
            this.btEN.Image = global::ExemploAPI.Properties.Resources.US;
            this.btEN.Name = "btEN";
            this.btEN.UseVisualStyleBackColor = true;
            this.btEN.Click += new System.EventHandler(this.btEN_Click);
            // 
            // label8
            // 
            resources.ApplyResources(this.label8, "label8");
            this.label8.Name = "label8";
            // 
            // frmExemplos
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.label8);
            this.Controls.Add(this.btEN);
            this.Controls.Add(this.btnPT);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.txtOut);
            this.Controls.Add(this.tbc);
            this.Name = "frmExemplos";
            this.Load += new System.EventHandler(this.frmExemplos_Load);
            this.tbc.ResumeLayout(false);
            this.tbDevice.ResumeLayout(false);
            this.tbDevice.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nmPort)).EndInit();
            this.tbAcoes.ResumeLayout(false);
            this.tbAcoes.PerformLayout();
            this.tbConfig.ResumeLayout(false);
            this.tbUsers.ResumeLayout(false);
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.tbLogs.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TabControl tbc;
        private System.Windows.Forms.TabPage tbDevice;
        private System.Windows.Forms.TabPage tbConfig;
        private System.Windows.Forms.TabPage tbUsers;
        private System.Windows.Forms.TextBox txtPassword;
        private System.Windows.Forms.TextBox txtUser;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.CheckBox chkSSL;
        private System.Windows.Forms.NumericUpDown nmPort;
        private System.Windows.Forms.TextBox txtIP;
        private System.Windows.Forms.Button btnLogin;
        private System.Windows.Forms.TextBox txtOut;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TabPage tbAcoes;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Button btnReboot;
        private System.Windows.Forms.ComboBox cmbGiro;
        private System.Windows.Forms.Button btnInfo;
        private System.Windows.Forms.Button btnGiro;
        private System.Windows.Forms.Button btnRele2;
        private System.Windows.Forms.Button btnRele3;
        private System.Windows.Forms.Button btnRele1;
        private System.Windows.Forms.Button btnRele4;
        private System.Windows.Forms.DateTimePicker dateTimePicker1;
        private System.Windows.Forms.Button btnDataHora;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.Button btnUserList;
        private System.Windows.Forms.Button btnUserRead;
        private System.Windows.Forms.Button btnUserDelete;
        private System.Windows.Forms.Button btnUserAdd;
        private System.Windows.Forms.TextBox txtUserRegistration;
        private System.Windows.Forms.TextBox txtUserID;
        private System.Windows.Forms.Label label13;
        private System.Windows.Forms.TextBox txtUserName;
        private System.Windows.Forms.Button btnUserModify;
        private System.Windows.Forms.Button btnAgora;
        private System.Windows.Forms.Button btnUserListParse;
        private System.Windows.Forms.Button btnUserBioList;
        private System.Windows.Forms.Button btnUserCardList;
        private System.Windows.Forms.TabPage tbLogs;
        private System.Windows.Forms.Button btnLogs;
        private System.Windows.Forms.Button btnLogs2;
        private System.Windows.Forms.Button btnPT;
        private System.Windows.Forms.Button btEN;
        private System.Windows.Forms.Label label8;
    }
}

