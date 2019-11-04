using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Controlid;
using Controlid.iDClass;
using System.Threading;

namespace RepTestAPI
{
    [TestClass]
    public class AFD
    {
        RepCid rep;

        [TestInitialize]
        public void Conectar()
        {
            rep = Config.ConectarREP();
        }

        [TestMethod, TestCategory("RepCid")]
        public void AFD_Completo()
        {
            Console.Write(rep.ObterCompletoAFD());
        }

        [TestMethod, TestCategory("RepCid")]
        public void AFD_Parcial()
        {
            if (rep.BuscarAFD(10))
            {
                string sLinha;
                int n = 0;
                // A leitura de linha sempre vem com \r\n
                while (rep.LerAFD(out sLinha))
                {
                    n++;
                    Console.Write(sLinha);
                }
                Console.WriteLine("\nTotal: " + n);
            }
            else
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Buscar AFD");
            }
        }
    }
}