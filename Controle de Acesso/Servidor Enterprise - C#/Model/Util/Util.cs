using idAccess_Rest.View;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace idAccess_Rest.Model.Util
{
    class Util
    {

        public string ipServer;
        public string ipTerminal;

        public String GetIpServer()
        {
            return ipServer = Device.ServerIp;

        }
        public String GetIpTerminal()
        {

            return ipTerminal = Device.IPAddress;
        }
    }
}

