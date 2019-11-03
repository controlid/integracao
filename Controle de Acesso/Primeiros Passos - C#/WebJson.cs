using System;
using System.IO;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Text;

namespace ExemploAPI
{
    class WebJson
    {
        static WebJson()
        {
            ServicePointManager.Expect100Continue = false;
        }

        static public string Send(string uri, string data, string session = null)
        {
            if (session != null)
                uri += ".fcgi?session=" + session;
            else
                uri += ".fcgi";

            try
            {
                var request = (HttpWebRequest)WebRequest.Create(uri);
                request.ContentType = "application/json";
                request.Method = "POST";

                using (var streamWriter = new StreamWriter(request.GetRequestStream()))
                {
                    streamWriter.Write(data);
                }

                var response = (HttpWebResponse)request.GetResponse();
                using (var streamReader = new StreamReader(response.GetResponseStream()))
                {
                    return streamReader.ReadToEnd();
                }
            }
            catch (WebException e)
            {
                using (WebResponse response = e.Response)
                {
                    HttpWebResponse httpResponse = (HttpWebResponse)response;
                    Console.WriteLine("Error code: {0}", httpResponse.StatusCode);
                    using (Stream responseData = response.GetResponseStream())
                    using (var reader = new StreamReader(responseData))
                    {
                        throw new Exception(reader.ReadToEnd());
                    }
                }
            }
        }

        // Rotina com parser Json de saída (a entrada 'data' poderia ter a mesma logica, mas para não complicar muito vou fazer apenas a saida)
        // Veja como seria a rotina completa neste outro exemplo: https://github.com/controlid/RepCid/blob/master/test-CS-Futronic/RestJSON.cs
        static public T Send<T>(string uri, string data, string session = null)
        {
            if (session != null)
                uri += ".fcgi?session=" + session;
            else
                uri += ".fcgi";

            try
            {
                var request = (HttpWebRequest)WebRequest.Create(uri);
                request.ContentType = "application/json";
                request.Method = "POST";

                using (var streamWriter = new StreamWriter(request.GetRequestStream()))
                {
                    streamWriter.Write(data);
                }

                // Fica até menor a rotina!
                var response = (HttpWebResponse)request.GetResponse();
                var serializer = new DataContractJsonSerializer(typeof(T));
                return (T)serializer.ReadObject(response.GetResponseStream());
            }
            catch (WebException e)
            {
                using (WebResponse response = e.Response)
                {
                    HttpWebResponse httpResponse = (HttpWebResponse)response;
                    Console.WriteLine("Error code: {0}", httpResponse.StatusCode);
                    using (Stream responseData = response.GetResponseStream())
                    using (var reader = new StreamReader(responseData))
                    {
                        throw new Exception(reader.ReadToEnd());
                    }
                }
            }
        }
    }
}
