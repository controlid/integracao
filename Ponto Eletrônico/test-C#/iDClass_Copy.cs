using Controlid;
using Controlid.iDClass;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;

namespace RepTestAPI
{
    [TestClass]
    public class iDClass_Copy
    {
        /// <summary>
        /// Exemplo de rotina que copia os usuários de um REP para outro
        /// (Este exemplo é exclusivo para iDClass)
        /// </summary>
        [TestMethod, TestCategory("Rep iDClass")]
        public void CopyAll()
        {
            try
            {
                // Para simplificar os dados de login serão os mesmos, o que mudará logico será o IP do REP!
                ConnectRequest login = new ConnectRequest()
                {
                    Login = "admin",
                    Password = "admin"
                };

                // Conecta-se com o primeiro REP
                var REP1 = "192.168.0.19";
                var cn1 = RestJSON.SendJson<ConnectResult>(REP1, login); // Origem
                if (!cn1.isOK)
                    Assert.Inconclusive(REP1 + ": " + cn1.Status);

                Console.WriteLine("REP1 Conectado");

                // Conecta-se com o segundo REP
                var REP2 = "192.168.2.105";
                var cn2 = RestJSON.SendJson<ConnectResult>(REP2, login); // Destino
                if (!cn2.isOK)
                    Assert.Inconclusive(REP2 + ": " + cn2.Status);

                Console.WriteLine("REP2 Conectado");

                // Este comando requisita somente os 10 primeiros registros (apenas para evitar erros de comunicação quando há muitos dados)
                // para simplificar este exemplo não será feito nenhum loop ou tratamento, isso será abordado no exemplo seguinte
                // Estando ambos os REP Conectados, primeiro lê todos os usuários do REP1, já com os templates em um único comando
                var userBlock = RestJSON.SendJson<UserResult>(REP1, new UserRequest() { Limit = 10, Templates=true }, cn2.Session);
                if (!userBlock.isOK)
                    Assert.Fail(REP1 + ": " + userBlock.Status);

                Console.WriteLine("REP1 Lido " + userBlock.ListUsers.Length + " usuários");

                // É gerado um arquivo "log-RepCID-iDClass.txt" na pasta onde fica a DLL que contem toda a comunicação
                // Mas é possivel desabilitar o log de comunicação, por padrão vem habilitado por ser é bem util no desenvolvimento ou para encontrar problemas
                // RestJSON.WriteLog = false; 
                // Evite manter isso ligado em produção para não acabar com o espaço em disco, pois esse log fica realmente muito grande
                // RestJSON.TimeOut = 30000;
                // É possivel também reconfigurar o timeout padrão das requisição

                // ATENÇÃO: por segurança só existe substituição de dados quando isso é feita de forma explicita!
                // Portanto os comandos de INSERT e UPDATE são distintos, e cada um tem validações específicas
                // var insertRequest = new UserAddRequest() { Usuario = userBlock.ListUsers }; // Não é possivel inserir pessoas com o mesmo PIS
                var modifyRequest = new UserUpdateRequest() { Usuario = userBlock.ListUsers }; // Não é possivel alterar pessoas que não existem (baseado no PIS, que é sempre o identificador único)

                var result = RestJSON.SendJson<StatusResult>(REP2, modifyRequest, cn2.Session);
                if (result.isOK)
                    Console.Write(result.Status);
                else
                    Assert.Inconclusive(result.Status);
            }
            catch(Exception ex)
            {
                // Erro desconhecido (qualquer erro que não vier do REP, incluindo erros de rede ou comunicação)
                Assert.Fail(ex.Message);
            }
        }

        /// <summary>
        /// Apenas lista todos os usuários de um REP
        /// </summary>
        [TestMethod, TestCategory("Rep iDClass")]
        public void ListAll()
        {
            try
            {
                // Para simplificar os dados de login serão os mesmos, o que mudará logico será o IP do REP!
                ConnectRequest login = new ConnectRequest()
                {
                    Login = "admin",
                    Password = "admin"
                };

                // Conecta-se com o primeiro REP
                var REP1 = "192.168.0.19";
                var cn1 = RestJSON.SendJson<ConnectResult>(REP1, login); // Origem
                if (!cn1.isOK)
                    Assert.Inconclusive(REP1 + ": " + cn1.Status);

                Console.WriteLine("REP1 Conectado");

                // Lista todos os usuários em blocos de 10
                var uReq = new UserRequest() { Limit = 10 }; // sem o template
                // É necessário paginar por diversos motivos, principalmente quando o número de usuários é grande, e usa-se biometria
                // Paginando é possivel fazer barras de progresso, deixando o sistema mais amigavel, sem isso a rotina fica travada até ser feita toda a comunicação
                // Também há limites do empactamento JSON de 2MB, e de limite de memória interna no REP, pois os templates em geral são grandes
                // Ao listar usuários sem templates não há problemas de pegar tudo em único comando, mas quando se usa biometria ai tem que paginar mesmo.
                int nTotal = 0;
                do
                {
                    var userBlock = RestJSON.SendJson<UserResult>(REP1, uReq, cn1.Session);
                    if (!userBlock.isOK)
                        Assert.Fail(REP1 + ": " + userBlock.Status);

                    // Totaliza e verifica se terminou
                    nTotal += userBlock.ListUsers.Length;
                    if (nTotal >= userBlock.TotalUsers || userBlock.ListUsers.Length == 0)
                        break;

                    foreach (var user in userBlock.ListUsers)
                        Console.WriteLine(user.PIS + ": " + user.Nome + " - " + user.Barras + " - " + user.RfId + " - " + user.TemplatesCount);
                    // O numero de templates é informado, mas não foi carregado no request!

                    // Proximó bloco de registros
                    uReq.Offset += uReq.Limit;
                } while (true);
            }
            catch (Exception ex)
            {
                // Erro desconhecido (qualquer erro que não vier do REP, incluindo erros de rede ou comunicação)
                Assert.Fail(ex.Message);
            }
        }
    }
}