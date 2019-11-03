using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Threading.Tasks;
using System.Windows.Forms;
using ControliD;

namespace CaptureExample
{
    public partial class Example : Form
    {
        #region initilization

        private CIDBio idbio = new CIDBio();

        public Example()
        {
            InitializeComponent();
        }

        private void Example_Load(object sender, EventArgs e)
        {
            var ret = CIDBio.Init();
            if (ret == RetCode.SUCCESS)
            {
                captureLog.Text += "Init Successful\r\n";
                captureBtn.Enabled = true;
            }
            else if (ret < RetCode.SUCCESS)
            {
                captureLog.Text += "Init Error: " + CIDBio.GetErrorMessage(ret) + "\r\n";
            }
            else
            {
                captureLog.Text += "Init Warning: " + CIDBio.GetErrorMessage(ret) + "\r\n";
                captureBtn.Enabled = true;
            }
        }

        private void CaptureExample_FormClosed(object sender, FormClosedEventArgs e)
        {
            CIDBio.Terminate();
        }

        private void TabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (tabControl1.SelectedIndex)
            {
                case 1:
                    ReloadIDs();
                    break;
                case 2:
                    LoadAllConfig();
                    break;
                case 0:
                default:
                    return;
            }
        }

        #endregion

        #region capture

        private void EnableButtons(bool enable)
        {
            checkBtn.Enabled = enable;
            captureBtn.Enabled = enable;
            openUpdateFilebtn.Enabled = enable;
        }

        public static Bitmap ImageBufferToBitmap(byte[] imageBuf, uint width, uint height)
        {
            Bitmap img = new Bitmap((int)width, (int)height);
            for (int x = 0; x < img.Width; x++)
            {
                for (int y = 0; y < img.Height; y++)
                {
                    var color = Color.FromArgb(imageBuf[x + img.Width * y], imageBuf[x + img.Width * y], imageBuf[x + img.Width * y]);
                    img.SetPixel(x, y, color);
                }
            }
            return img;
        }

        private void RenderImage(byte[] imageBuf, uint width, uint height)
        {
            var img = ImageBufferToBitmap(imageBuf, width, height);
            fingerImage.Image = img;
            fingerImage.Width = img.Width;
            fingerImage.Height = img.Height;
        }

        private void CheckBtn_Click(object sender, EventArgs e)
        {
            EnableButtons(false);

            var ret = idbio.GetDeviceInfo(out string version, out string serialNumber, out string model);
            if (ret < RetCode.SUCCESS)
            {
                captureLog.Text += "GetDeviceInfo Error: " + CIDBio.GetErrorMessage(ret) + "\r\n";
            }
            else
            {
                SerialTextBox.Text = serialNumber;
                ModelTextBox.Text = model;
                VersionTextBox.Text = version;
            }
            EnableButtons(true);
        }

        struct FingerImage
        {
            public RetCode ret;
            public byte[] imageBuf;
            public uint width;
            public uint height;
        }

        private async void CaptureBtn_Click(object sender, EventArgs e)
        {
            EnableButtons(false);
            captureLog.Text += "Waiting for finger...\r\n";

            var img = await Task.Run(() => {
                return new FingerImage
                {
                    ret = idbio.CaptureImage(out byte[] imageBuf, out uint width, out uint height),
                    imageBuf = imageBuf,
                    width = width,
                    height = height
                };
            });

            if (img.ret < RetCode.SUCCESS)
            {
                captureLog.Text += "Capture Error: " + CIDBio.GetErrorMessage(img.ret) + "\r\n";
                fingerImage.Image = null;
            }
            else
            {
                captureLog.Text += "Capture Success\r\n";
                RenderImage(img.imageBuf, img.width, img.height);
            }

            EnableButtons(true);
        }

        private async void OpenUpdateFilebtn_Click(object sender, EventArgs e)
        {
            EnableButtons(false);
            if (updateFileDialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                if (MessageBox.Show("Are you sure you want to update iDBio with the file: " + updateFileDialog.FileName,
                                     "Confirm Update",
                                     MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    captureLog.Text += "Updating iDBio...\r\n";
                    var ret = await Task.Run(() => {
                        return idbio.UpdateFirmware(updateFileDialog.FileName);
                    });
                    if (ret < RetCode.SUCCESS)
                    {
                        captureLog.Text += "Error Updating: " + CIDBio.GetErrorMessage(ret) + "\r\n";
                    }
                    else
                    {
                        captureLog.Text += "Update Successful!\r\n";
                    }
                }
            }
            EnableButtons(true);
        }

        private void CaptureLog_TextChanged(object sender, EventArgs e)
        {
            // set the current caret position to the end
            captureLog.SelectionStart = captureLog.Text.Length;
            // scroll it automatically
            captureLog.ScrollToCaret();
        }

        #endregion

        #region identification

        private void EnableIdentifyButtons(bool enable)
        {

            readAllBtn.Enabled = enable;
            enrollBtn.Enabled = enable;
            IdentifyBtn.Enabled = enable;
            deleteAllBtn.Enabled = enable;
        }

        private void ReloadIDs()
        {
            var ret = idbio.GetTemplateIDs(out long[] ids);
            if (ret < RetCode.SUCCESS)
            {
                IdentifyLog.Text += "Error Reading IDs: " + CIDBio.GetErrorMessage(ret) + "\r\n";
            }
            else
            {
                iDsList.Items.Clear();
                foreach (var id in ids)
                {
                    iDsList.Items.Add(id.ToString());
                }
            }
        }

        private void ReadAllBtn_Click(object sender, EventArgs e)
        {
            ReloadIDs();
        }

        private void DeleteAllBtn_Click(object sender, EventArgs e)
        {
            var ret = idbio.DeleteAllTemplates();
            if (ret < RetCode.SUCCESS)
            {
                IdentifyLog.Text += "Error Deleting IDs: " + CIDBio.GetErrorMessage(ret) + "\r\n";
            }
            else
            {
                IdentifyLog.Text += "IDs Deleted\r\n";
            }
            ReloadIDs();
        }

        private async void EnrollBtn_Click(object sender, EventArgs e)
        {
            EnableIdentifyButtons(false);
            try
            {
                long id = long.Parse(enrollIDTextBox.Text);

                IdentifyLog.Text += "Enrolling... Press your finger 3 times on the device\r\n";
                var ret = await Task.Run(() => {
                    return idbio.CaptureAndEnroll(id);
                });
                if (ret < RetCode.SUCCESS)
                {
                    IdentifyLog.Text += "Error Enrolling: " + CIDBio.GetErrorMessage(ret) + "\r\n";
                }
                else
                {
                    IdentifyLog.Text += "ID " + id + " Enrolled\r\n";
                }
                ReloadIDs();
            }
            catch (Exception ex)
            {
                IdentifyLog.Text += "Invalid ID: " + ex.Message + "\r\n";
            }
            EnableIdentifyButtons(true);
        }

        struct IdentifyRet
        {
            public RetCode ret;
            public long id;
            public int score;
            public int quality;
        }

        private async void IdentifyBtn_Click(object sender, EventArgs e)
        {
            EnableIdentifyButtons(false);

            IdentifyLog.Text += "Identifying...\r\n";
            var identify = await Task.Run(() => {
                return new IdentifyRet
                {
                    ret = idbio.CaptureAndIdentify(out long id, out int score, out int quality),
                    id = id,
                    score = score,
                    quality = quality
                };
            });
            if (identify.ret < RetCode.SUCCESS)
            {
                IdentifyLog.Text += "Error Identifying: " + CIDBio.GetErrorMessage(identify.ret) + 
                    " (quality: " + identify.quality + ")\r\n";
                identifyTextBox.Text = "X";
            }
            else
            {
                IdentifyLog.Text += "ID " + identify.id + " Identified (score: " + identify.score + 
                    ", quality: " + identify.quality + ")\r\n";
                identifyTextBox.Text = identify.id.ToString();
            }

            EnableIdentifyButtons(true);
        }

        private void IdentifyLog_TextChanged(object sender, EventArgs e)
        {
            // set the current caret position to the end
            IdentifyLog.SelectionStart = IdentifyLog.Text.Length;
            // scroll it automatically
            IdentifyLog.ScrollToCaret();
        }

        #endregion

        #region configuration

        private static int FromTrack(int trackValue) => 500 * trackValue;
        private static int ToTrack(int value) => (int) (value/500);

        private static string ToString(ConfigParam param)
        {
            switch(param)
            {
                case ConfigParam.MIN_VAR: return "Min Var";
                case ConfigParam.SIMILIARITY_THRESHOLD: return "Similarity Threshold";
                case ConfigParam.BUZZER_ON: return "Buzzer";
                case ConfigParam.TEMPLATE_FORMAT: return "Template Format";
                default: return "Unknown";
            }
        }

        private void SaveConfig(ConfigParam param, string value)
        {
            var ret = idbio.SetParameter(param, value);
            if (ret < RetCode.SUCCESS)
            {
                configurationLog.Text += "Error setting parameter \"" + ToString(param) + "\" with value \"" + value + "\": " + CIDBio.GetErrorMessage(ret) + "\r\n";
            }
            else
            {
                configurationLog.Text += ToString(param) + " set successfully\r\n";
            }
        }

        private bool LoadConfig(ConfigParam param, out string value)
        {
            value = "";
            var ret = idbio.GetParameter(param, out  value);
            if (ret < RetCode.SUCCESS)
            {
                configurationLog.Text += "Error getting parameter \"" + ToString(param) + "\": " + CIDBio.GetErrorMessage(ret) + "\r\n";
                return false;
            }
            return true;
        }

        private void SaveAllConfig()
        {
            SaveConfig(ConfigParam.MIN_VAR, FromTrack(minVarTrack.Value).ToString());
            int threshold = chkAutomatic.Checked ? 0 : int.Parse(textBoxThreshold.Text);
            SaveConfig(ConfigParam.SIMILIARITY_THRESHOLD, threshold.ToString());
            SaveConfig(ConfigParam.BUZZER_ON, chkBuzzer.Checked ? "1" : "0");
        }

        private void LoadAllConfig()
        {
            if (LoadConfig(ConfigParam.MIN_VAR, out string minVar))
            {
                minVarTrack.Value = ToTrack(int.Parse(minVar));
            }
            
            if (LoadConfig(ConfigParam.SIMILIARITY_THRESHOLD, out string threshold))
            {
                textBoxThreshold.Text = threshold;
                chkAutomatic.Checked = threshold == "0";
            }

            if (LoadConfig(ConfigParam.BUZZER_ON, out string buzzer))
            {
                chkBuzzer.Checked = buzzer == "1";
            }
        }

        private void MinVarTrack_ValueChanged(object sender, EventArgs e)
        {
            SaveConfig(ConfigParam.MIN_VAR, FromTrack(minVarTrack.Value).ToString());
        }

        private void TextBoxThreshold_Leave(object sender, EventArgs e)
        {
            if(!int.TryParse(textBoxThreshold.Text, out int threshold))
            {
                textBoxThreshold.Text = "12300";
                return;
            }

            if (threshold == 0)
            {
                chkAutomatic.Checked = true;
                textBoxThreshold.Enabled = false;
            }
            else
            {
                chkAutomatic.Checked = false;
                textBoxThreshold.Enabled = true;
            }
            SaveConfig(ConfigParam.SIMILIARITY_THRESHOLD, threshold.ToString());
        }

        private void ChkAutomatic_CheckedChanged(object sender, EventArgs e)
        {
            if (chkAutomatic.Checked)
            {
                textBoxThreshold.Enabled = false;
                textBoxThreshold.Text = "0";
            }
            else
            {
                textBoxThreshold.Enabled = true;
                textBoxThreshold.Text = "12300";
            }
            SaveConfig(ConfigParam.SIMILIARITY_THRESHOLD, textBoxThreshold.Text);
        }

        private void ChkBuzzer_CheckedChanged(object sender, EventArgs e) => SaveConfig(ConfigParam.BUZZER_ON, chkBuzzer.Checked ? "1" : "0");

        private void BtnConfigDefault_Click(object sender, EventArgs e)
        {
            minVarTrack.Value = 2;
            textBoxThreshold.Text = "0";
            chkAutomatic.Checked = true;
            chkBuzzer.Checked = true;
            SaveAllConfig();
        }

        private void ConfigurationLog_TextChanged(object sender, EventArgs e)
        {
            // set the current caret position to the end
            configurationLog.SelectionStart = configurationLog.Text.Length;
            // scroll it automatically
            configurationLog.ScrollToCaret();
        }

        #endregion
    }
}
