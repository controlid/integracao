using System;
using System.Runtime.Serialization;

namespace ExemploAPI
{
    [DataContract]
    public class ResultList
    {
        [DataMember(EmitDefaultValue = false)] // Os EmitDefaultValue são necessários mais para postar informações omitindo itens não definidos
        public User[] users;

        [DataMember(EmitDefaultValue = false)]
        public Access_Logs[] access_logs;
    }

    [DataContract]
    public class User
    {
        [DataMember(EmitDefaultValue = false)]
        public long id; // Atenção no iDAccess todos os numeros são sempre long (64bits)
        [DataMember(EmitDefaultValue = false)]
        public string name;
        [DataMember(EmitDefaultValue = false)]
        public string registration;
        // Já que neste exemplo não irei usar, vou remover, o que no DataContractJsonSerializer, não interfere em nada, pois ele só processa o que estiver definido
        //[DataMember(EmitDefaultValue = false)]
        //public string password;
        //[DataMember(EmitDefaultValue = false)]
        //public string salt;
    }

    [DataContract]
    public class Access_Logs
    {
        [DataMember(EmitDefaultValue = false)]
        public long id; // Atenção no iDAccess todos os numeros são sempre long (64bits)
        [DataMember(EmitDefaultValue = false)]
        public long time;
        [DataMember(EmitDefaultValue = false, Name = "event")]
        public int Event;
        [DataMember(EmitDefaultValue = false)]
        public long device_id;
        [DataMember(EmitDefaultValue = false)]
        public long identifier_id;
        [DataMember(EmitDefaultValue = false)]
        public long user_id;
        [DataMember(EmitDefaultValue = false)]
        public long portal_id;
        [DataMember(EmitDefaultValue = false)]
        public long identification_rule_id;

        [IgnoreDataMember]
        public EventTypes EventType { get { return (EventTypes)Event; } }

        /// <summary>
        /// Contém a data e hora do equipamento em Unix Timestamp.
        /// </summary>
        /// <see cref="http://pt.wikipedia.org/wiki/Era_Unix"/>
        [IgnoreDataMember]
        public DateTime Date { get { return time.FromUnix(); } }
    }


    public enum EventTypes
    {
        /// <summary>
        /// ERRO ?
        /// </summary>
        none = 0,

        /// <summary>
        /// 1 - equipamento inválido
        /// </summary>
        DeviceInvalid = 1,

        /// <summary>
        /// 2 - parâmetros de regra de identificação inválidos
        /// </summary>
        parameter_invalid = 2,

        /// <summary>
        /// 3 - não identificado
        /// </summary>
        NotIdentify = 3,

        /// <summary>
        /// 4 - identificação pendente
        /// </summary>
        IdentifyPending = 4,

        /// <summary>
        /// 5 - timeout na identificação
        /// </summary>
        identifyTimeOut = 5,

        /// <summary>
        /// 6 - acesso negado
        /// </summary>
        AccessDeny = 6,

        /// <summary>
        /// 7 - acesso autorizado
        /// </summary>
        Allow = 7,

        /// <summary>
        /// 8 - acesso pendente
        /// </summary>
        AccessPending = 8,
        /// <summary>
        /// 13 - acesso pendente
        /// </summary>
        GiveUp = 13,
        /// <summary>
        /// 11 - acesso pendente
        /// </summary>
        Buttonhole = 11,
        /// <summary>
        /// 12 - acesso pendente
        /// </summary>
        InterfaceWeb = 12

    }
}
