using System;
using System.Reflection;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.IO;
using System.Net;
using System.Net.Security;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using System.Drawing.Imaging;

namespace TestFutronic
{
    // REST Services JSON https://msdn.microsoft.com/en-us/library/hh674188.aspx
    // .Net 4.5: JSON https://msdn.microsoft.com/pt-br/library/windows/apps/xaml/hh770289.aspx
    public class RestJSON
    {
        static RestJSON()
        {
            // para não quebrar nenhum pacote
            ServicePointManager.Expect100Continue = false;

            // Para autorizar qualquer certificado SSL
            // http://stackoverflow.com/questions/18454292/system-net-certificatepolicy-to-servercertificatevalidationcallback-accept-all-c
            ServicePointManager.ServerCertificateValidationCallback = (object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) => { return true; };

            // Permite o uso de SSL auto assinados
            SetAllowUnsafeHeaderParsing20();
        }

        // https://o2platform.wordpress.com/2010/10/20/dealing-with-the-server-committed-a-protocol-violation-sectionresponsestatusline/
        public static bool SetAllowUnsafeHeaderParsing20()
        {
            //Get the assembly that contains the internal class
            Assembly aNetAssembly = Assembly.GetAssembly(typeof(System.Net.Configuration.SettingsSection));
            if (aNetAssembly != null)
            {
                //Use the assembly in order to get the internal type for the internal class
                Type aSettingsType = aNetAssembly.GetType("System.Net.Configuration.SettingsSectionInternal");
                if (aSettingsType != null)
                {
                    //Use the internal static property to get an instance of the internal settings class.
                    //If the static instance isn't created allready the property will create it for us.
                    object anInstance = aSettingsType.InvokeMember("Section",
                    BindingFlags.Static | BindingFlags.GetProperty | BindingFlags.NonPublic, null, null, new object[] { });
                    if (anInstance != null)
                    {
                        //Locate the private bool field that tells the framework is unsafe header parsing should be allowed or not
                        FieldInfo aUseUnsafeHeaderParsing = aSettingsType.GetField("useUnsafeHeaderParsing", BindingFlags.NonPublic | BindingFlags.Instance);
                        if (aUseUnsafeHeaderParsing != null)
                        {
                            aUseUnsafeHeaderParsing.SetValue(anInstance, true);
                            return true;
                        }
                    }
                }
            }
            return false;
        }

        /// <summary>
        /// Faz uma chamada JSON a URL especificada serializando um objeto, e devolvendo outro do tipo esperado
        /// </summary>
        public static T Send<T>(string cURL, object objSend = null)
        {
            string cSend = null;
            string cReceive = null;
            Type tpResult = typeof(T);
            object result;
            try
            {
                if (objSend != null)
                {
                    Type tpSend = objSend.GetType();
                    DataContractAttribute dca = (DataContractAttribute)Attribute.GetCustomAttribute(tpSend, typeof(DataContractAttribute));
                    if (dca != null)
                        cURL += dca.Name + ".fcgi";
                }

                WebRequest request = WebRequest.Create(cURL);
                if (tpResult == typeof(Byte[]) || tpResult == typeof(Bitmap))
                    request.Method = "GET";
                else
                {
                    request.Method = "POST";
                    using (var send = request.GetRequestStream())
                    {
                        if (objSend != null)
                        {
                            Type tpSend = objSend.GetType();
                            if (tpSend == typeof(Bitmap))
                            {
                                request.ContentType = "application/octet-stream";
                                ((Bitmap)objSend).Save(send, ImageFormat.Jpeg);
                            }
                            else if (tpSend == typeof(byte[]))
                            {
                                request.ContentType = "application/octet-stream";
                                byte[] bt = (byte[])objSend;
                                send.Write(bt, 0, bt.Length);
                            }
                            else
                            {
                                request.ContentType = "application/json";
                                if (tpSend == typeof(string))
                                {
                                    Byte[] bt = UTF8Encoding.UTF8.GetBytes(cSend);
                                    send.Write(bt, 0, bt.Length);
                                }
                                else
                                    new DataContractJsonSerializer(tpSend).WriteObject(send, objSend);
                            }
                        }
                    }
                }

                using (var response = request.GetResponse())
                {
                    if (tpResult == typeof(Bitmap))
                        result = Bitmap.FromStream(response.GetResponseStream());

                    else if (tpResult == typeof(Byte[]))
                    {
                        List<byte> receive = new List<byte>();
                        using (Stream str = response.GetResponseStream())
                        {
                            // Baixa em um cache de 4K 
                            int nCount;
                            byte[] cache = new byte[4096];
                            while ((nCount = str.Read(cache, 0, cache.Length)) == cache.Length)
                                receive.AddRange(cache);

                            // Remove do cache a área extra
                            if (nCount > 0 && nCount < cache.Length)
                                receive.RemoveRange(cache.Length - nCount, nCount);
                        }
                        result = ((object)receive.ToArray());
                    }
                    else if (tpResult != typeof(string))
                        result = new DataContractJsonSerializer(tpResult).ReadObject(response.GetResponseStream());
                    else
                    {
                        using (StreamReader sr = new StreamReader(response.GetResponseStream()))
                            cReceive = sr.ReadToEnd();

                        result = ((object)cReceive);
                    }
                }
            }
            catch (Exception ex)
            {
                WebException wex = null;
                if (tpResult == typeof(Bitmap))
                    return (T)((object)null); // Sem imagem
                else if (ex is WebException)
                    wex = (WebException)ex;
                else if (ex.InnerException != null && ex.InnerException is WebException)
                    wex = (WebException)ex.InnerException;

                if (wex != null)
                {
                    if (wex.Response != null)
                    {
                        HttpWebResponse response = (HttpWebResponse)wex.Response;
                        using (StreamReader sr = new StreamReader(response.GetResponseStream()))
                            cReceive = sr.ReadToEnd();

                        if (cReceive.Contains("{")) // provavel JSON!
                        {
                            try
                            {
                                using (MemoryStream ms = new MemoryStream())
                                {
                                    byte[] bt = UTF8Encoding.UTF8.GetBytes(cReceive);
                                    ms.Write(bt, 0, bt.Length);
                                    ms.Position = 0;
                                    result = new DataContractJsonSerializer(tpResult).ReadObject(ms);
                                }
                            }
                            catch (Exception)
                            {
                                throw new Exception("ERRO JSON", ex);
                            }
                        }
                        else
                            throw new Exception("ERRO RESPONSE: " + cReceive, ex);
                    }
                    else
                        throw new Exception("ERRO WEB", ex);
                }
                else
                    throw new Exception("ERRO GERAL", ex);
            }
            return (T)result;
        }
        
        /// <summary>
        /// Obtem os bytes monocromaticos de uma imagem
        /// </summary>
        public static byte[] GetBytes(Bitmap digital)
        {
            List<Byte> bt = new List<byte>();
            for (int y = 0; y < digital.Height; y++)
                for (int x = 0; x < digital.Width; x++)
                    bt.Add(digital.GetPixel(x, y).G);

            return bt.ToArray();
        }
    }
}