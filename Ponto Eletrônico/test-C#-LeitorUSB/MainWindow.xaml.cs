using System;
using System.Drawing;
using System.Windows;
using System.Windows.Media;
using System.Windows.Threading;

namespace TestFutronic
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        Futronic leitor; // contrala a API leitor Frutronic
        DispatcherTimer timer; // timer que busca novos eventos a cada 1 segundo
        int dedo; // contado da posição do dedo

        Equipamento equip; // um REP ou iDAccess na rede para fazer a extração e junção de templates
        string[] templates;

        public MainWindow()
        {
            InitializeComponent();

            // meus componentes
            leitor = new Futronic();
            timer = new DispatcherTimer();
            equip = new Equipamento();
            templates = new string[3]; // templates dos 3 dedos
        }

        private void Window_Load(object sender, RoutedEventArgs e)
        {
            dedo = 1;
            timer.Interval = TimeSpan.FromSeconds(1);
            timer.Tick += timer_Tick;
            timer.Start();

            equip.Login("https://192.168.0.19"); // REP iDClass (informar HTTPS é obrigatório)
            //equip.Login("http://192.168.2.102"); // Controlador de acesso

            txtEquip.Text = equip.Status;
        }

        private void Window_Closed(object sender, EventArgs e)
        {
            timer.Stop();
            if (leitor.Connected)
                leitor.Dispose();
        }

        void timer_Tick(object sender, EventArgs e)
        {
            try
            {
                if (leitor.Connected)
                {
                    DateTime dt = DateTime.Now;
                    if (leitor.IsFinger())
                    {
                        using (Bitmap bmp = leitor.ExportBitMap())
                        {
                            double t = DateTime.Now.Subtract(dt).TotalMilliseconds;
                            switch (dedo)
                            {
                                case 1:
                                    dedo1.Source = bmp.ToBitmapSource();
                                    break;
                                case 2:
                                    dedo2.Source = bmp.ToBitmapSource();
                                    break;
                                case 3:
                                    dedo3.Source = bmp.ToBitmapSource();
                                    break;
                            }
                            txtLeitor.Text = string.Format("Captura da Digital {0} - Tempo de obtenção do leitor: {1:0.0}ms", dedo, t);

                            // Essa parte por ser remota costuma ser lenta
                            dt = DateTime.Now;
                            int qualidade;
                            templates[dedo - 1] = equip.ExtractTemplate(bmp, out qualidade);
                            t = DateTime.Now.Subtract(dt).TotalMilliseconds;
                            txtEquip.Text = string.Format("Qualidade do Template: {0}% - Tempo de transmissão: {1:0.0}ms", qualidade, t);

                            if (qualidade > 50)
                                // vai para o proximo dedo se a qualidade for aceitável
                                dedo++;
                            else
                                txtLeitor.Text += "\r\nQualidade muito baixa, coloque o dedo novamente";

                            if (dedo > 3)
                            {
                                dt = DateTime.Now;
                                string info;
                                equip.MergeTemplate(templates, out info);
                                t = DateTime.Now.Subtract(dt).TotalMilliseconds;
                                txtEquip.Text += string.Format("\r\nMerge Templates concluido: {0} - Tempo de transmissão: {1:0.0}ms", info, t);
                                dedo = 1;
                            }
                        }
                    }
                    //else
                    //    txtLeitor.Text = "Coloque o dedo para a imagem " + dedo;
                }
                else
                {
                    if (leitor.Init())
                        txtLeitor.Text = "Leitor Futronic FS-80 reconhecido";
                    else
                        txtLeitor.Text = "Conecte o leitor Futronic FS-80 !";
                }
            }
            catch (Exception ex)
            {
                txtLeitor.Text = ex.Message;
            }
        }
    }
}