using System;
using System.Collections.Specialized;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.Text;
using System.Threading;
using System.Web;
using System.Windows.Forms;

namespace idAccess_Rest
{
    

    class Server : IServer
    {
        BiometricResult get = new BiometricResult();
        
        public BiometricImageResult new_card(string session, Stream stream)
        {
            var result = get.ResultIdentification(session, stream);
            Form1.Log(new string[1] { "identificação por cartão detectada" });
            return get.sendMessage();
        }

        public BiometricImageResult new_user_id_and_password(string session, Stream stream)
        {
            var result = get.ResultIdentification(session, stream);
            Form1.Log(new string[1] { "identificação por código e senha detectada: " });
            return get.sendMessage();
        }

        public BiometricImageResult getImage(string session, string device_id, string identifier_id, string width, string height, Stream stream)
        {
            var result = get.ResultIdentification(session, device_id, identifier_id, width, height, stream);
            Form1.Log(new string[1] { "identificação por biometria detectada" });
            return get.sendMessage();
        }
    
        public BiometricImageResult UserIdentified(string session, Stream stream)
        {
            var request = OperationContext.Current.IncomingMessageProperties[HttpRequestMessageProperty.Name] as HttpRequestMessageProperty;
            byte[] val = get.ReadFully(stream);
            string msg = Encoding.UTF8.GetString(val);
            // Program.AccessLog("Identificação local: " + msg);
            NameValueCollection prms = HttpUtility.ParseQueryString(msg);
            // event=8&device_id=468770&identifier_id=1651076864&portal_id=1&user_id=1&user_name=AAA&user_has_image=0
            int event_id = Convert.ToInt32((prms["event"]));
            long device_id = Convert.ToInt64(prms["device_id"]);
            long identifier_id = Convert.ToInt32(prms["identifier_id"]);
            long user_id = Convert.ToInt64(prms["user_id"]);
            long card_value = Convert.ToInt64(prms["card_value"]);
            string name = Convert.ToString(prms["user_name"]);
                
            //Pegando os bytes que vem da variavel identifier_id 
            byte[] IdentifierBytes = BitConverter.GetBytes(identifier_id).Reverse().ToArray();
            //Convertendo para string a variavel do tipo byte[] que converteu um identifier_id do tipo long
            string identifierName = Encoding.UTF8.GetString(IdentifierBytes);
            //obtendo os ultimos 4 caracteres que identificam o tipo de identificação
            string Substring = identifierName.Substring(3, 4);

            //Se a user_id for diferente de zero quer dizer que não foi encontrado usuário.
            if (user_id > 0)
            {
                Form1.Log(new string[1] { "DEVICE ID: " + device_id });
                Form1.Log(new string[1] { "USER: " + user_id });
                Form1.Log(new string[1] { "IDENTIFIER ID: " + identifier_id });
                Form1.Log(new string[1] { "IDENTIFIER NAME: " + identifierName });
                //MessageBox.Show("Identificado - Device: " + device_id + "  User: " + user_id + "Identificacao" + identifier_id + "Identificação name" + identifierName);
                Form1.Log(new string[1] { "NAME: " + name });
            }
            else
                Form1.Log(new string[1] { "Não identificado ID do usuário: " + device_id });
              
            //// TODO: transferir para SDK
            //byte[] identifierBytes = BitConverter.GetBytes(identifier_id).Reverse().ToArray();
            //string identifierName = Encoding.UTF8.GetString(identifierBytes);
            return get.sendMessage();
        }

        public DeviceIsAliveResult getDeviceIsAlive(string session, Stream stream)
        {
            var result =  get.ResultIdentification(session, stream);
            Form1.Log(new string[2] {"Detecção da Contingência, restaurando comunicação com o Servidor.", "\nResult Logs: "+ result});
            return get.sendDevice();
        }
    }
}
