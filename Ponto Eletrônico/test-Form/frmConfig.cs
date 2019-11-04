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
	public partial class frmConfig : Form
	{
		public frmConfig()
		{
			InitializeComponent();
			grpLoad.Location = new Point(11, 12);

			System.Globalization.CultureInfo customCulture = (System.Globalization.CultureInfo)System.Threading.Thread.CurrentThread.CurrentCulture.Clone();
			customCulture.NumberFormat.NumberDecimalSeparator = ".";

			System.Threading.Thread.CurrentThread.CurrentCulture = customCulture;
		}

		RepCid _rep;
		private void frmConfig_Load(object sender, EventArgs e)
		{
			_rep = ((frmMain)this.Owner).REP;
			load.RunWorkerAsync(_rep);
		}

		string cInfo;
		string cData;
		int hVeraoIAno = 0, hVeraoIMes = 0, hVeraoIDia = 0;
		int hVeraoFAno = 0, hVeraoFMes = 0, hVeraoFDia = 0;

		int emp_tipodoc;
		string emp_doc;
		string emp_cei;
		string emp_razsoc;
		string emp_end;

		string eth_ip;
		string eth_nmask;
		string eth_gw;
		ushort eth_port;

		private void load_DoWork(object sender, DoWorkEventArgs e)
		{
			try
			{
				if (_rep != null)
				{
					// Data e Hora atual
					int ano, mes, dia, hora, minuto, segundo;
					if (!_rep.LerDataHora(out ano, out mes, out dia, out hora, out minuto, out segundo))
						ano = mes = dia = hora = minuto = segundo = 0;
					cData = new DateTime(ano, mes, dia, hora, minuto, segundo).ToString("dd/MM/yyyy HH:mm:ss");

                    // Horario de Verão
                    _rep.LerConfigHVerao(out hVeraoIAno, out hVeraoIMes, out hVeraoIDia,
                        out hVeraoFAno, out hVeraoFMes, out hVeraoFDia);

                    // Empregador
                    _rep.LerEmpregador(out emp_doc, out emp_tipodoc, out emp_cei, out emp_razsoc, out emp_end);

                    // Ethernet
                    _rep.LerConfigRede(out eth_ip, out eth_nmask, out eth_gw, out eth_port);

					cInfo = "OK";
				}
				else
					throw new Exception("Erro ao conectar-se com o REP");
			}
			catch (Exception ex)
			{
				cInfo = "ERRO: \r\n" + ex.Message;
			}

		}

		private void load_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
		{
			if (cInfo != "OK")
				lblInfo.Text = cInfo;
			else
			{
				txtData.Text = cData.Split(' ')[0];
				txtHora.Text = cData.Split(' ')[1];

				// Horario de Verão

				DateTime today = DateTime.Now.Date;
				if (hVeraoIAno > 0)
				{
					chkVeraoIni.Checked = true;
					dtpVeraoInicio.Value = new DateTime(hVeraoIAno, hVeraoIMes, hVeraoIDia);
				}
				else
				{
					chkVeraoIni.Checked = false;
					dtpVeraoInicio.Value = today;
				}

				if (hVeraoFAno > 0)
				{
					chkVeraoFim.Checked = true;
					dtpVeraoFim.Value = new DateTime(hVeraoFAno, hVeraoFMes, hVeraoFDia);
				}
				else
				{
					chkVeraoFim.Checked = false;
					dtpVeraoFim.Value = today;
				}

				// Empregador
				txtCPFCNPJ.Text = emp_doc;
				txtCEI.Text = emp_cei;
				txtEndereco.Text = emp_end;
				txtRazaoSocial.Text = emp_razsoc;

				// Ethernet
				txtIP.Text = FormatIP(eth_ip);
                nudPort.Value = eth_port;
                txtMascara.Text = FormatIP(eth_nmask);
				txtGateway.Text = FormatIP(eth_gw);

				grpLoad.Visible = false;
			}
		}

        private string FormatIP(string ip)
        {
            string [] c=ip.Split('.');
            if(c.Length!=4)
                return "";
            
            return string.Format("{0:000}.{1:000}.{2:000}.{3:000}", 
                int.Parse(c[0]),int.Parse(c[1]),int.Parse(c[2]),int.Parse(c[3]));
        }

		private void btnNow_Click(object sender, EventArgs e)
		{
			cData = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
			txtData.Text = cData.Split(' ')[0];
			txtHora.Text = cData.Split(' ')[1];
		}

		private void btnSave_Click(object sender, EventArgs e)
		{
			string cErro = "";
			try
			{
				_rep = ((frmMain)this.Owner).REP;
				if (_rep != null)
				{
					Button btn = (Button)sender;

					if (btn.Name == btnHorario.Name)
					{
						// Data e Horario de Verão
						if (!_rep.GravarDataHora(DateTime.Parse(txtData.Text).Add(TimeSpan.Parse(txtHora.Text))))
							cErro += "\r\nErro ao atualizar a Data e Hora";

						int iano = 0, imes = 0, idia = 0;
						int fano = 0, fmes = 0, fdia = 0;

						if (chkVeraoIni.Checked)
						{
							iano = dtpVeraoInicio.Value.Year;
							imes = dtpVeraoInicio.Value.Month;
							idia = dtpVeraoInicio.Value.Day;
						}
						if (chkVeraoFim.Checked)
						{
							fano = dtpVeraoFim.Value.Year;
							fmes = dtpVeraoFim.Value.Month;
							fdia = dtpVeraoFim.Value.Day;
						}

						if (hVeraoIAno != iano ||
							hVeraoIMes != imes ||
							hVeraoIDia != idia ||
							hVeraoFAno != fano ||
							hVeraoFMes != fmes ||
							hVeraoFDia != fdia)
						{
							bool gravou;
							if (!_rep.GravarConfigHVerao(iano, imes, idia,
								fano, fmes, fdia, out gravou) || !gravou)
								cErro += "\r\nErro ao registrar o Horário de Verão";
						}
					}
					else if (btn.Name == btnEmpresa.Name)
					{
						// Empregador (documento é só os digitos)
						//  CPF: 19221149870    => 11 digitos
						// CNPJ: 05343346000106 => 14 digitos
						// ------12345678901234

						// CIDFS.h (portaria)
						int nTipo = 0;
						if (txtCPFCNPJ.Text.Length == 14)
							nTipo = 1; // CNPJ
						else if (txtCPFCNPJ.Text.Length == 11)
							nTipo = 2; // CPF
						else
							cErro += "\r\nNumero de documento invalido (não é CPF e nem CNPJ)";

						bool gravou;
						if (nTipo > 0 && !(_rep.GravarEmpregador(txtCPFCNPJ.Text, nTipo, txtCEI.Text, txtRazaoSocial.Text, txtEndereco.Text, out gravou) && gravou))
							cErro += "\r\nErro ao atualizar os dados de Empregador";
					}

					else if (btn.Name == btnRede.Name)
					{
						// Ethernet
						bool gravou;
						if (!_rep.GravarConfigRede(txtIP.Text, txtMascara.Text, txtGateway.Text, Convert.ToUInt16(nudPort.Value), out gravou) || !gravou)
							cErro += "\r\nErro ao atualizar as configurações de Rede";
					}
				}
			}
			catch (Exception ex)
			{
				cErro += "\r\n" + "ERRO:" + ex.Message;
			}
			_rep.Desconectar();

			if (cErro != "")
				MessageBox.Show("Hove erros ao registrar as configurações:" + cErro, "ERRO", MessageBoxButtons.OK, MessageBoxIcon.Error);
			else
				MessageBox.Show("REP ATUALIZADO", "Configurações", MessageBoxButtons.OK, MessageBoxIcon.Information);
		}

		private void chkVeraoIni_CheckedChanged(object sender, EventArgs e)
		{
			dtpVeraoInicio.Enabled = chkVeraoIni.Checked;
		}

		private void chkVeraoFim_CheckedChanged(object sender, EventArgs e)
		{
			dtpVeraoFim.Enabled = chkVeraoFim.Checked;
		}
	}
}
