using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.IO;
using System.ServiceModel.Channels;

namespace idAccess_Rest
{
    [ServiceContract]
    public interface IServer
    {

        [OperationContract]
        [WebInvoke(UriTemplate = "new_biometric_image.fcgi?session={session}&device_id={device_id}&identifier_id={identifier_id}&width={width}&height={height}", Method = "POST", ResponseFormat = WebMessageFormat.Json)]
        BiometricImageResult getImage(string session, string device_id, string identifier_id, string width, string height, Stream stream);

        //Quando está no modo online(Modo Online 3), e a identificação está sendo feita parte no servidor parte no equipamento local  (modo online 3).
        [OperationContract]
        [WebInvoke(UriTemplate = "new_user_identified.fcgi?session={session}", Method = "POST", ResponseFormat = WebMessageFormat.Json)]
        BiometricImageResult UserIdentified(string session, Stream stream);
        /// <summary>
        /// Um template não identificado foi extraido
        /// </summary>
        [OperationContract]
        [WebInvoke(UriTemplate = "new_biometric_template.fcgi?session={session}&device_id={device_id}&identifier_id={identifier_id}", Method = "POST", ResponseFormat = WebMessageFormat.Json)]
        BiometricImageResult UserTemplate(string session, string device_id, string identifier_id, Stream stream);

        [OperationContract]
        [WebInvoke(UriTemplate = "new_user_id_and_password.fcgi?session={session}", Method = "POST", ResponseFormat = WebMessageFormat.Json)]
        BiometricImageResult new_user_id_and_password(string session, Stream stream);

        [OperationContract]
        [WebInvoke(UriTemplate = "new_card.fcgi?session={session}", Method = "POST", ResponseFormat = WebMessageFormat.Json)]
        BiometricImageResult new_card(string session, Stream stream);

        //Modo contigência quando o equipamento perder a comunicação com o servidor ele realiza poolings no servidor e o servidor deve responder HTTP Status OK
        //Para retornar para o modo online
        [OperationContract]
        [WebInvoke(UriTemplate = "device_is_alive.fcgi?session={session}", Method = "POST", ResponseFormat = WebMessageFormat.Json)]
        DeviceIsAliveResult getDeviceIsAlive(string session, Stream stream);


    }


}
