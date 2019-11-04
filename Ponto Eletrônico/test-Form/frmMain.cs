using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;

using System.Text;
using System.Windows.Forms;
using TesteRepCid.Properties;
using System.IO;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Net.Security;
using Controlid;

namespace TesteRepCid
{
    public partial class frmMain : Form
    {
        #region "Inicialização"

        public frmMain()
        {
            InitializeComponent();
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            txtIP.Text = TesteRepCid.Properties.Settings.Default.IP;
            nudPort.Value = TesteRepCid.Properties.Settings.Default.Porta;
            nudPassCode.Value = TesteRepCid.Properties.Settings.Default.PassCode;
        }

        #endregion


        #region "Eventos Click dos Botões"

        private void btnTest_Click(object sender, EventArgs e)
        {
            // Se conseguiu conectar, desconeta! (só para testar a conexão)
            if (Connect(true))
            {
                _rep.Desconectar();
                _rep = null;
            }
        }

        private void btnAFD_Click(object sender, EventArgs e)
        {
            // Se não conseguiu conectar já mostrou mensagem abandona a rotina!
            if (sfd.ShowDialog(this) == System.Windows.Forms.DialogResult.OK)
            {
                if (File.Exists(sfd.FileName))
                    File.Delete(sfd.FileName);
            }
            else
                return;

            if (Connect(false))
            {
                int n = 0;
                try
                {
                    // TODO: rever AFD
                    if (!_rep.BuscarAFD(1))
                    {
                        MessageBox.Show("Sem dados no REP!");
                    }
                    else
                    {
                        using (StreamWriter sw = new StreamWriter(sfd.FileName, false, Encoding.GetEncoding(1252)))
                        {
                            string cLinha;
                            while (_rep.LerAFD(out cLinha))
                            {
                                n++;
                                sw.Write(cLinha);
                                sw.Flush();
                            }
                            sw.Close();
                        }
                    }
                    _rep.Desconectar();
                }
                catch (Exception ex)
                {
                    // Pode dar erro de permição ou IO
                    MessageBox.Show("ERRO: " + ex.Message + "\r\n" + ex.StackTrace);
                }

                if (n == 0)
                    MessageBox.Show("Não foi possivel baixar o AFD", "AFD", MessageBoxButtons.OK, MessageBoxIcon.Error);
                else
                    MessageBox.Show(n + " registros baixados no AFD", "AFD", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnUSR_Click(object sender, EventArgs e)
        {
            if (Connect(false))
            {
                frmUsuarios frm = new frmUsuarios();
                frm.ShowDialog(this);
            }
        }

        private void btnCFG_Click(object sender, EventArgs e)
        {
            if (Connect(false))
            {
                frmConfig frm = new frmConfig();
                frm.ShowDialog(this);
            }
        }

        #endregion

        #region "Conexão"

        RepCid _rep;
        public RepCid REP
        {
            get
            {

                if (Connect(false))
                    return _rep;
                else
                    return null;
            }
        }

        // Tenta efetuar a conexão e define a váriável '_rep' que será encapsulada
        private bool Connect(bool lShowOK)
        {
            if (_rep != null)
                _rep.Desconectar();

            _rep = new RepCid();

            string ip = txtIP.Text;
            if (_rep.Conectar(ip, (int)nudPort.Value, (uint)nudPassCode.Value) == RepCid.ErrosRep.OK)
            {
                if (!lShowOK)
                    // Se não for para exibir os dialogos de confirmação de conexão já retorna a instancia da conexão
                    return true;
                string sn;
                uint tam_bobina;
                uint restante_bobina;
                uint uptime;
                uint cortes;
                uint papel_acumulado;
                uint nsr_atual;
                if (_rep.LerInfo(out sn, out tam_bobina, out restante_bobina, out uptime, out cortes, out papel_acumulado, out nsr_atual))
                {
                    if (sn == null) sn = "?";
                }
                else
                    sn = "(falhou)";

                if (txtIP.Text != TesteRepCid.Properties.Settings.Default.IP ||
                    nudPort.Value != TesteRepCid.Properties.Settings.Default.Porta)
                {
                    if (MessageBox.Show("Conexão Aceita\r\n" +
                        "SN: " + sn + "\r\n" +
                        "NSR: " + nsr_atual.ToString() + "\r\n" +
                        "Papel restante: " + (restante_bobina / 10.0f).ToString("0.0") + " m\r\n" +
                        "\r\nDeseja gravar esta conexão", "REP", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.Yes)
                    {
                        Settings.Default.IP = txtIP.Text;
                        Settings.Default.Porta = (int)nudPort.Value;
                        Settings.Default.PassCode = (uint)nudPassCode.Value;
                        Settings.Default.Save();
                    }
                }
                else
                    MessageBox.Show("Sucesso na conexão com o REP!\r\n\r\n" +
                        "SN: " + sn + "\r\n" +
                        "NSR: " + nsr_atual.ToString() + "\r\n" +
                        "Papel restante: " + (restante_bobina / 10.0f).ToString("0.0") + " m",
                        "REP", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                MessageBox.Show("Conexão com o REP não está funcionando", "REP", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            return true;
        }

        #endregion

        private void btnTestUsb_Click(object sender, EventArgs e)
        {
            // Exemplo de leitura de dados
            RepCidUsb a = new RepCidUsb();
            int num_usrs;
            bool leu_digitais;
            if (!a.CarregarUsuarios(@"C:\usuarios.dat", @"C:\digitais.dat", out num_usrs, out leu_digitais))
            {
                Console.WriteLine("Erro carregando: " + a.GetLastError());
                return;
            }

            Int64 pis;
            string nome;
            uint codigo;
            string senha;
            string barras;
            uint rfid;
            int priv;
            int ndig;
            int total_digs = 0;
            while (a.LerUsuario(out pis, out nome, out codigo, out senha, out barras, out rfid, out priv, out ndig))
            {
                Console.WriteLine("Leu: " + pis.ToString() + "  ;  " + nome);
                total_digs += ndig;
                if (a.CarregarTemplatesUsuario(pis, out ndig))
                {
                    // Aqui: Ler digitais do usuário
                }
                else
                {
                    Console.WriteLine("Erro lendo templates: " + a.GetLastError());
                    return;
                }
            }
            Console.WriteLine("Fim: " + a.GetLastError());
            Console.WriteLine("Digitais: " + total_digs.ToString());


            // Exemplo de gravação de dados
            a.IniciaGravacao();
            if (!a.AdicionarUsuario(1234567, "Teste", 0, "", "", 0, 0))
            {
                Console.WriteLine("Erro em adicionar: " + a.GetLastError());
            }
            if (!a.FinalizarGravacao(@"C:\usuarios.dat", @"C:\digitais.dat"))
            {
                Console.WriteLine("Erro em finalizar: " + a.GetLastError());
            }
        }

        private void btnRest_Click(object sender, EventArgs e)
        {
            //string cResult = Rest.SendJson("https://" + txtIP.Text + "/login.fcgi", "{\"login\":\"admin\",\"password\":\"admin\"}");
            //string cResult = RestJSON.Login(txtIP.Text);
            //MessageBox.Show(cResult);
            //    // Para autorizar qualquer certificado SSL
            //    // http://stackoverflow.com/questions/18454292/system-net-certificatepolicy-to-servercertificatevalidationcallback-accept-all-c
            //    SSLValidator.OverrideValidation(); 

            //    try
            //    {
            //        // Teste basico dos comandos REST para o REP idClass
            //        var request = WebRequest.Create("https://" + txtIP.Text + "/login.fcgi");
            //        request.ContentType = "application/json";
            //        request.Method = "POST";

            //        using (var streamWriter = new StreamWriter(request.GetRequestStream()))
            //        {
            //            streamWriter.Write("{\"login\":\"admin\",\"password\":\"admin\"}");
            //            streamWriter.Flush();
            //        }

            //        var response = (HttpWebResponse)request.GetResponse();
            //        using (var streamReader = new StreamReader(response.GetResponseStream()))
            //        {
            //            MessageBox.Show(streamReader.ReadToEnd());
            //        }
            //    }
            //    catch(Exception ex)
            //    {
            //        MessageBox.Show(ex.StackTrace, ex.Message, MessageBoxButtons.OK, MessageBoxIcon.Error);
            //    }
        }
    }

    //public static class SSLValidator
    //{
    //    private static bool OnValidateCertificate(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
    //    {
    //        return true;
    //    }

    //    public static void OverrideValidation()
    //    {
    //        ServicePointManager.ServerCertificateValidationCallback = OnValidateCertificate;
    //        ServicePointManager.Expect100Continue = true;
    //    }
    //}
}
