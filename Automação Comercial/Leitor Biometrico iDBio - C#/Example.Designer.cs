namespace CaptureExample
{
    partial class Example
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
            this.backgroundWorker1 = new System.ComponentModel.BackgroundWorker();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.openUpdateFilebtn = new System.Windows.Forms.Button();
            this.fingerImage = new System.Windows.Forms.PictureBox();
            this.captureBtn = new System.Windows.Forms.Button();
            this.checkBtn = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.VersionTextBox = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.SerialTextBox = new System.Windows.Forms.TextBox();
            this.captureLog = new System.Windows.Forms.RichTextBox();
            this.ModelTextBox = new System.Windows.Forms.TextBox();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.enrollIDTextBox = new System.Windows.Forms.TextBox();
            this.deleteAllBtn = new System.Windows.Forms.Button();
            this.identifyTextBox = new System.Windows.Forms.TextBox();
            this.IdentifyBtn = new System.Windows.Forms.Button();
            this.enrollBtn = new System.Windows.Forms.Button();
            this.readAllBtn = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.iDsList = new System.Windows.Forms.ListView();
            this.IdentifyLog = new System.Windows.Forms.RichTextBox();
            this.tabPage3 = new System.Windows.Forms.TabPage();
            this.btnConfigDefault = new System.Windows.Forms.Button();
            this.chkAutomatic = new System.Windows.Forms.CheckBox();
            this.textBoxThreshold = new System.Windows.Forms.TextBox();
            this.chkBuzzer = new System.Windows.Forms.CheckBox();
            this.label9 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.configurationLog = new System.Windows.Forms.RichTextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.minVarTrack = new System.Windows.Forms.TrackBar();
            this.updateFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.tabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.fingerImage)).BeginInit();
            this.tabPage2.SuspendLayout();
            this.tabPage3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.minVarTrack)).BeginInit();
            this.SuspendLayout();
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabPage1);
            this.tabControl1.Controls.Add(this.tabPage2);
            this.tabControl1.Controls.Add(this.tabPage3);
            this.tabControl1.Location = new System.Drawing.Point(0, 1);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(646, 578);
            this.tabControl1.TabIndex = 10;
            this.tabControl1.SelectedIndexChanged += new System.EventHandler(this.TabControl1_SelectedIndexChanged);
            // 
            // tabPage1
            // 
            this.tabPage1.BackColor = System.Drawing.Color.WhiteSmoke;
            this.tabPage1.Controls.Add(this.openUpdateFilebtn);
            this.tabPage1.Controls.Add(this.fingerImage);
            this.tabPage1.Controls.Add(this.captureBtn);
            this.tabPage1.Controls.Add(this.checkBtn);
            this.tabPage1.Controls.Add(this.label1);
            this.tabPage1.Controls.Add(this.VersionTextBox);
            this.tabPage1.Controls.Add(this.label2);
            this.tabPage1.Controls.Add(this.label3);
            this.tabPage1.Controls.Add(this.SerialTextBox);
            this.tabPage1.Controls.Add(this.captureLog);
            this.tabPage1.Controls.Add(this.ModelTextBox);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(638, 552);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Capture";
            // 
            // openUpdateFilebtn
            // 
            this.openUpdateFilebtn.Enabled = false;
            this.openUpdateFilebtn.Font = new System.Drawing.Font("Microsoft Sans Serif", 16.25F);
            this.openUpdateFilebtn.Location = new System.Drawing.Point(377, 333);
            this.openUpdateFilebtn.Name = "openUpdateFilebtn";
            this.openUpdateFilebtn.Size = new System.Drawing.Size(203, 44);
            this.openUpdateFilebtn.TabIndex = 20;
            this.openUpdateFilebtn.Text = "Update iDBio";
            this.openUpdateFilebtn.UseVisualStyleBackColor = true;
            this.openUpdateFilebtn.Click += new System.EventHandler(this.OpenUpdateFilebtn_Click);
            // 
            // fingerImage
            // 
            this.fingerImage.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.fingerImage.Location = new System.Drawing.Point(42, 22);
            this.fingerImage.Name = "fingerImage";
            this.fingerImage.Size = new System.Drawing.Size(260, 300);
            this.fingerImage.TabIndex = 18;
            this.fingerImage.TabStop = false;
            // 
            // captureBtn
            // 
            this.captureBtn.Enabled = false;
            this.captureBtn.Font = new System.Drawing.Font("Microsoft Sans Serif", 16.25F);
            this.captureBtn.Location = new System.Drawing.Point(75, 333);
            this.captureBtn.Name = "captureBtn";
            this.captureBtn.Size = new System.Drawing.Size(192, 44);
            this.captureBtn.TabIndex = 19;
            this.captureBtn.Text = "Capture Image";
            this.captureBtn.UseVisualStyleBackColor = true;
            this.captureBtn.Click += new System.EventHandler(this.CaptureBtn_Click);
            // 
            // checkBtn
            // 
            this.checkBtn.Font = new System.Drawing.Font("Microsoft Sans Serif", 16.25F);
            this.checkBtn.Location = new System.Drawing.Point(398, 185);
            this.checkBtn.Name = "checkBtn";
            this.checkBtn.Size = new System.Drawing.Size(163, 49);
            this.checkBtn.TabIndex = 10;
            this.checkBtn.Text = "Check Device";
            this.checkBtn.UseVisualStyleBackColor = true;
            this.checkBtn.Click += new System.EventHandler(this.CheckBtn_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 16.25F);
            this.label1.Location = new System.Drawing.Point(345, 53);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(74, 26);
            this.label1.TabIndex = 11;
            this.label1.Text = "Serial:";
            // 
            // VersionTextBox
            // 
            this.VersionTextBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 16.25F);
            this.VersionTextBox.Location = new System.Drawing.Point(425, 125);
            this.VersionTextBox.Name = "VersionTextBox";
            this.VersionTextBox.ReadOnly = true;
            this.VersionTextBox.Size = new System.Drawing.Size(176, 32);
            this.VersionTextBox.TabIndex = 17;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 16.25F);
            this.label2.Location = new System.Drawing.Point(345, 90);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(77, 26);
            this.label2.TabIndex = 12;
            this.label2.Text = "Model:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 16.25F);
            this.label3.Location = new System.Drawing.Point(330, 128);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(92, 26);
            this.label3.TabIndex = 16;
            this.label3.Text = "Version:";
            // 
            // SerialTextBox
            // 
            this.SerialTextBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 16.25F);
            this.SerialTextBox.Location = new System.Drawing.Point(425, 50);
            this.SerialTextBox.Name = "SerialTextBox";
            this.SerialTextBox.ReadOnly = true;
            this.SerialTextBox.Size = new System.Drawing.Size(176, 32);
            this.SerialTextBox.TabIndex = 13;
            // 
            // captureLog
            // 
            this.captureLog.Font = new System.Drawing.Font("Microsoft Sans Serif", 12.25F);
            this.captureLog.Location = new System.Drawing.Point(19, 388);
            this.captureLog.Name = "captureLog";
            this.captureLog.Size = new System.Drawing.Size(601, 142);
            this.captureLog.TabIndex = 15;
            this.captureLog.Text = "";
            this.captureLog.TextChanged += new System.EventHandler(this.CaptureLog_TextChanged);
            // 
            // ModelTextBox
            // 
            this.ModelTextBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 16.25F);
            this.ModelTextBox.Location = new System.Drawing.Point(425, 87);
            this.ModelTextBox.Name = "ModelTextBox";
            this.ModelTextBox.ReadOnly = true;
            this.ModelTextBox.Size = new System.Drawing.Size(176, 32);
            this.ModelTextBox.TabIndex = 14;
            // 
            // tabPage2
            // 
            this.tabPage2.BackColor = System.Drawing.Color.WhiteSmoke;
            this.tabPage2.Controls.Add(this.label6);
            this.tabPage2.Controls.Add(this.label5);
            this.tabPage2.Controls.Add(this.enrollIDTextBox);
            this.tabPage2.Controls.Add(this.deleteAllBtn);
            this.tabPage2.Controls.Add(this.identifyTextBox);
            this.tabPage2.Controls.Add(this.IdentifyBtn);
            this.tabPage2.Controls.Add(this.enrollBtn);
            this.tabPage2.Controls.Add(this.readAllBtn);
            this.tabPage2.Controls.Add(this.label4);
            this.tabPage2.Controls.Add(this.iDsList);
            this.tabPage2.Controls.Add(this.IdentifyLog);
            this.tabPage2.Location = new System.Drawing.Point(4, 22);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(638, 552);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Identification";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.label6.Location = new System.Drawing.Point(178, 198);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(90, 24);
            this.label6.TabIndex = 26;
            this.label6.Text = "Identified:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.label5.Location = new System.Drawing.Point(236, 50);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(32, 24);
            this.label5.TabIndex = 25;
            this.label5.Text = "ID:";
            // 
            // enrollIDTextBox
            // 
            this.enrollIDTextBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.enrollIDTextBox.Location = new System.Drawing.Point(274, 47);
            this.enrollIDTextBox.Name = "enrollIDTextBox";
            this.enrollIDTextBox.Size = new System.Drawing.Size(130, 29);
            this.enrollIDTextBox.TabIndex = 24;
            // 
            // deleteAllBtn
            // 
            this.deleteAllBtn.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.deleteAllBtn.Location = new System.Drawing.Point(325, 331);
            this.deleteAllBtn.Name = "deleteAllBtn";
            this.deleteAllBtn.Size = new System.Drawing.Size(130, 48);
            this.deleteAllBtn.TabIndex = 23;
            this.deleteAllBtn.Text = "Delete All";
            this.deleteAllBtn.UseVisualStyleBackColor = true;
            this.deleteAllBtn.Click += new System.EventHandler(this.DeleteAllBtn_Click);
            // 
            // identifyTextBox
            // 
            this.identifyTextBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.identifyTextBox.Location = new System.Drawing.Point(274, 195);
            this.identifyTextBox.Name = "identifyTextBox";
            this.identifyTextBox.ReadOnly = true;
            this.identifyTextBox.Size = new System.Drawing.Size(130, 29);
            this.identifyTextBox.TabIndex = 22;
            // 
            // IdentifyBtn
            // 
            this.IdentifyBtn.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.IdentifyBtn.Location = new System.Drawing.Point(419, 186);
            this.IdentifyBtn.Name = "IdentifyBtn";
            this.IdentifyBtn.Size = new System.Drawing.Size(130, 48);
            this.IdentifyBtn.TabIndex = 21;
            this.IdentifyBtn.Text = "Identify";
            this.IdentifyBtn.UseVisualStyleBackColor = true;
            this.IdentifyBtn.Click += new System.EventHandler(this.IdentifyBtn_Click);
            // 
            // enrollBtn
            // 
            this.enrollBtn.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.enrollBtn.Location = new System.Drawing.Point(419, 38);
            this.enrollBtn.Name = "enrollBtn";
            this.enrollBtn.Size = new System.Drawing.Size(130, 48);
            this.enrollBtn.TabIndex = 20;
            this.enrollBtn.Text = "Enroll";
            this.enrollBtn.UseVisualStyleBackColor = true;
            this.enrollBtn.Click += new System.EventHandler(this.EnrollBtn_Click);
            // 
            // readAllBtn
            // 
            this.readAllBtn.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.readAllBtn.Location = new System.Drawing.Point(17, 331);
            this.readAllBtn.Name = "readAllBtn";
            this.readAllBtn.Size = new System.Drawing.Size(130, 48);
            this.readAllBtn.TabIndex = 19;
            this.readAllBtn.Text = "Read IDs";
            this.readAllBtn.UseVisualStyleBackColor = true;
            this.readAllBtn.Click += new System.EventHandler(this.ReadAllBtn_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.label4.Location = new System.Drawing.Point(65, 11);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(36, 24);
            this.label4.TabIndex = 18;
            this.label4.Text = "IDs";
            // 
            // iDsList
            // 
            this.iDsList.Font = new System.Drawing.Font("Microsoft Sans Serif", 12.25F);
            this.iDsList.Location = new System.Drawing.Point(48, 38);
            this.iDsList.Name = "iDsList";
            this.iDsList.Size = new System.Drawing.Size(74, 281);
            this.iDsList.TabIndex = 17;
            this.iDsList.UseCompatibleStateImageBehavior = false;
            // 
            // IdentifyLog
            // 
            this.IdentifyLog.Font = new System.Drawing.Font("Microsoft Sans Serif", 12.25F);
            this.IdentifyLog.Location = new System.Drawing.Point(17, 394);
            this.IdentifyLog.Name = "IdentifyLog";
            this.IdentifyLog.Size = new System.Drawing.Size(601, 142);
            this.IdentifyLog.TabIndex = 16;
            this.IdentifyLog.Text = "";
            this.IdentifyLog.TextChanged += new System.EventHandler(this.IdentifyLog_TextChanged);
            // 
            // tabPage3
            // 
            this.tabPage3.BackColor = System.Drawing.Color.WhiteSmoke;
            this.tabPage3.Controls.Add(this.btnConfigDefault);
            this.tabPage3.Controls.Add(this.chkAutomatic);
            this.tabPage3.Controls.Add(this.textBoxThreshold);
            this.tabPage3.Controls.Add(this.chkBuzzer);
            this.tabPage3.Controls.Add(this.label9);
            this.tabPage3.Controls.Add(this.label8);
            this.tabPage3.Controls.Add(this.configurationLog);
            this.tabPage3.Controls.Add(this.label7);
            this.tabPage3.Controls.Add(this.minVarTrack);
            this.tabPage3.Location = new System.Drawing.Point(4, 22);
            this.tabPage3.Name = "tabPage3";
            this.tabPage3.Size = new System.Drawing.Size(638, 552);
            this.tabPage3.TabIndex = 2;
            this.tabPage3.Text = "Configuration";
            // 
            // btnConfigDefault
            // 
            this.btnConfigDefault.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.btnConfigDefault.Location = new System.Drawing.Point(218, 292);
            this.btnConfigDefault.Name = "btnConfigDefault";
            this.btnConfigDefault.Size = new System.Drawing.Size(182, 48);
            this.btnConfigDefault.TabIndex = 33;
            this.btnConfigDefault.Text = "Reset to default";
            this.btnConfigDefault.UseVisualStyleBackColor = true;
            this.btnConfigDefault.Click += new System.EventHandler(this.BtnConfigDefault_Click);
            // 
            // chkAutomatic
            // 
            this.chkAutomatic.AutoSize = true;
            this.chkAutomatic.Checked = true;
            this.chkAutomatic.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chkAutomatic.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.chkAutomatic.Location = new System.Drawing.Point(397, 159);
            this.chkAutomatic.Name = "chkAutomatic";
            this.chkAutomatic.Size = new System.Drawing.Size(112, 28);
            this.chkAutomatic.TabIndex = 32;
            this.chkAutomatic.Text = "Automatic";
            this.chkAutomatic.UseVisualStyleBackColor = true;
            this.chkAutomatic.CheckedChanged += new System.EventHandler(this.ChkAutomatic_CheckedChanged);
            // 
            // textBoxThreshold
            // 
            this.textBoxThreshold.Enabled = false;
            this.textBoxThreshold.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.textBoxThreshold.Location = new System.Drawing.Point(251, 160);
            this.textBoxThreshold.Name = "textBoxThreshold";
            this.textBoxThreshold.Size = new System.Drawing.Size(130, 29);
            this.textBoxThreshold.TabIndex = 31;
            this.textBoxThreshold.Text = "0";
            this.textBoxThreshold.Leave += new System.EventHandler(this.TextBoxThreshold_Leave);
            // 
            // chkBuzzer
            // 
            this.chkBuzzer.AutoSize = true;
            this.chkBuzzer.Checked = true;
            this.chkBuzzer.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chkBuzzer.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.chkBuzzer.Location = new System.Drawing.Point(251, 221);
            this.chkBuzzer.Name = "chkBuzzer";
            this.chkBuzzer.Size = new System.Drawing.Size(100, 28);
            this.chkBuzzer.TabIndex = 30;
            this.chkBuzzer.Text = "Enbaled";
            this.chkBuzzer.UseVisualStyleBackColor = true;
            this.chkBuzzer.CheckedChanged += new System.EventHandler(this.ChkBuzzer_CheckedChanged);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.label9.Location = new System.Drawing.Point(172, 221);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(73, 24);
            this.label9.TabIndex = 29;
            this.label9.Text = "Buzzer:";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.label8.Location = new System.Drawing.Point(66, 160);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(179, 24);
            this.label8.TabIndex = 28;
            this.label8.Text = "Similarity Threshold:";
            // 
            // configurationLog
            // 
            this.configurationLog.Font = new System.Drawing.Font("Microsoft Sans Serif", 12.25F);
            this.configurationLog.Location = new System.Drawing.Point(17, 402);
            this.configurationLog.Name = "configurationLog";
            this.configurationLog.Size = new System.Drawing.Size(601, 142);
            this.configurationLog.TabIndex = 27;
            this.configurationLog.Text = "";
            this.configurationLog.TextChanged += new System.EventHandler(this.ConfigurationLog_TextChanged);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F);
            this.label7.Location = new System.Drawing.Point(165, 88);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(80, 24);
            this.label7.TabIndex = 26;
            this.label7.Text = "Min Var:";
            // 
            // minVarTrack
            // 
            this.minVarTrack.LargeChange = 1;
            this.minVarTrack.Location = new System.Drawing.Point(251, 78);
            this.minVarTrack.Minimum = 1;
            this.minVarTrack.Name = "minVarTrack";
            this.minVarTrack.Size = new System.Drawing.Size(149, 45);
            this.minVarTrack.TabIndex = 0;
            this.minVarTrack.Value = 2;
            this.minVarTrack.ValueChanged += new System.EventHandler(this.MinVarTrack_ValueChanged);
            // 
            // updateFileDialog
            // 
            this.updateFileDialog.FileName = "iDBio.zip";
            this.updateFileDialog.Filter = "Update Files|*.zip";
            this.updateFileDialog.Title = "Select an update file";
            // 
            // Example
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.ClientSize = new System.Drawing.Size(643, 579);
            this.Controls.Add(this.tabControl1);
            this.Name = "Example";
            this.Text = "iDBio Example";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.CaptureExample_FormClosed);
            this.Load += new System.EventHandler(this.Example_Load);
            this.tabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.tabPage1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.fingerImage)).EndInit();
            this.tabPage2.ResumeLayout(false);
            this.tabPage2.PerformLayout();
            this.tabPage3.ResumeLayout(false);
            this.tabPage3.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.minVarTrack)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.ComponentModel.BackgroundWorker backgroundWorker1;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.PictureBox fingerImage;
        private System.Windows.Forms.Button captureBtn;
        private System.Windows.Forms.Button checkBtn;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox VersionTextBox;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox SerialTextBox;
        private System.Windows.Forms.RichTextBox captureLog;
        private System.Windows.Forms.TextBox ModelTextBox;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ListView iDsList;
        private System.Windows.Forms.RichTextBox IdentifyLog;
        private System.Windows.Forms.Button readAllBtn;
        private System.Windows.Forms.Button enrollBtn;
        private System.Windows.Forms.Button IdentifyBtn;
        private System.Windows.Forms.Button deleteAllBtn;
        private System.Windows.Forms.TextBox identifyTextBox;
        private System.Windows.Forms.TextBox enrollIDTextBox;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.OpenFileDialog updateFileDialog;
        private System.Windows.Forms.Button openUpdateFilebtn;
        private System.Windows.Forms.TabPage tabPage3;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.RichTextBox configurationLog;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TrackBar minVarTrack;
        private System.Windows.Forms.CheckBox chkAutomatic;
        private System.Windows.Forms.TextBox textBoxThreshold;
        private System.Windows.Forms.CheckBox chkBuzzer;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Button btnConfigDefault;
    }
}

