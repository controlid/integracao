using Controlid;
using Controlid.iDClass;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RepTestAPI
{
    [TestClass]
    public class iDClass
    {
        string session;

        [TestInitialize]
        public void Conectar()
        {
            // É possivel se comunicar diretamente com REP iDClass via chamadas JSON
            ConnectRequest login = new ConnectRequest()
            {
                Login = Config.repLogin,
                Password = Config.repSenha
            };

            ConnectResult cn = RestJSON.SendJson<ConnectResult>(Config.repIP, login);
            if (cn.isOK)
                session = cn.Session;
            else
                Assert.Inconclusive(cn.Status);
        }

        [TestMethod, TestCategory("Rep iDClass")]
        public void Usuario_ChangePIS()
        {
            UserUpdateRequest uur = new UserUpdateRequest();

            uur.Usuario[0].PIS = 108;
            uur.Usuario[0].PIS2 = 223344;
            uur.Usuario[0].Nome = "Teste Change PIS (com template)";

            StatusResult st = RestJSON.SendJson<StatusResult>(Config.repIP, uur, session);
            if (!st.isOK)
                Assert.Inconclusive(st.Status);

        }

        [TestMethod, TestCategory("Rep iDClass")]
        public void Usuario_SaveTemplate()
        {
            UserAddRequest uur = new UserAddRequest();

            uur.Usuario[0].PIS = (ulong)Config.pisTEST;
            uur.Usuario[0].Nome = "Fabio Teste";
            string template_iDX = "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AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==";
            string template_iDClass = RepCid.TemplateToiDClass(Convert.FromBase64String(template_iDX));

            uur.Usuario[0].Templates = new string[] { template_iDClass };

            StatusResult st = RestJSON.SendJson<StatusResult>(Config.repIP, uur, session);
            if (!st.isOK)
                Assert.Inconclusive(st.Status);

        }

        [TestMethod, TestCategory("Rep iDClass")]
        public void Usuario_JSON()
        {
            // Exemplo de criação de um usuário
            User usr = new User()
            {
                PIS = (ulong)(Config.pisTEST * 2),
                Nome = "Usuario via JSON Adicionado",
                Matricula = 33467L,
                Codigo = 234, // código para login via teclado
                Senha = "567",
                RfId = 8899,
                Barras = "12345",
                Admin = false
            };

            // Solicita a inclusão deste usuário
            StatusResult st = RestJSON.SendJson<StatusResult>(Config.repIP, new UserAddRequest(usr), session);
            if (!st.isOK)
                Assert.Inconclusive(st.Status);

            // Lembrando que toda alteração cadastral fica sempre gravada no AFD
            usr.Nome = "Nome alterado via JSON";
            st = RestJSON.SendJson<StatusResult>(Config.repIP, new UserUpdateRequest(usr), session);
            if (!st.isOK)
                Assert.Inconclusive(st.Status);

            // mesmo apagando é possivel ver a alteração no AFD
            st = RestJSON.SendJson<StatusResult>(Config.repIP, new UserDeleteRequest(usr.PIS), session);
            if (!st.isOK)
                Assert.Inconclusive(st.Status);
        }

        [TestMethod, TestCategory("Rep iDClass")]
        public void Empregador_JSON()
        {
            // Exemplo de criação de um usuário
            Company emp = new Company()
            {
                RazaoSocial = "Teste de Empregador",
                Documento = 12345678000123,
                DocumentoTipo = 1,
                Endereco = "Rua de qualquer lugar, bairro, cidade",
                CEI = 12345678,
                CPF = 1212312345
            };

            // Solicita a alteração do empregador 
            StatusResult st = RestJSON.SendJson<StatusResult>(Config.repIP, new EmpregadorRequest(emp), session);
            if (!st.isOK)
                Assert.Inconclusive(st.Status);

            // Solicita a alteração do empregador 
            EmpregadorResult empResult = RestJSON.SendJson<EmpregadorResult>(Config.repIP, "load_company", session);
            if (!st.isOK)
                Assert.Inconclusive(st.Status);

            Console.WriteLine(empResult.Empresa.RazaoSocial);
            Console.WriteLine(empResult.Empresa.Documento);
            Console.WriteLine(empResult.Empresa.DocumentoTipo);
            Console.WriteLine(empResult.Empresa.Endereco);
            Console.WriteLine(empResult.Empresa.CEI);
            Console.WriteLine(empResult.Empresa.CPF);
        }
    }
}