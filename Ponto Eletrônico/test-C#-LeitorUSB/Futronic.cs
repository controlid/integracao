using System;
using System.Drawing;
using System.Runtime.InteropServices;

// O arquivo "ftrScanAPI.dll" deve estar no mesmo diretório da executável
// Essa não é uma DLL DotNet, portanto não é referenciada da forma convencional, e sim por [DllImport()]
// O projeto deve ser compilado como x86 porque a DLL é 32bits (IMPORTANTE PARA MAQUINAS 64BITS)
// Essa classe originou-se do teste: https://github.com/controlid/RepCid/blob/master/test-CS/Futronic.cs
// E originalmente de: http://fingergraph.googlecode.com/svn/trunk/FingerGraph/Scanner/FutronicDrv/Device.cs
// É NECESSÁRIO BAIXAR O DRIVER DE ACORDO COM A VERSÃO DO WINDOWS: http://www.futronic-tech.com/download.html
namespace TestFutronic
{
    public class Futronic
    {

        #region Futronic API

        struct _FTRSCAN_FAKE_REPLICA_PARAMETERS
        {
            bool bCalculated;
            int nCalculatedSum1;
            int nCalculatedSumFuzzy;
            int nCalculatedSumEmpty;
            int nCalculatedSum2;
            double dblCalculatedTremor;
            double dblCalculatedValue;
        }

        struct _FTRSCAN_FRAME_PARAMETERS
        {
            int nContrastOnDose2;
            int nContrastOnDose4;
            int nDose;
            int nBrightnessOnDose1;
            int nBrightnessOnDose2;
            int nBrightnessOnDose3;
            int nBrightnessOnDose4;
            _FTRSCAN_FAKE_REPLICA_PARAMETERS FakeReplicaParams;
            _FTRSCAN_FAKE_REPLICA_PARAMETERS Reserved;

            public bool isOK { get { return nDose != -1; } } 
        }

        struct _FTRSCAN_IMAGE_SIZE
        {
            public int nWidth;
            public int nHeight;
            public int nImageSize;
        }

        [DllImport("ftrScanAPI.dll")]
        static extern bool ftrScanIsFingerPresent(IntPtr ftrHandle, out _FTRSCAN_FRAME_PARAMETERS pFrameParameters);
        [DllImport("ftrScanAPI.dll")]
        static extern IntPtr ftrScanOpenDevice();
        [DllImport("ftrScanAPI.dll")]
        static extern void ftrScanCloseDevice(IntPtr ftrHandle);
        [DllImport("ftrScanAPI.dll")]
        static extern bool ftrScanSetDiodesStatus(IntPtr ftrHandle, byte byGreenDiodeStatus, byte byRedDiodeStatus);
        [DllImport("ftrScanAPI.dll")]
        static extern bool ftrScanGetDiodesStatus(IntPtr ftrHandle, out bool pbIsGreenDiodeOn, out bool pbIsRedDiodeOn);
        [DllImport("ftrScanAPI.dll")]
        static extern bool ftrScanGetImageSize(IntPtr ftrHandle, out _FTRSCAN_IMAGE_SIZE pImageSize);
        [DllImport("ftrScanAPI.dll")]
        static extern bool ftrScanGetImage(IntPtr ftrHandle, int nDose, byte[] pBuffer);

        #endregion

        IntPtr device;

        public bool Init()
        {
            if (!Connected)
                device = ftrScanOpenDevice();
            return Connected;
        }

        public bool Connected
        {
            get { return (device != IntPtr.Zero); }
        }

        public void Dispose()
        {
            if (Connected)
            {
                ftrScanCloseDevice(device);
                device = IntPtr.Zero;
            }
        }

        public Bitmap ExportBitMap()
        {
            if (!Connected)
                return null;

            var t = new _FTRSCAN_IMAGE_SIZE();
            ftrScanGetImageSize(device, out t);
            byte[] arr = new byte[t.nImageSize];
            ftrScanGetImage(device, 4, arr);

            var bmp = new Bitmap(t.nWidth, t.nHeight);
            for (int x = 0; x < t.nWidth; x++)
            {
                for (int y = 0; y < t.nHeight; y++)
                {
                    int a = 255 - arr[y * t.nWidth + x];
                    bmp.SetPixel(x, y, Color.FromArgb(a, a, a));
                }
            }
            return bmp;
        }

        public void GetDiodesStatus(out bool green, out bool red)
        {
            ftrScanGetDiodesStatus(device, out green, out red);
        }

        public void SetDiodesStatus(bool green, bool red)
        {
            ftrScanSetDiodesStatus(device, (byte)(green ? 255 : 0), (byte)(red ? 255 : 0));
        }

        public bool IsFinger()
        {
            var t = new _FTRSCAN_FRAME_PARAMETERS();
            bool dedo = ftrScanIsFingerPresent(device, out t);
            if (!t.isOK)
            {
                Dispose();
                return false;
            }
            else
                return dedo;
        }
    }
}