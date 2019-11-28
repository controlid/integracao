using System;
using System.IO;
using System.Windows.Forms;

namespace SATExemplo
{
    public partial class Form1 : Form
    {
        private ControliD.CIDSAT cIDSAT;
        private readonly object syncNumSessao = new object();
        private int numSessao = 0;


        private int NewNumSessao()
        {
            lock(syncNumSessao)
            {
                numSessao = (numSessao + 1) % 100000;
                return numSessao;
            }
        }

        private delegate void SetTextCallback(string text);

        private void Log(string text)
        {
            // InvokeRequired required compares the thread ID of the
            // calling thread to the thread ID of the creating thread.
            // If these threads are different, it returns true.
            if (txtLog.InvokeRequired)
            {
                SetTextCallback d = new SetTextCallback(Log);
                Invoke(d, new object[] { text });
            }
            else
            {
                txtLog.AppendText(text);
                txtLog.ScrollToCaret();
            }
        }

        public Form1()
        {
            InitializeComponent();
            cIDSAT = new ControliD.CIDSAT();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            numSessao = (numSessao + 1);
            Log(cIDSAT.ConsultarSAT(NewNumSessao()) + "\r\n");
        }

        private void btnStatus_Click(object sender, EventArgs e)
        {
            Log(cIDSAT.ConsultarStatusOperacional(NewNumSessao(), txtSenha.Text) + "\r\n");
        }

        private void btnFile_Click(object sender, EventArgs e)
        {
            DialogResult result = openFileDialog1.ShowDialog(); // Show the dialog.
            if (result == DialogResult.OK) // Test result.
            {
                txtFile.Text = openFileDialog1.FileName;
            }
        }

        private void btnVenda_Click(object sender, EventArgs e)
        {
            string venda = "";
            try
            {
                venda = File.ReadAllText(txtFile.Text);
            }
            catch (IOException ex)
            {
                Log(ex.Message + "\r\n");
            }

            Log(cIDSAT.EnviarDadosVenda(NewNumSessao(), txtSenha.Text, venda) + "\r\n");
        }
    }
}
