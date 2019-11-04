using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Controlid;
using Controlid.iDClass;
using System.Threading;

namespace RepTestAPI
{
    [TestClass]
    public class ThreadSafe
    {
        static int nTask;
        [TestMethod, TestCategory("API")]
        public void Test2Reps()
        {
            Thread thr1 = new Thread(TestRepUsers);
            Thread thr2 = new Thread(TestRepUsers);

            nTask = 1;
            thr1.Start("192.168.0.131");
            thr2.Start("192.168.0.132");

            Thread.Sleep(5000);
            Console.WriteLine("Fim???");

            Console.WriteLine("Thread1: " + thr1.ThreadState.ToString());
            Console.WriteLine("Thread2: " + thr2.ThreadState.ToString());

        }

        public static void TestRepUsers(object prm)
        {
            string cIP = (string)prm;
            int nREP = nTask;
            nTask++;
            RepCid rep = new RepCid();
            Controlid.RepCid.ErrosRep status = rep.Conectar(cIP, 1818);
            if (status == RepCid.ErrosRep.OK)
                Console.WriteLine("REP" + nREP + ": Conectado");
            else
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("REP" + nREP + ": Erro ao conectar! " + status.ToString());
            }

            int qtd;
            if (!rep.CarregarUsuarios(true, out qtd))
                Assert.Fail("Erro ao carregar usuários do REP" + nREP);

            Console.WriteLine("REP" + nREP + ": Usuários: " + qtd);

            Int64 pis;
            string nome;
            int codigo;
            string senha;
            string barras;
            int rfid;
            int privilegios;
            int ndig;
            while (rep.LerUsuario(out pis, out nome, out codigo, out senha, out barras, out rfid, out privilegios, out ndig))
                Console.WriteLine(string.Format("REP" + nREP + ": {0}:{1} {2}:{3} {4}|{5} {6} {7}", pis, nome, codigo, senha, barras, rfid, privilegios, ndig));

        }
    }
}