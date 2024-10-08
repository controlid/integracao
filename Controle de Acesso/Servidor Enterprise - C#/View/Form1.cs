using idAccess_Rest.View;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.ServiceModel;
using System.ServiceModel.Description;
using System.ServiceModel.Web;
using System.Text;
using System.Windows.Forms;

namespace idAccess_Rest
{
    public partial class Form1 : Form
    {
        int day; int month; int year; int hour; int minute; int second;

        public static string ip_server;
        public static string ip_terminal;

        public static TextBox txtLog;
        public static void Log(string[] value)
        {
            foreach (string line in value)
                txtLog.AppendText(line + "\r\n");
                txtLog.AppendText("-----------------------\r\n");
        }

        Device device = new Device();
        public Form1()
        {
            InitializeComponent();
            txtLog = txtLogs;
        }

        private void btnAddUser_Click(object sender, EventArgs e)
        {
            Usuario usr = new Usuario();
            usr.Show();
        }

        public void Convert_Wiegand(double numeroCartaoGravado)
        {
            double numeroAntesVirgula,numeroDepoisVirgula;
            numeroAntesVirgula = numeroDepoisVirgula = 0;
            /**
             * Para simular a conversão vamos utilizar o seguinte numero de cartão de exemplo W:9602032
             * Após aplicação da formula  96 * 2^32 + 2032 = 412316862448
             * O numero gravado será : 412316862448 agora vamos desconverter
             * A variavel numeroCartaoGravado vai receber como valor 412316862448
             */
            //Obtendo o valor antes da virgula
            //A variavel numeroAntesVirgula apos realizar a "desconversão" recebe o valor de 96
            numeroAntesVirgula = Convert.ToInt64(numeroCartaoGravado /  0x100000000); 
            //Obtendo o valor depois da virgula
            //A variavel numeroDepoisVirgula apos realizar a "desconversão" recebe o valor de 2032
            numeroDepoisVirgula = Convert.ToInt64(numeroCartaoGravado % 0x100000000); 
            MessageBox.Show("Numero que o Acesso lê: "+numeroCartaoGravado+"\r\nNumero Antes da Virgula: " + numeroAntesVirgula + "\r\nNumero Depois da Virgula: " + numeroDepoisVirgula);  
        }

        private void button1_Click_3(object sender, EventArgs e)
        {
            double cartao = 412316862448;
            Convert_Wiegand(cartao);
        }

        public DateTime Convert_Unix(double unix)
        {
            System.DateTime dtTime = new DateTime(1970, 1, 1, 0, 0, 0, 0, System.DateTimeKind.Utc);
            dtTime = dtTime.AddSeconds(unix).ToLocalTime();
            MessageBox.Show("Data" + dtTime);   
            return dtTime;
        }

        private void cadastrarUsuárioToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Usuario usr = new Usuario();
            usr.Show();
        }

        private void setarOnlineToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Log(device.ChangeType(true));
        }

        private void setarOfflineToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Log(device.ChangeType(false));
        }

        private void logsDeAcessoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            List<string> response = new List<string>();
            response.Add("Listando Logs");
            try
            {
                Dictionary<string, string>[] list = device.ListObjects("{\"object\":\"access_logs\"}");
                response.Add(list.Length + " Logs Localizados");
                foreach (var user in list)
                {
                    double x = Convert.ToDouble(user["time"]);
                    System.DateTime dtTime = new DateTime(1970, 1, 1, 0, 0, 0, 0, System.DateTimeKind.Utc);
                    dtTime = dtTime.AddSeconds(x).ToLocalTime();

                    response.Add("iD do Usuário: " + user["user_id"] + "");
                    response.Add("ID do equipamento: " + user["device_id"] + "");
                    response.Add("Evento de Identificação" + user["event"] + "");
                    response.Add("Time: " + dtTime + "");
                    response.Add("****************************************");
                    //Converrter para double essa lista
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro ao cadastrar Servidor, Form1.cs");
                response.Add("Erro ao cadastrar Servidor, Form1.cs, L144:");
                response.Add("  - " + ex.Message + "");
            }
            Log(response.ToArray());
        }

        private void listarCartõesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            List<string> response = new List<string>();
            response.Add("Listando Cartões");
            try
            {
                Dictionary<string, string>[] list = device.ListObjects("{\"object\":\"cards\"}");
                response.Add(list.Length + " usuários localizados");
                foreach (var user in list)
                {
                    response.Add("Id: " + user["id"] + ", Valor: " + user["value"] + ", User id: " + user["user_id"] + "");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro ao cadastrar Servidor, Form1.cs");
                response.Add("Erro ao cadastrar Servidor, Form1.cs, L171:");
                response.Add("  - " + ex.Message + "");
            }
            Log(response.ToArray());
        }

        private void usuariosCadastradosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            List<string> response = new List<string>();
            response.Add("Listando usuários");
            try
            {
                Dictionary<string, string>[] list = device.ListObjects("{\"object\":\"users\"}");
                foreach (var user in list)
                {
                    response.Add(user["name"] + "");
                }
            }
            catch (Exception ex)
            {
                response.Add("Erro ao cadastrar Servidor, Form1.cs, L195:");
                response.Add("  - " + ex.Message + "");
            }

            Log(response.ToArray());
        }

        private void exemploDeConversãoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            double Cartao = 412316862448;
            Convert_Wiegand(Cartao);
        }

        private void acessoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            List<string> response = new List<string>();
            response.Add("Abrindo porta");
            try
            {
                device.sendJson("set_configuration", "{\"general\":{\"relay1_enabled\": \"1\",\"relay2_enabled\": \"1\"}}");
                device.sendJson("execute_actions", "{\"actions\":[{\"action\": \"door\", \"parameters\":\"door=2\"}]}");
                response.Add("porta aberta");
            }
            catch (Exception ex)
            {
                response.Add("Erro ao abrir a porta:");
                response.Add("  - " + ex.Message + "");
            }

            Log(response.ToArray());
        }

        private void atualizarDataEHoraToolStripMenuItem_Click(object sender, EventArgs e)
        {
            day = month = hour = minute = second = year = 0;
            string dataAtual = DateTime.Now.ToString("dd/MM/yyyy HH.mm.ss");

            day = Convert.ToInt32(dataAtual.Substring(0, 2));
            month = Convert.ToInt32(dataAtual.Substring(3, 2));
            year = Convert.ToInt32(dataAtual.Substring(6, 4));
            hour = Convert.ToInt32(dataAtual.Substring(11, 2));
            minute = Convert.ToInt32(dataAtual.Substring(14, 2));
            second = Convert.ToInt32(dataAtual.Substring(17, 2));

            List<string> response = new List<string>();
            response.Add("Data e Hora");
            try
            {
                device.sendJson("set_system_time","{" +
                "\"day\":" + day +
                ",\"month\":" + month +
                ",\"year\":" + year +
                ",\"hour\":" + hour +
                ",\"minute\":" + minute +
                ",\"second\":" + second +
                "}");
                response.Add("Data e Hora atualizada com sucesso.");
            }
            catch (Exception ex)
            {
                response.Add("Erro ao Atualizar data e hora:");
                response.Add("  - " + ex.Message + "");
            }
            Log(response.ToArray());
        }

        private void catracaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            List<string> response = new List<string>();
            response.Add("Liberando Giro");
            try
            {
                //device.sendJson("set_configuration", "{\"general\":{\"relay1_enabled\": \"1\",\"relay2_enabled\": \"1\"}}");
                //Liberando giro no sentido horário.
                device.sendJson("execute_actions", "{\"actions\":[{\"action\": \"catra\", \"parameters\":\"allow=clockwise\"}]}");
                response.Add("Giro Liberado");
            }
            catch (Exception ex)
            {
                response.Add("Erro ao liberar giro na catraca:");
                response.Add("  - " + ex.Message + "");
            }

            Log(response.ToArray());
        }
        private void nomeExibiçãoDoAcessoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            List<string> response = new List<string>();
            response.Add("Essa função no momento não faz nada.");
            Log(response.ToArray());
        }

        private void terminalToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Terminal terminal = new Terminal();
            terminal.Show();
        }

        // Corresponde ao botão de "Limpar Logs"
        private void button1_Click(object sender, EventArgs e)
        {
            txtLog.Clear();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            List<string> response = new List<string>();
            device = new Device();
            bool success = true;
            device.IniciaServidor(out success);
            if(success)
            {
                response.Add("Servidor iniciado com sucesso.");
            }
            else
            {
                response.Add("Falha ao iniciar o servidor.");
            }
            Log(response.ToArray());
        }
    }
}
