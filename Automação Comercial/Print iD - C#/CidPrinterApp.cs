using System;
using System.Windows.Forms;
using CIDPrinter;

namespace WindowsFormsApp1
{
    public partial class CidPrinterApp : Form
    {
        public CidPrinterApp()
        {
            InitializeComponent();
            try
            {
                cidPrinter.Iniciar();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro ao inicializar: " + ex.Message);
            }
        }
        public static ICIDPrint cidPrinter = new CIDPrintiD();

        private void Init_Click(object sender, EventArgs e)
        {
            try
            {
                cidPrinter.Iniciar();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro ao inicializar: " + ex.Message);
            }
        }

        private void Reset_Click(object sender, EventArgs e)
        {
            try
            {
                cidPrinter.Reset();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro ao inicializar: " + ex.Message);
            }
        }

        private void Print_Click(object sender, EventArgs e)
        {
            try
            {
                cidPrinter.ImprimirFormatado(richtxtMain.Text + "\n", chkItalico.Checked, chkSub.Checked, false, chkNeg.Checked);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro ao inicializar: " + ex.Message);
            }
        }

        private void CutParcial_Click(object sender, EventArgs e)
        {
            try
            {
                cidPrinter.AtivarGuilhotina(TipoCorte.PARCIAL);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro ao inicializar: " + ex.Message);
            }
        }

        private void CutTotal_Click(object sender, EventArgs e)
        {
            try
            {
                cidPrinter.AtivarGuilhotina(TipoCorte.TOTAL);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro ao inicializar: " + ex.Message);
            }
        }

        private void Bar_Click(object sender, EventArgs e)
        {
            try
            {
                TipoCodigoBarras tipo = TipoCodigoBarras.UPC_A;
                switch ((string)cmbBoxBar.SelectedValue)
                {
                    case "UPC_A":
                        tipo = TipoCodigoBarras.UPC_A;
                        break;
                    case "EAN13":
                        tipo = TipoCodigoBarras.EAN13;
                        break;
                    case "EAN8":
                        tipo = TipoCodigoBarras.EAN8;
                        break;
                    case "CODE39":
                        tipo = TipoCodigoBarras.CODE39;
                        break;
                    case "ITF":
                        tipo = TipoCodigoBarras.ITF;
                        break;
                    case "CODABAR":
                        tipo = TipoCodigoBarras.CODABAR;
                        break;
                    case "CODE93":
                        tipo = TipoCodigoBarras.CODE93;
                        break;
                    case "CODE128":
                        tipo = TipoCodigoBarras.CODE128;
                        break;
                    default:
                        tipo = TipoCodigoBarras.UPC_A;
                        break;
                }

                cidPrinter.ConfigurarCodigoDeBarras();
                cidPrinter.ImprimirCodigoDeBarras(txtBar.Text, tipo);
                cidPrinter.AtivarGuilhotina(TipoCorte.PARCIAL);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro ao inicializar: " + ex.Message);
            }
        }

        private void PrintTest_Click(object sender, EventArgs e)
        {
            try
            {
                cidPrinter.ImprimirTeste();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro ao inicializar: " + ex.Message);
            }
        }

        private void BtnQr_Click(object sender, EventArgs e)
        {
            cidPrinter.ImprimirCodigoQR(txtQrCode.Text);
            cidPrinter.AtivarGuilhotina(TipoCorte.PARCIAL);
        }
    }
}
