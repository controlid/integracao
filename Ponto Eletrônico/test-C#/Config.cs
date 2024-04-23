using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Controlid;
using System.Threading;

namespace RepTestAPI
{
    [TestClass]
    public class Config
    {
        static RepCid rep;

        //public static readonly string repIP = "192.168.2.186"; // iDX
        public static readonly string repIP = "192.168.0.145"; // iDClass
        //public static readonly int repPort = 1818; // iDX
        public static readonly int repPort = 443; // iDClass
        public static readonly string repLogin = "admin"; // user
        public static readonly string repSenha = "admin"; // password
        public static readonly uint repiDXSenha = 0;

        // PIS: Fabio Ferreira
        public static Int64 pisTEST = 1; //012468202319; 

        public static RepCid ConectarREP()
        {
            if (rep == null)
            {
                rep = new RepCid();
                rep.iDClassLogin = repLogin;
                rep.iDClassPassword = repSenha;
                //rep.iDClassPort = 80; // Define o número da porta que deve ser considerado ser um iDClass (default 443)
                Controlid.RepCid.ErrosRep status = rep.Conectar(repIP, repPort, repiDXSenha); // Manda conectar na porta correta
                if (status == RepCid.ErrosRep.OK)
                    Console.WriteLine("REP Conectado");
                else
                {
                    Console.WriteLine(rep.LastLog());
                    Assert.Fail("Erro ao conectar: " + status.ToString());
                }
            }
            return rep;
        }

        [TestInitialize]
        public void Conectar()
        {
            ConectarREP();
        }

        [TestMethod, TestCategory("RepCid")]
        public void Config_GetInfo()
        {
            string sn;
            uint tam_bobina, restante_bobina, uptime, cortes, papel_acumulado, nsr_atual;
            if (rep.LerInfo(out sn, out tam_bobina, out restante_bobina, out uptime, out cortes, out papel_acumulado, out nsr_atual))
            {
                Console.WriteLine("sn: " + sn);
                Console.WriteLine("tam_bobina: " + tam_bobina);
                Console.WriteLine("restante_bobina: " + restante_bobina);
                Console.WriteLine("uptime: " + uptime);
                Console.WriteLine("cortes: " + cortes);
                Console.WriteLine("papel_acumulado: " + papel_acumulado);
                Console.WriteLine("nsr_atual: " + nsr_atual);
                Console.WriteLine("Modelo: " + rep.Modelo);
            }
            else
                Assert.Fail("Não foi possivel ler as informações do REP");
        }

        [TestMethod, TestCategory("RepCid")]
        public void Config_GetDateTime()
        {
            DateTime dt = rep.LerDataHora();
            Console.WriteLine(string.Format("{0:dd/MM/yyyy HH:mm:ss}", dt));
        }

        [TestMethod, TestCategory("RepCid")]
        public void Config_SetDateTime()
        {
            // Assert.IsTrue(rep.GravarDataHora(DateTime.Now.AddDays(-1).AddMinutes(-33)), "Erro ao gravar Data/Hora no REP");
            // Vale lembrar que dependendo do teste a sessão pode expirar se o horario mudar mais de 4 horas de diferença
            Assert.IsTrue(rep.GravarDataHora(DateTime.Now), "Erro ao gravar Data/Hora no REP");
        }

        [TestMethod, TestCategory("RepCid")]
        public void Config_GetHorarioVerao()
        {
            int iAno, iMes, iDia;
            int fAno, fMes, fDia;
            if (rep.LerConfigHVerao(out iAno, out iMes, out iDia, out fAno, out fMes, out fDia))
            {
                Console.WriteLine(string.Format("Inicio: {0:D2}/{1:D2}/{2:D4}", iDia, iMes, iAno));
                Console.WriteLine(string.Format("Fim: {0:D2}/{1:D2}/{2:D4}", fDia, fMes, fAno));
            }
            else
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Ler Horário de Verão");
            }
        }

        [TestMethod, TestCategory("RepCid")]
        public void Config_SetHorarioVerao()
        {
            bool gravou;
            if (rep.GravarConfigHVerao(2030, 6, 5, 2030, 7, 6, out gravou) && gravou)
                Console.WriteLine("Horário de Verão gravado");
            else
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Ler Horário  de Verão");
            }
        }

        [TestMethod, TestCategory("RepCid")]
        public void Config_ApagarAdmins()
        {
            bool lOk;
            if (!(rep.ApagarAdmins(out lOk) && lOk))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao apagar administradores");
            }
            Console.WriteLine("Administradores Excluido");
        }

        [TestMethod, TestCategory("RepCid")]
        public void Config_NetworkGet()
        {
            string ip;
            string netmask;
            string gateway;
            UInt16 porta;
            if (rep.LerConfigRede(out ip, out netmask, out gateway, out porta))
            {
                Console.WriteLine("IP: " + ip);
                Console.WriteLine("Netmask: " + netmask);
                Console.WriteLine("Gateway: " + gateway);
                Console.WriteLine("Porta: " + porta);
            }
            else
                Assert.Fail("Erro ao ler configurações de rede");
        }

        [TestMethod, TestCategory("RepCid")]
        public void Config_NetworkV2()
        {
            string fw_version;
            if(!rep.LerInfo_v2(out _, out _, out _, out _, out _, out _, out _, out _, out fw_version, out _))
            {
                Assert.Fail("Erro ao tentar ler informações do REP");
            }

            if (fw_version != "102")
            {
                Console.Write(String.Format("versão de firmware é {0}", fw_version));
                Assert.Inconclusive("Versão de firmware não implementa ConfigRedeV2");
                return;
            }

            string ip, netmask, gateway;
            int porta;
            bool? usar_dhcp;

            if(!rep.LerConfigRedeV2(out ip, out netmask, out gateway, out porta, out usar_dhcp))
            {
                Assert.Fail("Falha ao ler configurações de rede");
            }

            if(usar_dhcp == null)
            {
                Assert.Fail("");
            }

            string new_netmask = "255.255.128.000";
            if (!rep.GravarConfigRedeV2(ip, new_netmask, gateway, porta, usar_dhcp ?? false))
            {
                Assert.Fail("Falha ao gravar configurações de rede");
            }

            Thread.Sleep(1000);
            rep.Conectar(repIP, repPort, repiDXSenha);

            string netmask_after_change;
            if(!rep.LerConfigRedeV2(out _, out netmask_after_change, out _, out _, out _))
            {
                Assert.Fail("Falha ao ler configurações após alterar");
            }

            if (netmask_after_change.Split('.')[2] != new_netmask.Split('.')[2])
            {
                Console.WriteLine(String.Format("New netmask {0} and netmask now {1}", new_netmask, netmask_after_change));
                Assert.Fail("Gravar config rede V2 não conseguiu alterar as configurações");
            }

            if(!rep.GravarConfigRedeV2(ip, netmask, gateway, porta, usar_dhcp ?? false))
            {
                Assert.Fail("Falha ao retornar as configurações de rede ao modo anterior");
            }

            Thread.Sleep(1000);
            rep.Conectar(repIP, repPort, repiDXSenha);
        }

        [TestMethod, TestCategory("RepCid")]
        public void Trocar_Senha()
        {
            ConectarREP();
            string new_password = "password";
            if (!(rep.iDClass_WebSenha(new_password) == true))
                Assert.Fail("Erro ao alterar senha");

            rep.iDClassLogin = Config.repLogin;
            rep.iDClassPassword = new_password;

            var status = rep.Conectar(Config.repIP, Config.repPort);
            if(status != RepCid.ErrosRep.OK)
            {
                Assert.Fail("Senha não foi alterada");
            }

            if (!(rep.iDClass_WebSenha(Config.repSenha) == true))
                Assert.Fail("Erro ao retornar para senha padrão");

            ConectarREP();
        }


        [TestMethod, TestCategory("RepCid")]
        public void Trocar_Usuario()
        {
            ConectarREP();

            string new_user = "user";
            if (!(rep.iDClass_WebUsuario(new_user) == true))
                Assert.Fail("Erro ao alterar usuário");

            rep.iDClassLogin = new_user;
            rep.iDClassPassword = Config.repSenha;

            var status = rep.Conectar(Config.repIP, Config.repPort);
            if (status != RepCid.ErrosRep.OK)
            {
                Assert.Fail("Usuário não foi alterada");
            }

            if (!(rep.iDClass_WebUsuario(Config.repLogin) == true))
                Assert.Fail("Erro ao retornar para usuário padrão");

        }

        [TestMethod, TestCategory("RepCid")]
        public void Config_NetworkSet()
        {
            /*
            
            bool gravou;
            string ip = repIP; // "192.168.0.147";
            ushort port = (ushort)repPort;
            ushort newPort = (ushort)(repPort + 1);

            // ATENÇÃO: se este teste falhar parcialmente, todos os demais irão falhar também.
            // portanto deve ser o ultimo teste a ser executado
            if (rep.GravarConfigRede(ip, "255.255.0.0", "192.168.0.1", newPort, out gravou) && gravou)
            {
                Console.WriteLine("Nova configuração gravada");
                rep.Desconectar();
                Thread.Sleep(ip == repIP ? 5000 : 30000); // tempo para o ip mudar...
                if (rep.Conectar(ip, newPort) == RepCid.ErrosRep.OK)
                {
                    Console.WriteLine("Conectado ao novo IP");
                    if (rep.GravarConfigRede(repIP, "255.255.128.0", "192.168.0.1", port, out gravou) && gravou)
                    {
                        Thread.Sleep(ip == repIP ? 5000 : 30000); // tempo para o ip mudar...
                        Console.WriteLine("Voltou ao IP padrão");
                    }
                    else
                        Assert.Fail("Erro ao gravar configurações antiga de rede");
                }
                else
                    Assert.Fail("Erro ao conectar o REP no novo IP:" + ip);
            }
            else
                Assert.Fail("Erro ao mudar configuração de rede");
            
            */
        }
    }
}
