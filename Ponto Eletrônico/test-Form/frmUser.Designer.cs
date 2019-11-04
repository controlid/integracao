namespace TesteRepCid
{
    partial class frmUser
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
			this.btnSave = new System.Windows.Forms.Button();
			this.txtSenha = new System.Windows.Forms.TextBox();
			this.txtNome = new System.Windows.Forms.TextBox();
			this.txtPIS = new System.Windows.Forms.TextBox();
			this.txtBarras = new System.Windows.Forms.TextBox();
			this.txtCodigo = new System.Windows.Forms.TextBox();
			this.label1 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.label4 = new System.Windows.Forms.Label();
			this.label5 = new System.Windows.Forms.Label();
			this.label6 = new System.Windows.Forms.Label();
			this.txtRFID = new System.Windows.Forms.TextBox();
			this.label7 = new System.Windows.Forms.Label();
			this.txtBiometria = new System.Windows.Forms.TextBox();
			this.ddlPermissao = new System.Windows.Forms.ComboBox();
			this.label8 = new System.Windows.Forms.Label();
			this.btnBack = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// btnSave
			// 
			this.btnSave.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.btnSave.Location = new System.Drawing.Point(170, 358);
			this.btnSave.Name = "btnSave";
			this.btnSave.Size = new System.Drawing.Size(75, 23);
			this.btnSave.TabIndex = 0;
			this.btnSave.Text = "Salvar";
			this.btnSave.UseVisualStyleBackColor = true;
			this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
			// 
			// txtSenha
			// 
			this.txtSenha.Location = new System.Drawing.Point(145, 103);
			this.txtSenha.Name = "txtSenha";
			this.txtSenha.Size = new System.Drawing.Size(38, 20);
			this.txtSenha.TabIndex = 1;
			// 
			// txtNome
			// 
			this.txtNome.Location = new System.Drawing.Point(15, 25);
			this.txtNome.Name = "txtNome";
			this.txtNome.Size = new System.Drawing.Size(116, 20);
			this.txtNome.TabIndex = 2;
			// 
			// txtPIS
			// 
			this.txtPIS.Location = new System.Drawing.Point(15, 64);
			this.txtPIS.Name = "txtPIS";
			this.txtPIS.Size = new System.Drawing.Size(116, 20);
			this.txtPIS.TabIndex = 3;
			// 
			// txtBarras
			// 
			this.txtBarras.Location = new System.Drawing.Point(145, 64);
			this.txtBarras.Name = "txtBarras";
			this.txtBarras.Size = new System.Drawing.Size(100, 20);
			this.txtBarras.TabIndex = 4;
			// 
			// txtCodigo
			// 
			this.txtCodigo.Location = new System.Drawing.Point(208, 104);
			this.txtCodigo.Name = "txtCodigo";
			this.txtCodigo.Size = new System.Drawing.Size(37, 20);
			this.txtCodigo.TabIndex = 5;
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Location = new System.Drawing.Point(12, 9);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(38, 13);
			this.label1.TabIndex = 6;
			this.label1.Text = "Nome:";
			// 
			// label2
			// 
			this.label2.AutoSize = true;
			this.label2.Location = new System.Drawing.Point(205, 88);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(43, 13);
			this.label2.TabIndex = 7;
			this.label2.Text = "Codigo:";
			// 
			// label3
			// 
			this.label3.AutoSize = true;
			this.label3.Location = new System.Drawing.Point(142, 87);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(41, 13);
			this.label3.TabIndex = 8;
			this.label3.Text = "Senha:";
			// 
			// label4
			// 
			this.label4.AutoSize = true;
			this.label4.Location = new System.Drawing.Point(142, 48);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(40, 13);
			this.label4.TabIndex = 9;
			this.label4.Text = "Barras:";
			// 
			// label5
			// 
			this.label5.AutoSize = true;
			this.label5.Location = new System.Drawing.Point(12, 48);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(27, 13);
			this.label5.TabIndex = 10;
			this.label5.Text = "PIS:";
			// 
			// label6
			// 
			this.label6.AutoSize = true;
			this.label6.Location = new System.Drawing.Point(142, 9);
			this.label6.Name = "label6";
			this.label6.Size = new System.Drawing.Size(35, 13);
			this.label6.TabIndex = 12;
			this.label6.Text = "RFID:";
			// 
			// txtRFID
			// 
			this.txtRFID.Location = new System.Drawing.Point(145, 25);
			this.txtRFID.Name = "txtRFID";
			this.txtRFID.Size = new System.Drawing.Size(100, 20);
			this.txtRFID.TabIndex = 11;
			// 
			// label7
			// 
			this.label7.AutoSize = true;
			this.label7.Location = new System.Drawing.Point(12, 127);
			this.label7.Name = "label7";
			this.label7.Size = new System.Drawing.Size(50, 13);
			this.label7.TabIndex = 14;
			this.label7.Text = "Biometria";
			// 
			// txtBiometria
			// 
			this.txtBiometria.AcceptsReturn = true;
			this.txtBiometria.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
						| System.Windows.Forms.AnchorStyles.Left)
						| System.Windows.Forms.AnchorStyles.Right)));
			this.txtBiometria.Location = new System.Drawing.Point(15, 143);
			this.txtBiometria.Multiline = true;
			this.txtBiometria.Name = "txtBiometria";
			this.txtBiometria.ScrollBars = System.Windows.Forms.ScrollBars.Both;
			this.txtBiometria.Size = new System.Drawing.Size(230, 209);
			this.txtBiometria.TabIndex = 13;
			// 
			// ddlPermissao
			// 
			this.ddlPermissao.FormattingEnabled = true;
			this.ddlPermissao.Items.AddRange(new object[] {
            "Usuário",
            "Administrador"});
			this.ddlPermissao.Location = new System.Drawing.Point(15, 103);
			this.ddlPermissao.Name = "ddlPermissao";
			this.ddlPermissao.Size = new System.Drawing.Size(116, 21);
			this.ddlPermissao.TabIndex = 15;
			// 
			// label8
			// 
			this.label8.AutoSize = true;
			this.label8.Location = new System.Drawing.Point(12, 87);
			this.label8.Name = "label8";
			this.label8.Size = new System.Drawing.Size(58, 13);
			this.label8.TabIndex = 8;
			this.label8.Text = "Permissão:";
			// 
			// btnBack
			// 
			this.btnBack.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.btnBack.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.btnBack.Location = new System.Drawing.Point(15, 358);
			this.btnBack.Name = "btnBack";
			this.btnBack.Size = new System.Drawing.Size(75, 23);
			this.btnBack.TabIndex = 16;
			this.btnBack.Text = "Voltar";
			this.btnBack.UseVisualStyleBackColor = true;
			this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
			// 
			// frmUser
			// 
			this.AcceptButton = this.btnSave;
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.CancelButton = this.btnBack;
			this.ClientSize = new System.Drawing.Size(254, 393);
			this.Controls.Add(this.btnBack);
			this.Controls.Add(this.ddlPermissao);
			this.Controls.Add(this.label7);
			this.Controls.Add(this.txtBiometria);
			this.Controls.Add(this.label6);
			this.Controls.Add(this.txtRFID);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.label8);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.txtCodigo);
			this.Controls.Add(this.txtBarras);
			this.Controls.Add(this.txtPIS);
			this.Controls.Add(this.txtNome);
			this.Controls.Add(this.txtSenha);
			this.Controls.Add(this.btnSave);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
			this.Name = "frmUser";
			this.Text = "Edição do Usuário";
			this.Load += new System.EventHandler(this.frmUser_Load);
			this.ResumeLayout(false);
			this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.TextBox txtSenha;
        private System.Windows.Forms.TextBox txtNome;
        private System.Windows.Forms.TextBox txtPIS;
        private System.Windows.Forms.TextBox txtBarras;
        private System.Windows.Forms.TextBox txtCodigo;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txtRFID;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox txtBiometria;
        private System.Windows.Forms.ComboBox ddlPermissao;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Button btnBack;
    }
}