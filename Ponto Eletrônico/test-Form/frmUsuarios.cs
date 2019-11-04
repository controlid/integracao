using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;

using System.Text;
using System.Windows.Forms;
using System.IO;
using Controlid;

namespace TesteRepCid
{
	public partial class frmUsuarios : Form
	{

		DataTable tbUsuarios;

		public frmUsuarios()
		{
			InitializeComponent();
		}

		private void frmUsuarios_Activated(object sender, EventArgs e)
		{
			if (tbUsuarios == null)
				LoadUsuarios();
		}

		private void LoadUsuarios()
		{
			stInfo.Text = "Lendo REP...";
			Application.DoEvents();

			RepCid _rep = ((frmMain)this.Owner).REP;
			if (_rep != null)
			{
				int num_usuarios;
				if (_rep.CarregarUsuarios(false, out num_usuarios))
				{
					gv.DataSource = tbUsuarios = _rep.Usuarios;
					if (tbUsuarios != null)
						stInfo.Text = "Lido " + tbUsuarios.Rows.Count + " Funcionários";
				}
			}
		}

		private void btnSave_Click(object sender, EventArgs e)
		{
			DataRow row;
			int nTotal = 0;
			for (int i = 0; i < tbUsuarios.Rows.Count; i++)
			{
				row = tbUsuarios.Rows[i];
				if (row.RowState == DataRowState.Deleted || row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
					nTotal++;
			}
			if (nTotal == 0)
				return;

			frmMain m = (frmMain)this.Owner;
			stProgress.Value = 0;
			stProgress.Maximum = nTotal;
			stProgress.Visible = true;

			nTotal = 0;
			bool lOK;
			RepCid _rep = m.REP;

			string cPIS;
			string cNome;
			int nCodigo;
			string cSenha;
			string cBarras;
			int nRFID;
			int priv;

			for (int i = 0; i < tbUsuarios.Rows.Count; i++)
			{
				row = tbUsuarios.Rows[i];
				if (row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
				{
					stInfo.Text = "Gravando PIS: " + row["PIS"].ToString();
					stProgress.Value = ++nTotal;

					cPIS = row["PIS"].ToString();
					cNome = (string)row["Nome"];

					if (cPIS == "" || cNome == "")
					{
						row.Delete();
						i--;
						continue;
					}

					if (row["Codigo"] != DBNull.Value)
						nCodigo = Convert.ToInt32(row["Codigo"]);
					else
						nCodigo = 0;

					if (row["Senha"] != DBNull.Value)
						cSenha = row["Senha"].ToString();
					else
						cSenha = "";

					if (row["Barras"] != DBNull.Value)
						cBarras = row["Barras"].ToString();
					else
						cBarras = "";

					if (row["rfID"] != DBNull.Value)
						nRFID = Convert.ToInt32(row["rfID"]);
					else
						nRFID = 0;

					if (row["PRIV"] != DBNull.Value)
						priv = Convert.ToByte(row["PRIV"]);
					else
						priv = 0;

					_rep.GravarUsuario(Convert.ToInt64(cPIS), cNome, nCodigo, cSenha, cBarras, nRFID, priv, out lOK);
					string log;
					if (!_rep.GetLastLog(out log))
						log = "";
					stInfo.Text += " OK " + log;

					row.AcceptChanges();
					Application.DoEvents();
				}
				else if (row.RowState == DataRowState.Deleted)
				{
					row.RejectChanges();
					if (_rep.RemoverUsuario(Convert.ToInt64(row["PIS"]), out lOK))
					{
						stProgress.Value = ++nTotal;
						string log;
						if (!_rep.GetLastLog(out log))
							log = "";
						stInfo.Text += " REMOVIDO " + log;
						row.Delete();
						row.AcceptChanges();
						i--;
					}
				}
			}

			_rep.Desconectar();

			stInfo.Text = "Atualizado " + nTotal + " usuário" + (nTotal > 0 ? "s" : "");
			if (nTotal < stProgress.Maximum)
				stInfo.Text += " Erros: " + (stProgress.Maximum - nTotal);
			else
				stProgress.Visible = false;
		}

		private void gv_RowHeaderMouseDoubleClick(object sender, DataGridViewCellMouseEventArgs e)
		{
			frmUser frm = new frmUser();
			frm.PIS = tbUsuarios.Rows[e.RowIndex]["PIS"].ToString();
			frm.ShowDialog(this.Owner);
			LoadUsuarios();
		}

        private void frmUsuarios_Load(object sender, EventArgs e)
        {

        }
	}
}
