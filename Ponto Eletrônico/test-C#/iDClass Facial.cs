using Controlid;
using Controlid.iDClass;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace RepTestAPI
{
    [TestClass]
    public class iDClassFacial
    {
        RepCid rep;

        [TestInitialize]
        public void Conectar()
        {
            rep = Config.ConectarREP();
        }

        [TestMethod, TestCategory("Rep iDClass Facial")]
        public void Camera_CarregarEGravarConfiguracoes()
        {
            if (rep.IsFacial == null || rep.IsFacial == false)
            {
                Assert.Inconclusive("Rep não é facial");
                return;
            }

            int old_identification_distance, old_leds_brightness, old_leds_activation_brightness;
            string old_calibration_state;
            bool success = rep.iDClassFacial_LerConfiguracaoCamera(out old_identification_distance, out old_leds_brightness, out old_leds_activation_brightness, out old_calibration_state);
            if (!success)
            {
                Assert.Fail("Erro ao buscar configurações da câmera");
            }

            int new_identification_distance = 50;
            int new_leds_brightness = 25;
            int new_leds_activation_brightness = 2;
            if(!rep.iDClassFacial_GravarConfiguracaoCamera(new_identification_distance, new_leds_brightness, new_leds_activation_brightness))
            {
                Assert.Fail("Erro ao Gravar configurações da câmera");
            }

            Thread.Sleep(500);

            int identification_distance_after, leds_brightness_after, leds_activation_brightness_after;
            success = rep.iDClassFacial_LerConfiguracaoCamera(out identification_distance_after, out leds_brightness_after, out leds_activation_brightness_after, out _);
            if (!success)
            {
                Assert.Fail("Erro ao buscar configurações da câmera após modificações");
            }

            if(identification_distance_after != new_identification_distance || leds_brightness_after != new_leds_brightness || leds_activation_brightness_after != new_leds_activation_brightness)
            {
                Assert.Fail("Configurações não foram gravadas corretamente");
            }

            // Retorna para as configurações anteriores
            if (!rep.iDClassFacial_GravarConfiguracaoCamera(old_identification_distance, old_leds_brightness, old_leds_activation_brightness))
            {
                Assert.Fail("Erro ao Gravar configurações da câmera");
            }

        }

        [TestMethod, TestCategory("Rep iDClass Facial")]
        public void Camera_LerInfoFacial()
        {
            if (rep.IsFacial == null || rep.IsFacial == false)
            {
                Assert.Inconclusive("Rep não é facial");
                return;
            }

            string numero_serial, versao_firmware, numero_de_faces, numero_maximo_de_faces;
            if(!rep.iDClassFacial_LerInfoFacial(out numero_serial, out versao_firmware, out numero_de_faces, out numero_maximo_de_faces))
            {
                Assert.Fail("Falha ao ler informações faciais");
            }
        }

        [TestMethod, TestCategory("Rep iDClass Facial")]
        public void Camera_CadastroRemoto()
        {
            if (rep.IsFacial == null || rep.IsFacial == false)
            {
                Assert.Inconclusive("Rep não é facial");
                return;
            }

            int cpf = 455679452;
            bool gravou;
            if (!(rep.iDClass_GravarUsuario671(cpf, "Teste de cadastro remoto", 0, 0, "", "", 0, 0, new string[0], out gravou) && gravou))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Incluir usuário");
            }

            if (!rep.iDClassFacial_IniciarCadastroRemoto(cpf))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Falha ao iniciar o cadastro remoto");
            }

            Thread.Sleep(500);

            bool? esta_cadastrando, esta_cadastrando_remotamente;
            if(!rep.iDClassFacial_ObterStatusCadastroRemoto(out esta_cadastrando, out esta_cadastrando_remotamente))
            {
                Assert.Fail("Falha ao obter status do cadastro remoto");
            }

            if(esta_cadastrando != true || esta_cadastrando_remotamente != true)
            {
                Assert.Fail("O cadastro remoto não iniciou um processo de cadastro");
            }

            if (!rep.iDClassFacial_CancelarCadastroRemoto())
            {
                Assert.Fail("Falha ao cancelar o cadastro remoto");
            }

            Thread.Sleep(500);

            if(!rep.iDClassFacial_ObterStatusCadastroRemoto(out esta_cadastrando, out esta_cadastrando_remotamente))
            {
                Assert.Fail("Falha ao obter status do cadastro remoto após cancelar");
            }

            if(esta_cadastrando != false || esta_cadastrando_remotamente != false)
            {
                Assert.Fail("Cadastro remoto não foi cancelado após cancelamento");
            }

            bool removeu;
            if(!rep.RemoverUsuario671(cpf, out removeu) && removeu)
            {
                Assert.Fail("Falha ao remover o usuário criado");
            }
        }
    }
}