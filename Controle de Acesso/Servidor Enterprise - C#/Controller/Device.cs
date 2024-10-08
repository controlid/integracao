using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.ServiceModel;
using System.ServiceModel.Description;
using System.ServiceModel.Web;
using idAccess_Rest.Model.Util;
namespace idAccess_Rest
{

    class Device
    {
        public static string IPAddress = null;
        public static string ServerIp = null;
        private string session = null;
        Util config = new Util();

        public Device()
        {
            var ip_terminal = config.ipServer;
            var ip_servidor = config.ipTerminal;
        }

        public Device(string IPTerminal, string IPServer)
        {
            IPAddress = IPTerminal;
            ServerIp = IPServer;
        }
        public string[] IniciaServidor(out bool success)
        {
            List<string> response = new List<string>();
            response.Add("Iniciando servidor local...\r\n");

            try
            {
                // Configurando o binding do serviço WCF
                var binding = new WebHttpBinding();
                binding.MaxReceivedMessageSize = 2147483647;
                binding.MaxBufferSize = 2147483647;
                binding.MaxBufferPoolSize = 2147483647;

                // Iniciar o servidor sem definir um IP, apenas no localhost com a porta 8000
                Uri baseAddress = new Uri("http://localhost:8000/");
                WebServiceHost host = new WebServiceHost(typeof(Server), baseAddress);

                ServiceEndpoint ep = host.AddServiceEndpoint(typeof(IServer), binding, "");

                // Desabilitar a página de ajuda HTTP do WCF
                ServiceDebugBehavior sdb = host.Description.Behaviors.Find<ServiceDebugBehavior>();
                if (sdb != null)
                {
                    sdb.HttpHelpPageEnabled = false;
                }

                // Abrir o host do servidor
                host.Open();

                response.Add("Servidor iniciado com sucesso no endereço " + baseAddress + ".\r\n");
                success = true;
            }
            catch (Exception ex)
            {
                success = false;
                response.Add("Erro ao iniciar o servidor local:");
                response.Add("  - " + ex.Message + "\r\n");
            }

            return response.ToArray();
        }
        public string[] CadastrarNoSevidor(out bool success)
        {
            List<string> response = new List<string>();
            response.Add("Cadastrando Servidor no equipamento.\r\n");
            try
            {
                //Verifica se o equipamento já está cadastrado no servidor e cadastra caso seja necessário
                if (ListObjects("{" +
                        "\"object\" : \"devices\"," +
                        "\"where\" : [{" +
                                "\"field\" : \"id\"," +
                                "\"value\" : -1" +

                            "}]" +
                        "}").Length == 0)
                {
                    try
                    {
                        sendJson("create_objects", "{" +
                                "\"object\" : \"devices\"," +
                                "\"values\" : [{" +
                                        "\"id\" : -1," +
                                        "\"name\" : \"Servidor\"," +
                                        "\"ip\" : \"" + ServerIp + "\"," +
                                        "\"public_key\" : \"anA=\"" +

                                    "}]" +
                                "}");
                        response.Add("Equipamento Servidor cadastrado com sucesso no Cliente.\r\n");
                    }
                    catch (Exception ex)
                    {
                        response.Add("Erro ao cadastrar Servidor, Device.cs, L65:");
                        response.Add("  - " + ex.Message + "\r\n");

                    }
                }
                else
                {
                    try
                    {
                        string jsonToSend = "";
                        jsonToSend += "{";
                        jsonToSend += "\"object\":\"devices\",";
                        jsonToSend += "\"values\":{\"name\":\"Servidor\",\"ip\":\"" + ServerIp + "\",\"public_key\":\"anA=\"},";
                        jsonToSend += "\"where\":{\"devices\":{\"id\":-1}}";
                        jsonToSend += "}";

                        sendJson("modify_objects", jsonToSend);
                        response.Add("Equipamento Servidor alterado com sucesso no Cliente.\r\n");
                    }
                    catch (Exception ex)
                    {
                        response.Add("Erro ao cadastrar Servidor, Device.cs, L65:");
                        response.Add("  - " + ex.Message + "\r\n");

                    }
                }
                ChangeType(true);
                success = true;
            }
            catch (Exception ex)
            {
                success = false;
                response.Add("Erro ao cadastrar Servidor, Device.cs, L79:");
                response.Add("  - " + ex.Message + "\r\n");
                return response.ToArray();
            }

            //Inicia o monitoramento de identificações do equipamento
            try
            {
                // basic wcf web http service
                var binding = new WebHttpBinding();
                binding.MaxReceivedMessageSize = 2147483647;
                binding.MaxBufferSize = 2147483647;
                binding.MaxBufferPoolSize = 2147483647;

                WebServiceHost host = new WebServiceHost(typeof(Server), new Uri("http://localhost:8000/"));
                ServiceEndpoint ep = host.AddServiceEndpoint(typeof(IServer), binding, "");
                ServiceDebugBehavior sdb = host.Description.Behaviors.Find<ServiceDebugBehavior>();
                sdb.HttpHelpPageEnabled = false;
                host.Open();
                response.Add("Servidor iniciado no IP "+ ServerIp + ", verifique se o firewall está liberado na porta 8000");
            }
            catch (Exception ex)
            {
                success = false;
                response.Add("Erro ao monitorar identificações:");
                response.Add("  - " + ex.Message + "\r\n");
                return response.ToArray();
            }

            return response.ToArray();
        }
        
        public string[] ChangeType(bool isOnline)
        {
            List<string> response = new List<string>();
            response.Add("Alterando modo de operação do equipamento\r\n");
            try
            {
                sendJson("set_configuration",
                    "{" +
                        "\"online_client\" : {" +
                                "\"server_id\" : \"-1\"," +
                                "\"extract_template\" : \"1\"" + // se estiver com zero vai enviar a imagem ao invés do template biométrico para o servidor

                            "}," +
                         "\"general\" : {" +
                            "\"online\" : \"" + (isOnline ? 1 : 0) + "\"," +

                            "\"local_identification\" : \"1\"" + // se estiver com zero chama as funções "new_card" e " UserTemplate"
                                                                 // se estiver com valor 1 chama a função "UserIdentified", na qual já vem o id do usuário no caso de biometria

                            "}" +
                        "}"
                ); 
                response.Add("Modo de operação alteredo\r\n");
            }
            catch (Exception ex)
            {
                response.Add("Erro ao alterar Modo de Operação:");
                response.Add("  - " + ex.Message + "\r\n");
            }
            return response.ToArray();
        }

        public Dictionary<string, string>[] ListObjects(string data)
        {
            List<Dictionary<string, string>> list = new List<Dictionary<string, string>>();
            string response = sendJson("load_objects", data);
            int i = response.IndexOf("[") + 1;
            response = response.Substring(i, response.Length - 1 - i).Replace("\"", "");
            string[] listObjects = response.Split('}', '{');
            foreach (string sObj in listObjects)
            {
                if (sObj.Length <= 1)
                    continue;
                Dictionary<string, string> obj = new Dictionary<string, string>();
                string[] objFilds = sObj.Split(',');
                foreach (string field in objFilds)
                {
                    string[] value = field.Split(':');
                    obj.Add(value[0], value[1]);
                }
                list.Add(obj);
            }
            return list.ToArray();
        }

        public string Login()
        {
            if (session == null)
            {
                string response = sendJson("login", "{\"login\":\"admin\",\"password\":\"admin\"}", false);
                session = response.Split('"')[3];
            }
            return session;
        }


        public string sendJson(string uri, string data, bool checkLogin = true)
        {
            if (checkLogin)
            {
                Login();
                uri += ".fcgi?session=" + session;
            }
            else
                uri += ".fcgi";
            ServicePointManager.Expect100Continue = false;
            try
            {
                var request = (HttpWebRequest)WebRequest.Create("http://" + IPAddress + "/" + uri);
                request.ContentType = "application/json";
                request.Method = "POST";

                using (var streamWriter = new StreamWriter(request.GetRequestStream()))
                {
                    streamWriter.Write(data);
                }

                var response = (HttpWebResponse)request.GetResponse();
                using (var streamReader = new StreamReader(response.GetResponseStream()))
                {
                    string responseData = streamReader.ReadToEnd();
                    Console.WriteLine(responseData);
                    return responseData;
                }
            }
            catch (WebException e)
            {
                using (WebResponse response = e.Response)
                {
                    HttpWebResponse httpResponse = (HttpWebResponse)response;
                    if (httpResponse == null){
                        throw new Exception("O servidor referente ao IP indicado não pôde ser encontrado");
                    }
                    Console.WriteLine("Error code: {0}", httpResponse.StatusCode);
                    using (Stream responseData = response.GetResponseStream())
                    using (var reader = new StreamReader(responseData))
                    {
                        string text = reader.ReadToEnd();
                        Console.WriteLine(text);
                        throw new Exception(text);
                    }
                }
            }
        }
    }
}
