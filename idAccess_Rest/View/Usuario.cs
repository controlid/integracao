using idAccess_Rest.Model.Util;
using idAccess_Rest.View;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace idAccess_Rest
{
    public partial class Usuario : Form
    {
        public Usuario()
        {
            InitializeComponent();
        }
        private Device device;
                
        private void button1_Click(object sender, EventArgs e)
        {
            Util util = new Util();
            device = new Device(new Util().GetIpTerminal(),new Util().GetIpServer());
            List<string> response = new List<string>();
            response.Add("Cadastrando novo usuário");

            try
            {
                // checar se já existe usuário registrado com o ID especificado
                Dictionary<string, string>[] list = device.ListObjects("{\"object\":\"users\"}");
                response.Add(list.Length + " Logs Localizados");
                foreach (var user in list)
                {
                    response.Add(user["id"].ToString());
                    if (String.Equals(user["id"].ToString(), txtId.Text)){
                        response.Add("Usuário com ID já existente");
                        break;
                    }
                }
                device.sendJson("create_objects","{" +
                        "\"object\" : \"users\"," +
                        "\"values\" : [{" +
                                "\"id\" :" + txtId.Text + "," +
                                "\"name\" :\""+ txtUser.Text+"\"," +
                                "\"registration\" : \"" + txtMatricula.Text + "\"" +
                            "}]" +
                        "}");
                response.Add("Usuário cadastrado com sucesso");
            }
            catch (Exception ex)
            {
                response.Add("Erro ao cadastrar Usuário:");
                response.Add("  - " + ex.Message);
                Form1.Log(response.ToArray());
                return;
            }
            Form1.Log(response.ToArray());
            Remote_Biometry();
            txtMatricula.Text = txtUser.Text = "";
        }
        
        public void Remote_Biometry()
        {
            string mensagem = "Usuário Cadastrado com sucesso, deseja cadastrar a biometria remotamente?";
            string titulo = "Cadastro de usuário";
            MessageBoxButtons botao = MessageBoxButtons.YesNo;
            DialogResult resultado = MessageBox.Show(mensagem, titulo, botao);
            if (resultado == DialogResult.No)
            {
                this.Close();
            }
            else if (resultado == DialogResult.Yes)
            {
                device.sendJson("remote_enroll","{\"type\":\"card\",\"user_id\":" + txtId.Text + ",\"save\":true}");
                //device.sendJson("remote_enroll","{\"type\":\"biometry\",\"user_id\":" + txtId.Text + ",\"save\":true}");
            }
        }
    }
}
