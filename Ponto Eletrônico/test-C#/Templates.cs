using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Controlid;
using System.Drawing;
using System.Collections.Generic;
using System.Net;
using System.IO;
using Controlid.iDClass;

namespace RepTestAPI
{
    [TestClass]
    public class Templates
    {
        [TestMethod, TestCategory("RepCid")]
        public void Template_ExtractJoin()
        {
            RepCid rep = Config.ConectarREP(); // Cria a conexão padrão (veja config.cs)
            byte[][] btResult = new byte[3][];
            for (int i = 1; i <= 3; i++)
            {
                Bitmap digital = new Bitmap(@"..\..\dedo" + i + ".bmp");
                byte[] btRequest = RepCid.GetBytes(digital); // transforme o bitmap em bytes no padrão necessário para ser enviado ao equipamento

                if (!rep.ExtractTemplate(btRequest, digital.Width, digital.Height, out btResult[i - 1]))
                {
                    Console.WriteLine(rep.LastLog());
                    Assert.Fail("Erro ao extrair Template " + i);
                }
                Console.WriteLine("LastQuality: " + RestJSON.LastQuality); // somente se for iDClass
                Console.WriteLine("Template: " + Convert.ToBase64String(btResult[i - 1]));
            }
            byte[] btJoin;
            rep.JoinTemplates(btResult[0], btResult[1], btResult[2], out btJoin);
            Console.WriteLine("Template: " + Convert.ToBase64String(btJoin));
            //Console.WriteLine(string.Format("Código: {0}\nErro: {1}\nQualidade: {2}\nTemplate: {3}", tr.code, tr.error, tr.Qualidate, tr.Template));  
        }
    }
}