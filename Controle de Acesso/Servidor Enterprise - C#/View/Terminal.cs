using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace idAccess_Rest.View
{
    public partial class Terminal : Form
    {
        private Device device;

        public static string ip_server;
        public static string ip_terminal;
        public Terminal()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ip_terminal = txtTerminal.Text;
            device = new Device(ip_terminal,ip_server);
            bool success = true;
            Form1.Log(device.CadastrarNoSevidor(out success));
        }

        private void Terminal_Load(object sender, EventArgs e)
        {
            foreach (var ip in Dns.GetHostAddresses(Dns.GetHostName()))
            {
                if (ip.AddressFamily == AddressFamily.InterNetwork)
                {
                    ip_server = ip.ToString();
                    return;
                }
            }
           
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        /*
        private static bool CheckIPValid(string ipString)
        {
            if (String.IsNullOrWhiteSpace(ipString))
            {
                return false;
            }

            string[] splitValues = ipString.Split('.');
            if (splitValues.Length != 4)
            {
                return false;
            }

            byte tempForParsing;
            return splitValues.All(r => byte.TryParse(r, out tempForParsing));
        }
        */

    }
}
