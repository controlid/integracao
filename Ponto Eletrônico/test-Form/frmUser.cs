using Controlid;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace TesteRepCid
{
	public partial class frmUser : Form
	{
		public string PIS;

		public frmUser()
		{
			InitializeComponent();
		}

		private void frmUser_Load(object sender, EventArgs e)
		{
			RepCid _rep = ((frmMain)this.Owner).REP;
			if (_rep != null)
			{
				string cNome, cSenha, cBarras;
				int iCodigo, iRFID;
				int privilegios;
				Int64 pis64;
				if (!Int64.TryParse(PIS, out pis64))
					pis64 = 0;
				_rep.LerDadosUsuario(pis64, out cNome, out iCodigo, out cSenha, out cBarras, out iRFID, out privilegios);

				txtNome.Text = cNome;
				txtPIS.Text = PIS;
				txtSenha.Text = cSenha;
				txtCodigo.Text = iCodigo.ToString();
				txtBarras.Text = cBarras;
				txtRFID.Text = iRFID.ToString();
				if (privilegios < 0)
					ddlPermissao.SelectedIndex = 0;
				else if (privilegios >= ddlPermissao.Items.Count)
					ddlPermissao.SelectedIndex = ddlPermissao.Items.Count - 1;
				else
					ddlPermissao.SelectedIndex = privilegios;

				int num_templates;
				if (_rep.CarregarTemplatesUsuario(Convert.ToInt64(PIS), out num_templates))
				{
					string template_base64;
					txtBiometria.Text = "";
					while (_rep.LerTemplateStr(out template_base64))
					{
						txtBiometria.Text += template_base64 + "\r\n\r\n";
					}
				}
			}
		}

		private void btnSave_Click(object sender, EventArgs e)
		{
			RepCid _rep = ((frmMain)this.Owner).REP;
			if (_rep != null)
			{
				byte privilegios = 0;
				if (ddlPermissao.SelectedIndex >= 0)
					privilegios = (byte)ddlPermissao.SelectedIndex;

				bool lSave;
				_rep.GravarUsuario(Convert.ToInt64(txtPIS.Text), txtNome.Text, int.Parse(txtCodigo.Text), txtSenha.Text, txtBarras.Text, int.Parse(txtRFID.Text), privilegios, out lSave);

				bool apagou;
				_rep.ApagarTemplatesUsuario(Convert.ToInt64(txtPIS.Text), out apagou);
				if (txtBiometria.Text != "")
				{
					string[] cItens = txtBiometria.Text.Split(new char[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
					foreach (string item in cItens)
					{
						byte[] bt = Convert.FromBase64String(item); // apenas a primeira da sequencia
						_rep.GravarTemplateUsuario(Convert.ToInt64(txtPIS.Text), bt, out lSave);
					}
				}

				this.Close();
			}
			else
				MessageBox.Show("Erro");
		}

		private void btnBack_Click(object sender, EventArgs e)
		{
			this.Close();
		}
	}
}
