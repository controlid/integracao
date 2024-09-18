namespace idAccess_Rest
{
    partial class Form1
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
            this.label2 = new System.Windows.Forms.Label();
            this.txtLogs = new System.Windows.Forms.TextBox();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.cadastros = new System.Windows.Forms.ToolStripMenuItem();
            this.cadastrarUsuárioToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.terminalToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.consultas = new System.Windows.Forms.ToolStripMenuItem();
            this.usuariosCadastradosToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.logsDeAcessoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.listarCartõesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.formasdeconexao = new System.Windows.Forms.ToolStripMenuItem();
            this.setarOnlineToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.setarOfflineToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.utilidades = new System.Windows.Forms.ToolStripMenuItem();
            this.atualizarDataEHoraToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.abrirPortaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.catracaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.acessoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.exemploDeConversãoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.nomeExibiçãoDoAcessoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(22, 54);
            this.label2.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(137, 20);
            this.label2.TabIndex = 5;
            this.label2.Text = "Logs de Conexão:";
            // 
            // txtLogs
            // 
            this.txtLogs.Enabled = false;
            this.txtLogs.Location = new System.Drawing.Point(18, 85);
            this.txtLogs.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.txtLogs.Multiline = true;
            this.txtLogs.Name = "txtLogs";
            this.txtLogs.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtLogs.Size = new System.Drawing.Size(673, 690);
            this.txtLogs.TabIndex = 6;
            // 
            // menuStrip1
            // 
            this.menuStrip1.GripMargin = new System.Windows.Forms.Padding(2, 2, 0, 2);
            this.menuStrip1.ImageScalingSize = new System.Drawing.Size(24, 24);
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.cadastros,
            this.consultas,
            this.formasdeconexao,
            this.utilidades});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(712, 33);
            this.menuStrip1.TabIndex = 18;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // cadastros
            // 
            this.cadastros.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.cadastrarUsuárioToolStripMenuItem,
            this.terminalToolStripMenuItem});
            this.cadastros.Name = "cadastros";
            this.cadastros.Size = new System.Drawing.Size(107, 29);
            this.cadastros.Text = "Cadastros";
            // 
            // cadastrarUsuárioToolStripMenuItem
            // 
            this.cadastrarUsuárioToolStripMenuItem.Name = "cadastrarUsuárioToolStripMenuItem";
            this.cadastrarUsuárioToolStripMenuItem.Size = new System.Drawing.Size(179, 34);
            this.cadastrarUsuárioToolStripMenuItem.Text = "Usuário";
            this.cadastrarUsuárioToolStripMenuItem.Click += new System.EventHandler(this.cadastrarUsuárioToolStripMenuItem_Click);
            // 
            // terminalToolStripMenuItem
            // 
            this.terminalToolStripMenuItem.Name = "terminalToolStripMenuItem";
            this.terminalToolStripMenuItem.Size = new System.Drawing.Size(179, 34);
            this.terminalToolStripMenuItem.Text = "Terminal";
            this.terminalToolStripMenuItem.Click += new System.EventHandler(this.terminalToolStripMenuItem_Click);
            // 
            // consultas
            // 
            this.consultas.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.usuariosCadastradosToolStripMenuItem,
            this.logsDeAcessoToolStripMenuItem,
            this.listarCartõesToolStripMenuItem});
            this.consultas.Name = "consultas";
            this.consultas.Size = new System.Drawing.Size(105, 29);
            this.consultas.Text = "Consultas";
            // 
            // usuariosCadastradosToolStripMenuItem
            // 
            this.usuariosCadastradosToolStripMenuItem.Name = "usuariosCadastradosToolStripMenuItem";
            this.usuariosCadastradosToolStripMenuItem.Size = new System.Drawing.Size(228, 34);
            this.usuariosCadastradosToolStripMenuItem.Text = "Listar Usuarios";
            this.usuariosCadastradosToolStripMenuItem.Click += new System.EventHandler(this.usuariosCadastradosToolStripMenuItem_Click);
            // 
            // logsDeAcessoToolStripMenuItem
            // 
            this.logsDeAcessoToolStripMenuItem.Name = "logsDeAcessoToolStripMenuItem";
            this.logsDeAcessoToolStripMenuItem.Size = new System.Drawing.Size(228, 34);
            this.logsDeAcessoToolStripMenuItem.Text = "Listar Logs";
            this.logsDeAcessoToolStripMenuItem.Click += new System.EventHandler(this.logsDeAcessoToolStripMenuItem_Click);
            // 
            // listarCartõesToolStripMenuItem
            // 
            this.listarCartõesToolStripMenuItem.Name = "listarCartõesToolStripMenuItem";
            this.listarCartõesToolStripMenuItem.Size = new System.Drawing.Size(228, 34);
            this.listarCartõesToolStripMenuItem.Text = "Listar Cartões";
            this.listarCartõesToolStripMenuItem.Click += new System.EventHandler(this.listarCartõesToolStripMenuItem_Click);
            // 
            // formasdeconexao
            // 
            this.formasdeconexao.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.setarOnlineToolStripMenuItem,
            this.setarOfflineToolStripMenuItem});
            this.formasdeconexao.Name = "formasdeconexao";
            this.formasdeconexao.Size = new System.Drawing.Size(186, 29);
            this.formasdeconexao.Text = "Formas de Conexao";
            // 
            // setarOnlineToolStripMenuItem
            // 
            this.setarOnlineToolStripMenuItem.Name = "setarOnlineToolStripMenuItem";
            this.setarOnlineToolStripMenuItem.Size = new System.Drawing.Size(212, 34);
            this.setarOnlineToolStripMenuItem.Text = "Setar Online";
            this.setarOnlineToolStripMenuItem.Click += new System.EventHandler(this.setarOnlineToolStripMenuItem_Click);
            // 
            // setarOfflineToolStripMenuItem
            // 
            this.setarOfflineToolStripMenuItem.Name = "setarOfflineToolStripMenuItem";
            this.setarOfflineToolStripMenuItem.Size = new System.Drawing.Size(212, 34);
            this.setarOfflineToolStripMenuItem.Text = "Setar Offline";
            this.setarOfflineToolStripMenuItem.Click += new System.EventHandler(this.setarOfflineToolStripMenuItem_Click);
            // 
            // utilidades
            // 
            this.utilidades.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.atualizarDataEHoraToolStripMenuItem,
            this.abrirPortaToolStripMenuItem,
            this.exemploDeConversãoToolStripMenuItem,
            this.nomeExibiçãoDoAcessoToolStripMenuItem});
            this.utilidades.Name = "utilidades";
            this.utilidades.Size = new System.Drawing.Size(106, 29);
            this.utilidades.Text = "Utilidades";
            // 
            // atualizarDataEHoraToolStripMenuItem
            // 
            this.atualizarDataEHoraToolStripMenuItem.Name = "atualizarDataEHoraToolStripMenuItem";
            this.atualizarDataEHoraToolStripMenuItem.Size = new System.Drawing.Size(320, 34);
            this.atualizarDataEHoraToolStripMenuItem.Text = "Atualizar Data e Hora";
            this.atualizarDataEHoraToolStripMenuItem.Click += new System.EventHandler(this.atualizarDataEHoraToolStripMenuItem_Click);
            // 
            // abrirPortaToolStripMenuItem
            // 
            this.abrirPortaToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.catracaToolStripMenuItem,
            this.acessoToolStripMenuItem});
            this.abrirPortaToolStripMenuItem.Name = "abrirPortaToolStripMenuItem";
            this.abrirPortaToolStripMenuItem.Size = new System.Drawing.Size(320, 34);
            this.abrirPortaToolStripMenuItem.Text = "Liberar Acesso";
            this.abrirPortaToolStripMenuItem.Click += new System.EventHandler(this.acessoToolStripMenuItem_Click);
            // 
            // catracaToolStripMenuItem
            // 
            this.catracaToolStripMenuItem.Name = "catracaToolStripMenuItem";
            this.catracaToolStripMenuItem.Size = new System.Drawing.Size(172, 34);
            this.catracaToolStripMenuItem.Text = "Catraca";
            this.catracaToolStripMenuItem.Click += new System.EventHandler(this.catracaToolStripMenuItem_Click);
            // 
            // acessoToolStripMenuItem
            // 
            this.acessoToolStripMenuItem.Name = "acessoToolStripMenuItem";
            this.acessoToolStripMenuItem.Size = new System.Drawing.Size(172, 34);
            this.acessoToolStripMenuItem.Text = "Acesso";
            this.acessoToolStripMenuItem.Click += new System.EventHandler(this.acessoToolStripMenuItem_Click);
            // 
            // exemploDeConversãoToolStripMenuItem
            // 
            this.exemploDeConversãoToolStripMenuItem.Name = "exemploDeConversãoToolStripMenuItem";
            this.exemploDeConversãoToolStripMenuItem.Size = new System.Drawing.Size(320, 34);
            this.exemploDeConversãoToolStripMenuItem.Text = "Conversão Wiegand";
            this.exemploDeConversãoToolStripMenuItem.Click += new System.EventHandler(this.exemploDeConversãoToolStripMenuItem_Click);
            // 
            // nomeExibiçãoDoAcessoToolStripMenuItem
            // 
            this.nomeExibiçãoDoAcessoToolStripMenuItem.Name = "nomeExibiçãoDoAcessoToolStripMenuItem";
            this.nomeExibiçãoDoAcessoToolStripMenuItem.Size = new System.Drawing.Size(320, 34);
            this.nomeExibiçãoDoAcessoToolStripMenuItem.Text = "Nome exibição do Acesso";
            this.nomeExibiçãoDoAcessoToolStripMenuItem.Click += new System.EventHandler(this.nomeExibiçãoDoAcessoToolStripMenuItem_Click);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(18, 786);
            this.button1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(206, 57);
            this.button1.TabIndex = 19;
            this.button1.Text = "Limpar Logs";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(560, 34);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(131, 40);
            this.button2.TabIndex = 20;
            this.button2.Text = "Iniciar Servidor";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(712, 862);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.txtLogs);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.menuStrip1);
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Exemplo de integração";
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtLogs;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem cadastros;
        private System.Windows.Forms.ToolStripMenuItem cadastrarUsuárioToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem consultas;
        private System.Windows.Forms.ToolStripMenuItem formasdeconexao;
        private System.Windows.Forms.ToolStripMenuItem usuariosCadastradosToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem logsDeAcessoToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem setarOnlineToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem setarOfflineToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem utilidades;
        private System.Windows.Forms.ToolStripMenuItem atualizarDataEHoraToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem abrirPortaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem exemploDeConversãoToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem listarCartõesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem catracaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem acessoToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem nomeExibiçãoDoAcessoToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem terminalToolStripMenuItem;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
    }
}

