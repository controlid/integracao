using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Controlid;
using Controlid.iDClass;

namespace RepTestAPI
{
    [TestClass]
    public class Empregador
    {
        RepCid rep;

        [TestInitialize]
        public void Conectar()
        {
            rep = Config.ConectarREP();
        }

        [TestMethod, TestCategory("RepCid")]
        public void Empregador_Get()
        {
            string doc;
            int tipodoc;
            string cei;
            string razsoc;
            string endereco;

            if (rep.LerEmpregador(out doc, out tipodoc, out cei, out razsoc, out endereco))
            {
                Console.WriteLine("Documento: " + doc);
                Console.WriteLine("Tipo DOC: " + tipodoc);
                Console.WriteLine("CEI: " + cei);
                Console.WriteLine("Razão Social: " + razsoc);
                Console.WriteLine("Endereço: " + endereco);
            }
            else
                Assert.Fail("Erro ao Ler o empregador");
        }

        [TestMethod, TestCategory("RepCid")]
        public void Empregador_Get_iDClass()
        {
            string doc;
            int tipodoc;
            string cei;
            string razsoc;
            string endereco;
            string cpf;

            if (rep.iDClass_LerEmpregador(out doc, out tipodoc, out cei, out razsoc, out endereco, out cpf))
            {
                Console.WriteLine("Documento: " + doc);
                Console.WriteLine("Tipo DOC: " + tipodoc);
                Console.WriteLine("CEI: " + cei);
                Console.WriteLine("Razão Social: " + razsoc);
                Console.WriteLine("Endereço: " + endereco);
                Console.WriteLine("CPF: " + cpf);
            }
            else
                Assert.Fail("Erro ao Ler o empregador do iDClass");
        }

        [TestMethod, TestCategory("RepCid")]
        public void Empregador_Set()
        {
            //------------05343346000106
            string doc = "12345678901234"; // Não pode enviar com mascara! (só numeros: 14 digitos)
            int tipodoc = 1;
            string cei = "123456789";
            string razsoc = "Control iD Teste API";
            string endereco = "Rua Hungria, 888";
            bool gravou;

            if (rep.GravarEmpregador(doc, tipodoc, cei, razsoc, endereco, out gravou) && gravou)
                Console.WriteLine("OK, empregador gravado");
            else
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao gravar empregador");
            }
        }

        [TestMethod, TestCategory("RepCid")]
        public void Empregador_Set_iDClass()
        {
            //------------05343346000106
            string doc = "98123456000212"; // Não pode enviar com mascara! (só numeros: 14 digitos)
            int tipodoc = 1;
            string cei = "885522";
            string razsoc = "Control iD Teste API";
            string endereco = "Rua Hungria, 888 andar 9";
            string cpf = "12345678912";
            bool gravou;

            if (rep.iDClass_GravarEmpregador(doc, tipodoc, cei, razsoc, endereco, cpf, out gravou) && gravou)
                Console.WriteLine("OK, empregador gravado no iDClass");
            else
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao gravar empregador");
            }
        }
    }
}