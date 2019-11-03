using ExemploAPI.Properties;
using System;
using System.Globalization;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Threading;
using System.Windows.Forms;

namespace ExemploAPI
{
    public partial class frmExemplos : Form
    {
        private string urlDevice = null;
        private string session = null;

        #region Form Controls

        private static bool run = true;

        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            while (run)
                Application.Run(new frmExemplos());
        }

        public frmExemplos()
        {
            InitializeComponent();
            run = false;
        }

        public void AddLog(Exception ex)
        {
            AddLog("ERRO: " + ex.Message + "\r\n" + ex.StackTrace);
        }

        public void AddLog(string cInfo)
        {
            txtOut.Text += "\r\n" + cInfo;
            txtOut.SelectionStart = txtOut.Text.Length;
            txtOut.ScrollToCaret();
        }

        private void frmExemplos_Load(object sender, EventArgs e)
        {
            cmbGiro.SelectedIndex = 0;

            // just to testing, always read the pre-configured data
            // (apenas para facilitar os testes, lê sempre os dados pré configurados)
            txtIP.Text = Settings.Default.ip;
            nmPort.Value = Settings.Default.port;
            chkSSL.Checked = Settings.Default.ssl;
            txtUser.Text = Settings.Default.user;
            txtPassword.Text = Settings.Default.password;
        }

        // restart in other language
        // (reinicializa em outro idioma)
        private void btnPT_Click(object sender, EventArgs e)
        {
            if (!Thread.CurrentThread.CurrentCulture.Name.StartsWith("pt"))
            {
                Thread.CurrentThread.CurrentCulture = Thread.CurrentThread.CurrentUICulture = new CultureInfo("pt-BR");
                run = true;
                Close();
            }
        }

        private void btEN_Click(object sender, EventArgs e)
        {
            if( !Thread.CurrentThread.CurrentCulture.Name.StartsWith("en"))
            {
                Thread.CurrentThread.CurrentCulture = Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-US");
                run = true;
                Close();
            }
        }

        #endregion

        #region Login e Validação de sessão

        private void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                txtIP.Text = txtIP.Text.Trim();
                session = null; // erases the previous session (invalida sessão anterior)

                if (this.chkSSL.Checked)
                {
                    urlDevice = "https://" + txtIP.Text;
                    if (nmPort.Value != 443)
                        urlDevice += ":" + nmPort.Value;
                }
                else
                {
                    urlDevice = "http://" + txtIP.Text;
                    if (nmPort.Value != 80)
                        urlDevice += ":" + nmPort.Value;
                }
                urlDevice += "/";

                txtOut.Text = "Device: " + urlDevice;

                // See another robust mode to login with serialization of JSON objects in the project "Remote Control" creating structures that are serialized
                // (Veja uma outra forma mais robusta de como poderia ser feito um login com serialização de objetos JSON no projeto de "Controle Remoto" criando estruturas que são serializadas se transformando em strings)
                // https://github.com/controlid/iDAccess/blob/master/ControleRemoto-CS/idAccess.cs
                string response = WebJson.Send(urlDevice + "login", "{\"login\":\"" + txtUser.Text + "\",\"password\":\"" + txtPassword.Text + "\"}");
                AddLog(response);

                // Simple method to get the session
                // (Forma mais simples de pegar a sessão)
                if (response.Contains("session"))
                {
                    session = response.Split('"')[3];
                    AddLog("OK!");

                    // There is still a connection in the application settings to facilitate
                    // (Persiste a conexão nas configurações do aplicativo para facilitar)
                    Settings.Default.ip = txtIP.Text;
                    Settings.Default.port = (int)nmPort.Value;
                    Settings.Default.ssl = chkSSL.Checked;
                    Settings.Default.user = txtUser.Text;
                    Settings.Default.password = txtPassword.Text;
                    Settings.Default.Save();
                }
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        private void tbc_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (tbc.SelectedIndex > 0 && session == null)
            {
                AddLog(Resource.ERR1);
                tbc.SelectedIndex = 0;
            }
        }

        #endregion

        #region Actions

        private void btnInfo_Click(object sender, EventArgs e)
        {
            try
            {
                AddLog(WebJson.Send(urlDevice + "system_information", null, session));
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        private void btnRele_Click(object sender, EventArgs e)
        {
            try
            {
                // Identify which button was pressed
                // Identifica qual botão foi apertado
                int nPorta;
                var btn = sender as Button;
                if (btn.Name == btnRele1.Name)
                    nPorta = 1;
                else if (btn.Name == btnRele2.Name)
                    nPorta = 2;
                else if (btn.Name == btnRele3.Name)
                    nPorta = 3;
                else // if (btn.Name == btnRele4.Name)
                    nPorta = 4;

                // It may be necessary to enable the relay in question
                // Eventualmente pode ser necessário habilitar o rele em questão
                // WebJson.Send(urlDevice + "set_configuration", "{\"general\":{\"relay1_enabled\": \"1\",\"relay2_enabled\": \"1\"}}");
                string cmd = "{\"actions\":[{\"action\": \"door\", \"parameters\":\"door=" + nPorta + "\"}]}";
                // {"actions":[{"action":"sec_box","parameters":"id=65793, reason=3"}]}
                AddLog(WebJson.Send(urlDevice + "execute_actions", cmd, session));
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        private void btnGiro_Click(object sender, EventArgs e)
        {
            try
            {
                if (cmbGiro.SelectedIndex == 1)
                    AddLog(WebJson.Send(urlDevice + "execute_actions", "{\"actions\":[{\"action\": \"catra\", \"parameters\":\"allow=clockwise\"}]}", session));
                else if (cmbGiro.SelectedIndex == 2)
                    AddLog(WebJson.Send(urlDevice + "execute_actions", "{\"actions\":[{\"action\": \"catra\", \"parameters\":\"allow=anticlockwise\"}]}", session));
                else 
                    AddLog(WebJson.Send(urlDevice + "execute_actions", "{\"actions\":[{\"action\": \"catra\", \"parameters\":\"allow=both\"}]}", session));

            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        private void btnReboot_Click(object sender, EventArgs e)
        {
            try
            {
                AddLog(WebJson.Send(urlDevice + "reboot", null, session));
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        #endregion

        #region Config

        private void btnDataHora_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime dt = dateTimePicker1.Value;
                string cmd = "{" +
                    "\"day\":" + dt.Day +
                    ",\"month\":" + dt.Month +
                    ",\"year\":" + dt.Year +
                    ",\"hour\":" + dt.Hour +
                    ",\"minute\":" + dt.Minute +
                    ",\"second\":" + dt.Second +
                    "}";

                AddLog(WebJson.Send(urlDevice + "set_system_time", cmd, session));
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        private void btnAgora_Click(object sender, EventArgs e)
        {
            dateTimePicker1.Value = DateTime.Now;
        }

        #endregion

        #region User

        private void btnUserList_Click(object sender, EventArgs e)
        {
            try
            {
                AddLog(WebJson.Send(urlDevice + "load_objects", "{\"object\":\"users\"}", session));
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        private void btnUserBioList_Click(object sender, EventArgs e)
        {
            try
            {
                AddLog(WebJson.Send(urlDevice + "load_objects", "{\"object\":\"templates\"}", session));
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        private void btnUserCardList_Click(object sender, EventArgs e)
        {
            try
            {
                AddLog(WebJson.Send(urlDevice + "load_objects", "{\"object\":\"cards\"}", session));
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        private void btnUserListParse_Click(object sender, EventArgs e)
        {
            try
            {
                // Este exemplo irá fazer um parse simples do retorno dos objetos automaticamente, usando uma estrutura de classes com os memos nomes
                string users = WebJson.Send(urlDevice + "load_objects", "{\"object\":\"users\"}", session); // Consulte a documentação para fazer 'Where'
                // https://www.controlid.com.br/produtos/controlador-de-acesso
                // https://www.controlid.com.br/suporte/api_idaccess_V2.6.8.html

                // requires (referenciar) System.Runtime.Serialization
                var serializer = new DataContractJsonSerializer(typeof(ResultList));

                // Transforma a string em um stream, mas o ideal é ter esse parse dentro do WebJson que usarei em outro exemplo
                var ms = new System.IO.MemoryStream(UTF8Encoding.UTF8.GetBytes(users));

                // the magic happens here (A mágina acontece aqui)
                var list = serializer.ReadObject(ms) as ResultList;

                // Only to optimize the code and send it to the screen
                // Apenas para otimizar o código e mandar para a tela tudo de uma vez
                var sb = new StringBuilder(); 
                for (int i = 0; i < list.users.Length; i++)
                    sb.AppendFormat("{0}: {1} - {2}\r\n", list.users[i].id, list.users[i].name, list.users[i].registration);

                AddLog(sb.ToString());
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        private void btnUserAdd_Click(object sender, EventArgs e)
        {
            try
            {
                // Using 'string' there are several situations that need to be handled manually do so via to parse JSON is much better
                // (Usando string há várias situações que precisam ser tratadas manualmente por isso fazer via com parse JSON é bem melhor)
                string cmd = "{" +
                    "\"object\" : \"users\"," +
                    "\"values\" : [{" +
                            (txtUserID.Text == "" ? "" : ("\"id\" :" + txtUserID.Text + ",")) + // optional (opcional)
                            "\"name\" :\"" + txtUserName.Text + "\"," +
                            "\"registration\" : \"" + txtUserRegistration.Text + "\"" +
                        "}]" +
                    "}";
                AddLog(WebJson.Send(urlDevice + "create_objects", cmd, session));
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        private void btnUserDelete_Click(object sender, EventArgs e)
        {
            try
            {
                long id = long.Parse(txtUserID.Text);
                AddLog(WebJson.Send(urlDevice + "destroy_objects", "{\"object\":\"users\",\"where\":{\"users\":{\"id\":[" + id + "]}}}", session));
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        private void btnUserRead_Click(object sender, EventArgs e)
        {
            try
            {
                long id = long.Parse(txtUserID.Text);
                var usrList = WebJson.Send<ResultList>(urlDevice + "load_objects", "{\"object\":\"users\",\"where\":{\"users\":{\"id\":[" + id + "]}}}", session);
                // it is always returns a list according to the "Where", which in this case to be an ID, must come only one was found
                // (Note que é sempre retornada um lista de acordo com a 'Where', que neste caso por ser um ID, só deve vir 1 se achou)
                if (usrList.users.Length == 1)
                {
                    txtUserName.Text = usrList.users[0].name;
                    txtUserRegistration.Text = usrList.users[0].registration;
                    AddLog(string.Format(Resource.Load1, id));
                }
                else
                    AddLog(string.Format(Resource.Load2, id));
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        private void btnUserModify_Click(object sender, EventArgs e)
        {
            try
            {
                long id = long.Parse(txtUserID.Text);
                string cmd = "{" +
                    "\"object\" : \"users\"," +
                    "\"where\":{\"users\":{\"id\":[" + id + "]}}," +
                    "\"values\" : {" +
                            "\"name\" :\"" + txtUserName.Text + "\"," +
                            "\"registration\" : \"" + txtUserRegistration.Text + "\"" +
                        "}" +
                    "}";
                AddLog(WebJson.Send(urlDevice + "modify_objects", cmd, session));
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        #endregion

        #region Logs

        private void btnLogs_Click(object sender, EventArgs e)
        {
            try
            {
                AddLog(WebJson.Send(urlDevice + "load_objects", "{\"object\":\"access_logs\"}", session));
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }


        private void btnLogs2_Click(object sender, EventArgs e)
        {
            try
            {
                var list = WebJson.Send<ResultList>(urlDevice + "load_objects", "{\"object\":\"access_logs\"}", session); // Consulte a documentação para fazer 'Where'
                var sb = new StringBuilder(); // uso um StringBuilder, apenas para otimizar o código, e mandar para a tela tudo de uma vez
                for (int i = 0; i < list.access_logs.Length; i++)
                    sb.AppendFormat("{0}: User {1} - {2}\r\n", list.access_logs[i].id, list.access_logs[i].user_id, list.access_logs[i].EventType);

                AddLog(sb.ToString());
            }
            catch (Exception ex)
            {
                AddLog(ex);
            }
        }

        #endregion

    }
}