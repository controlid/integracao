using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Controlid;
using Controlid.iDClass;
using System.Text;

namespace RepTestAPI
{
    [TestClass]
    public class JSon
    {
        [TestMethod, TestCategory("API")]
        public void TestSimpleJson()
        {
            String cResult = RestJSON.SendJsonSimple("https://192.168.0.145/login.fcgi", "{\"login\":\"admin\",\"password\":\"admin\"}");
            Console.WriteLine(cResult);
            Assert.IsTrue(cResult.Contains("session"), "Erro ao fazer o login");
        }

        [TestMethod, TestCategory("API")]
        public void TestParseResult()
        {
            string html = @"HTTP/1.1 200 OK
Access-Control-Allow-Origin: *
Access-Control-Allow-Headers: origin, x-csrftoken, content-type, accept
Vary: Origin
Allow: GET, HEAD
Content-Type: application/json; charset=utf-8
Content-Length: 90

{""mac"":""02:31:37:26:32:45"",""nSerie"":""00014000010000001"",""versionFW"":536,""versionMRP"":1048}";

            AboutResult ar = RestJSON.JsonFrom<AboutResult>(Encoding.UTF8.GetBytes(html));
            Console.WriteLine(string.Format("Serie: {0} FW: {1} MRP: {2}", ar.NumeroSerie, ar.VersionFW, ar.VersionMRP));
        }
    }
}