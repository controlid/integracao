using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace idAccess_Rest
{
    class BiometricResult
    {

        public byte[] ReadFully(Stream stream)
        {
            byte[] buffer = new byte[32768];
            using (MemoryStream ms = new MemoryStream())
            {
                while (true)
                {
                    int read = stream.Read(buffer, 0, buffer.Length);
                    if (read <= 0)
                        return ms.ToArray();
                    ms.Write(buffer, 0, read);
                }
            }
        }

        public Byte[] ResultIdentification(string session, string device_id, string identifier_id, string width, string height, Stream stream)
        {
           
            byte[] val = ReadFully(stream);
            Bitmap bp = new Bitmap(int.Parse(width), int.Parse(height));
            int w = Int32.Parse(width), h = Int32.Parse(height);
            for (int y = 0; y < h; y++)
            {
                for (int x = 0; x < w; x++)
                {
                    byte b = val[y * w + x];
                    bp.SetPixel(x, y, Color.FromArgb(255, b, b, b));
                }
            }
           return val;
        }
        public String ResultIdentification(string session, Stream stream)
        {
            byte[] val = ReadFully(stream);
            string msg = Encoding.UTF8.GetString(val);
            return msg;
        }
        public String ResultIdentification(Stream stream)
        {
           
            byte[] val = ReadFully(stream);
            string msg = Encoding.UTF8.GetString(val);
            return msg;
        }

        public DeviceIsAliveResult sendDevice()
        {
            DeviceIsAlive dev = new DeviceIsAlive();
            DeviceIsAliveResult devResult = new DeviceIsAliveResult();
            HttpStatusCode http = new HttpStatusCode();
            http = (HttpStatusCode)200;
            dev.@event = http;
            devResult.result = dev;
            return devResult;
        }
     

        public BiometricImageResult sendMessage()
        {
            BiometricImage bio = new BiometricImage();
           // var random = new Random();
            //event 7 libera, event 3 bloqueia
            bio.@event = 7;
            bio.user_id = 1;
            bio.user_name = "Mauro";
            bio.portal_id = 1;
            bio.user_image = false;
            Actions ac = new Actions();
            ac.action = "catra";
            ac.parameters = "allow=clockwise";
            bio.actions = new Actions[1];
            bio.actions[0] = ac;
            BiometricImageResult bioRes = new BiometricImageResult();
            bioRes.result = bio;
            Thread.Sleep(500);
            return bioRes;
        }
    }
}
