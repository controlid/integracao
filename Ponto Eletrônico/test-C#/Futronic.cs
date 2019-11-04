using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Controlid;
using System.Drawing;
using System.Collections.Generic;
using System.Net;
using System.IO;
using Controlid.iDClass;
using System.Runtime.InteropServices;
using System.Drawing.Imaging;

// ftrScanAPI.dll deve estar no mesmo diretório
namespace RepTestAPI
{
    [TestClass]
    public class Futronic
    {
        #region "Futronic DRIVER API"

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
            set { }
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

            var b = new Bitmap(t.nWidth, t.nHeight);
            for (int x = 0; x < t.nWidth; x++)
                for (int y = 0; y < t.nHeight; y++)
                {
                    int a = 255 - arr[y * t.nWidth + x];
                    b.SetPixel(x, y, Color.FromArgb(a, a, a));
                }
            return b;
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
            return ftrScanIsFingerPresent(device, out t);
        }

        #endregion

        [TestMethod, TestCategory("API")]
        public void Futronic_Test()
        {
            if (Init())
            {
                Console.WriteLine("Init OK");
                if (IsFinger())
                {
                    Console.WriteLine("Tem Dedo");
                    Bitmap bmp = ExportBitMap();
                    bmp.Save("digital.bmp", ImageFormat.Png);
                    Console.WriteLine("Digital gravada");
                }
                else
                    Assert.Inconclusive("Teste inserindo um dedo");
            }
            else
                Assert.Inconclusive("Init Error: O sensor pode não estar conectado");
        }
    }
}