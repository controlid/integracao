namespace TesteRepCid
{
    partial class frmUsuarios
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmUsuarios));
            this.gv = new System.Windows.Forms.DataGridView();
            this.dgvcNome = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dgvcPIS = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dgvcCodigo = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dgvcSenha = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dgvcBarras = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dgvcRFID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dgvcPriv = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dgvcNumDig = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ts = new System.Windows.Forms.ToolStrip();
            this.btnSave = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator = new System.Windows.Forms.ToolStripSeparator();
            this.st = new System.Windows.Forms.StatusStrip();
            this.stInfo = new System.Windows.Forms.ToolStripStatusLabel();
            this.stProgress = new System.Windows.Forms.ToolStripProgressBar();
            this.ofd = new System.Windows.Forms.OpenFileDialog();
            this.sfd = new System.Windows.Forms.SaveFileDialog();
            ((System.ComponentModel.ISupportInitialize)(this.gv)).BeginInit();
            this.ts.SuspendLayout();
            this.st.SuspendLayout();
            this.SuspendLayout();
            // 
            // gv
            // 
            this.gv.AllowUserToOrderColumns = true;
            this.gv.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.gv.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.gv.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gv.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.dgvcNome,
            this.dgvcPIS,
            this.dgvcCodigo,
            this.dgvcSenha,
            this.dgvcBarras,
            this.dgvcRFID,
            this.dgvcPriv,
            this.dgvcNumDig});
            this.gv.DataMember = "usuarios";
            this.gv.Location = new System.Drawing.Point(0, 28);
            this.gv.Name = "gv";
            this.gv.Size = new System.Drawing.Size(484, 212);
            this.gv.TabIndex = 0;
            this.gv.RowHeaderMouseDoubleClick += new System.Windows.Forms.DataGridViewCellMouseEventHandler(this.gv_RowHeaderMouseDoubleClick);
            // 
            // dgvcNome
            // 
            this.dgvcNome.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.dgvcNome.DataPropertyName = "Nome";
            this.dgvcNome.HeaderText = "Nome";
            this.dgvcNome.Name = "dgvcNome";
            // 
            // dgvcPIS
            // 
            this.dgvcPIS.DataPropertyName = "PIS";
            this.dgvcPIS.HeaderText = "PIS";
            this.dgvcPIS.Name = "dgvcPIS";
            // 
            // dgvcCodigo
            // 
            this.dgvcCodigo.DataPropertyName = "Codigo";
            this.dgvcCodigo.HeaderText = "Codigo";
            this.dgvcCodigo.Name = "dgvcCodigo";
            // 
            // dgvcSenha
            // 
            this.dgvcSenha.DataPropertyName = "Senha";
            this.dgvcSenha.HeaderText = "Senha";
            this.dgvcSenha.Name = "dgvcSenha";
            // 
            // dgvcBarras
            // 
            this.dgvcBarras.DataPropertyName = "Barras";
            this.dgvcBarras.HeaderText = "Barras";
            this.dgvcBarras.Name = "dgvcBarras";
            // 
            // dgvcRFID
            // 
            this.dgvcRFID.DataPropertyName = "RFID";
            this.dgvcRFID.HeaderText = "RFID";
            this.dgvcRFID.Name = "dgvcRFID";
            // 
            // dgvcPriv
            // 
            this.dgvcPriv.DataPropertyName = "PRIV";
            this.dgvcPriv.HeaderText = "Privilégio";
            this.dgvcPriv.Name = "dgvcPriv";
            // 
            // dgvcNumDig
            // 
            this.dgvcNumDig.DataPropertyName = "Num_Dig";
            this.dgvcNumDig.HeaderText = "Num. Dig.";
            this.dgvcNumDig.Name = "dgvcNumDig";
            this.dgvcNumDig.ReadOnly = true;
            // 
            // ts
            // 
            this.ts.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.btnSave,
            this.toolStripSeparator});
            this.ts.Location = new System.Drawing.Point(0, 0);
            this.ts.Name = "ts";
            this.ts.Size = new System.Drawing.Size(484, 25);
            this.ts.TabIndex = 1;
            this.ts.Text = "toolStrip1";
            // 
            // btnSave
            // 
            this.btnSave.Image = ((System.Drawing.Image)(resources.GetObject("btnSave.Image")));
            this.btnSave.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(98, 22);
            this.btnSave.Text = "&Salvar no REP";
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // toolStripSeparator
            // 
            this.toolStripSeparator.Name = "toolStripSeparator";
            this.toolStripSeparator.Size = new System.Drawing.Size(6, 25);
            // 
            // st
            // 
            this.st.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.stInfo,
            this.stProgress});
            this.st.Location = new System.Drawing.Point(0, 240);
            this.st.Name = "st";
            this.st.Size = new System.Drawing.Size(484, 22);
            this.st.TabIndex = 2;
            // 
            // stInfo
            // 
            this.stInfo.AutoSize = false;
            this.stInfo.Name = "stInfo";
            this.stInfo.Size = new System.Drawing.Size(330, 17);
            this.stInfo.Text = "OK";
            this.stInfo.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // stProgress
            // 
            this.stProgress.Alignment = System.Windows.Forms.ToolStripItemAlignment.Right;
            this.stProgress.Name = "stProgress";
            this.stProgress.Size = new System.Drawing.Size(100, 16);
            this.stProgress.Visible = false;
            // 
            // frmUsuarios
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(484, 262);
            this.Controls.Add(this.st);
            this.Controls.Add(this.ts);
            this.Controls.Add(this.gv);
            this.MinimumSize = new System.Drawing.Size(500, 300);
            this.Name = "frmUsuarios";
            this.Text = "Usuários";
            this.Activated += new System.EventHandler(this.frmUsuarios_Activated);
            this.Load += new System.EventHandler(this.frmUsuarios_Load);
            ((System.ComponentModel.ISupportInitialize)(this.gv)).EndInit();
            this.ts.ResumeLayout(false);
            this.ts.PerformLayout();
            this.st.ResumeLayout(false);
            this.st.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

		private System.Windows.Forms.ToolStrip ts;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator;
        private System.Windows.Forms.ToolStripButton btnSave;
        private System.Windows.Forms.DataGridView gv;
        private System.Windows.Forms.StatusStrip st;
        private System.Windows.Forms.ToolStripStatusLabel stInfo;
		private System.Windows.Forms.ToolStripProgressBar stProgress;
		private System.Windows.Forms.OpenFileDialog ofd;
		private System.Windows.Forms.DataGridViewTextBoxColumn dgvcNome;
		private System.Windows.Forms.DataGridViewTextBoxColumn dgvcPIS;
		private System.Windows.Forms.DataGridViewTextBoxColumn dgvcCodigo;
		private System.Windows.Forms.DataGridViewTextBoxColumn dgvcSenha;
		private System.Windows.Forms.DataGridViewTextBoxColumn dgvcBarras;
		private System.Windows.Forms.DataGridViewTextBoxColumn dgvcRFID;
		private System.Windows.Forms.DataGridViewTextBoxColumn dgvcPriv;
		private System.Windows.Forms.DataGridViewTextBoxColumn dgvcNumDig;
		private System.Windows.Forms.SaveFileDialog sfd;
    }
}