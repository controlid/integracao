using System;
using System.Text;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Controlid;

namespace RepTestAPI
{

    [TestClass]
    public class Connect
    {

        [TestMethod, TestCategory("RepCid")]
        public void ConnectLoop()
        {
            int tries = 10;
            Console.WriteLine("Tentando se conectar {0} vezes com REP no endereço {1}:{2}", tries, Config.repIP, Config.repPort);
            RepCid rep = new RepCid();
            int idle = 0;
            for (int i = 0; i < tries; i++)
            {
                rep.iDClassLogin = Config.repLogin;
                rep.iDClassPassword = Config.repSenha;
                rep.ConnectTimeout = 15000;
                var status = rep.Conectar(Config.repIP, Config.repPort);
                rep.Desconectar();
                switch (status)
                {
                    case RepCid.ErrosRep.OK:
                        break;
                    case RepCid.ErrosRep.ErroNaoOcioso:
                        Console.WriteLine("Tentativa {0}: não ocioso", i);
                        idle++;
                        break;
                    default:
                        Assert.Fail("Tentativa {0}: erro inválido ({1})", i, status.ToString());
                        break;
                }
            }
            Console.WriteLine("Quantidade de tentativas com REP ocupado: {0}", idle);
        }
    }
}
