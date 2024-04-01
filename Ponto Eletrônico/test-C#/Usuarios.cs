using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Controlid;
using Controlid.iDClass;
using System.Data;
using System.Security.Cryptography;

namespace RepTestAPI
{
    [TestClass]
    public class Usuarios
    {
        RepCid rep;

        [TestInitialize]
        public void Conectar()
        {
            rep = Config.ConectarREP();
        }

        private static Int64 PisTemplate;
        [TestMethod, TestCategory("RepCid")]
        public void Usuario_List()
        {
            string created_nome;
            long created_matricula;
            int created_codigo;
            string created_senha;
            string created_barras;
            uint created_rfid;
            int created_privilegios;
            bool created_gravou;
            string template_iDX = "SUNSUzIxAAAJwgMBAAAAAMUAxQDvADoBAAAAg0gUtgAWAJQPrwAhAJEPlABSAIwP0wBWABwPlQBcABcP4QB0AJ0PggCUAHsP5ACWABkOtgClACkPkgDDAJMPggDMAGcOQgDrAGAPqgD6AKYPeAD+AO0OogAIAZ8PbAAQAfcOmgATAYgPnwAfAYUMNAAnAekPugAoAYwORAdDCx97yP9HBht3MHfL/vtzloDjB+uTJI+7n2f/koAihUN3O+kTVkcWJn3f8B//v5hPEOeyWS3TbKMZBdVjfdvuP2ovdmt7MQgyICYi7fqqZp5TPRi5+CkeYQ6PcJd1KAfR6NLkrP/B6gn7i/dji4P/gQuOBpru19wMIDgBAk8eKgMAswYXwQYAbw2DwVwDAIgVDP4DAM4iGsAJAB4i8P/+U/3/CQCMIA9YQ8EFALMkEDgFACIq+l0NAFwgAC9LVmwTABo78MA+Nv1KRlQSAA9N6cD9wTVBRP9UDACQTYzAkHfAgwwAkFOJwMGQfowJAJhTEEDAWQ0AkFuMwcLAlMLAwnEIAJhbEP7AN8EUAA1c4jU4/sD+N/9EZAkAl2AXVFX/DAB+kYanwcB7wP4MAIaWFjFTwmsNAH6XgMPEwH7AwEMHALinKcDAaxgAB6nQwCrB/cL+/f///v3AwP//wMDAwP8IAI/AnMTGxcFcGQADwtBF/UD/wfz///3+wP/+wf/B/sL/CwB+yHfGwsD//1P+GQAJys9GQP/AKv7+///+W8DARwUAhs0W/UIGAH7Pa8TBOwQAhtYaKxoAB9facP7/Pv7+/v/9/v//wMD+wf/BRAsAftdiw/////3D/08IAH/fWk9TGQAS4NxzwP87/v78/v/+/sBYfv8IAIriJHHAXQkAguNT///+/8A9BACI4zTEwRsABevWwMDAwEY1/S79wP7+wGt0BQA97WDASwUAQ+9c/0oDAIP9CfwFAK39HsJZFxARA+DAwMHAZP7//P76/i/AwMJkCRBuC+f6+1rAwAQQpgsXZBcQEAziZX7A//79/Pv8/8DAwMDCdgQQcBDwGwYQaBJpwT4VENsUk0A/lsfGwcH/U0IGEJsfiZbABBBbJ23/wQgQYB/tLEcHEJMkg5DBwgMQliUA/QgQYTT0Pf5SBBB5NP09ABAAgyAT2AApABYPlgAsAIgPmQA4ABUPhABtAHcPvgB+ACgPigCXABkOmwCeAJYOmgClAJQOiQCuAGcOiwDPAD0ORwDVAFsPsADgAKYPggDnAAYPpwDxAJsPVQD3ANwPcwD3AO0PoQD4AIcPpwAGAYQPxQAPAYsP4wPrk7vzMHf7d0cTII+/omMDRmM74ttmu5S7lccTeYWFham2MAZ9fU0ysAJZLYl9BdXdUv3SkTsC2FaaVoFDcjNXLQ0xIyYm2RpJy5KBRBa59SUZpvBWgZvYceoWEJdo2O4pBNHjrfy96Qr4ggiW844Hd5UEIDUBAjMeeAUAuQAMQAcAigMPV0oGAGcHfYHCBgCrBQz+WAsAewgJ/8D//0xKDQCSKJDDfHdpwgwAki6GbMHBaXUJAJouDDVKwBMADTTkOP/AMv7//ldTCACdNhNM/8DADgCVN4nAwpB+wXgJAJw8F8BE/8H+FAAMQuD/Nv/+QcD9aETCDQB/boCed8DAQBMAu3qgwMGJxcDCwm97cwYAwoAiQsAHAL2CKcDAXBgA7I+ne2rCbpLCwMHAwv/EXgcAhZaAx8HCXA8AnJmew8WnwVvA/1UYAOmWosDAZITAw8PAwsT/wMGAcwkAn6InWMGEGQDsqal7c3zCwpJ3wItbDACFqnfGw0TAwEMKAI2vFv0+xHQLAIaxbcXBRFfACQCGwlrC/v9EwQkAiMlQL/5TGgAYzNpwQcD///v//P/+//3BwP/AwcFbHAAL19drU/84/Sr+Mf7Bwf/AwVYFAEPXXFQFAEjZVv5TCwCt3afAwcTKxcE2GgAS5+LBc23///39wfn9//7A/8DAwcJlBQCG6An+TgMAtv0WwRkA6e2X/sD/PsJuxcTDw8DD/1v/WQQAnfePqxYA6PqTQT6Ww8fEw///wF7BBgBr/mTBNgYQpAaJwsKUCBDfBJZTwP7+CQCOyiuHg/8JEMELkHGbwgcQwRGJwcCCBhBtFnDCVQQQXRVrXAgQ0x2PwmqMBRBzHHBzDBDYJon/hHVdBhCzK4OA/woQzyyG/sHDwMJpBRDJM4PCUQAAIACDLBS5AB4AkQ83ACIA9w+zACoAjg/YAFkAFA+PAJ4AeA8lAKYAVg/CAKoAJg+nAMIAkg6jAM0AkQ6TANkAYw6QAOUAHQ4mAPgA2g9WAPoAXQ+9AAEBpA+0ABQBnA+pABoBhA5jABsB2w99ABwB7A2wACYBgQ7PAC0BiQ9EBx9/b5+Pa4tr06PE/xt/QxsTixuHu/My6zvpE1Vrf1f7K+O+lbuU57E8A04w0m28A1UxTnRoSwXV/tAsv0KMPo+rfL8DZ4dWhaeEQ3ExCTogKiZQGy0dufno6ykE2uCp81aBp1sVE5ZrM5Gp/MnlCviCCJbtjgcXOAogMgECMx8hBABHAnd3BwBvAgP//sBGBQC2AxPBVwYAqwwMUf8MACkY7f48wEZUCgA6HvAzR0EEAL0gD0YKADsl/W39wP9MBQC3LAzAPxAALDbtMsEowT5aEgAYTuvAPjg3/kyEDwCcYIyIwMPAasHBwcAHAKBiE1RZFAAJZuJAVEE+RP9aEwARaedEOMD+//5U/1gUAA564EDAN/3/wPxdQv8VAO6LmmLAe4jCwMLB/8F4DACLmoOjeFf/FQDpnJzAZ8B6jMLB/8FwwQsAk58T/v7/VcNxDQCLoXrDw8CDQVkEACKpWnYGAMSsJ2v/FgDur6LBwMDBwMHBgsHBxFHCTRcA6bSewMBii8PCwcPBwMHAwsHAew8ApcCaw8XEw8DD/0ZGFwDlu6DAZISNkMHBaWQYAOvPosBiwMHCwMObwcF8a8D+CgCN2WfF/8D/wS8JAJbmHv//xP/CcxkA6+qg/1VuiMTBw8HCdMFKwAQAkPEtlxcAJvPXWUE8If7//cDBWsIRAFn22sI7/Pz7/j/BwnwHAI73UzVUBgBS+1z/wEMQALz9p8CIycVtVDsGAFf+V/7/RgsQuQKiwP/FysXA/8D+BBDBBRp2FxDrBpb//zZyxMWfeP8+/gcQmQwQ/sLBZRUQ7RWTwMD8RcPBw8fEwsD/wf/+PQMQpBiJxQQQeSBkTxEQ4SSQwDj+wMXPwP7////B/wYQrCaDwsHD/QgQzSiJWZsHEMsuhniPBhCRNfr/QkRCAQEAAAAWAAAAAAIFAAAAAAAARUIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==";
            string template_iDClass = RepCid.TemplateToiDClass(Convert.FromBase64String(template_iDX));
            string[] created_template = new string[] { template_iDClass };

            long created_pis = Config.pisTEST + 413;
            if (!(rep.iDClass_GravarUsuario(created_pis, created_nome = "Auto-Test: Incluido", created_matricula = 4421, created_codigo = 456789, created_senha = "423456", created_barras = "456789", created_rfid = 457845, created_privilegios = 1, created_template, out created_gravou) && created_gravou))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Incluir");
            }

            int qtd;
            if (!rep.CarregarUsuarios(true, out qtd))
                Assert.Fail("Erro ao carregar usuários");

            Console.WriteLine("Usuários: " + qtd);

            Int64 pis;
            string nome;
            int codigo;
            string senha;
            string barras;
            uint rfid;
            int privilegios;
            int ndig;
            int nCount = 0;
            int nDelete = 0;
            PisTemplate = 0;
            while (rep.LerUsuario(out pis, out nome, out codigo, out senha, out barras, out rfid, out privilegios, out ndig))
            {
                nCount++;
                Console.WriteLine(string.Format("{0:D4}: {1} {2:D12}-{3} \t {4} \t {5}{6}{7}",
                    nCount, privilegios == 1 ? "A" : "U", pis, nome,
                    codigo == 0 && senha == "" ? "" : (codigo + "/" + senha),
                    barras == "" ? "" : (" CB:" + barras),
                    rfid == 0 ? "" : (" RF:" + rfid),
                    ndig == 0 ? "" : (" BIO:" + ndig)));

                if(pis == created_pis)
                {
                    if(nome != created_nome || codigo != created_codigo || senha != created_senha || barras != created_barras || rfid != created_rfid || privilegios != created_privilegios || ndig != 1)
                    {
                        Console.WriteLine(string.Format("{0:D4}: {1} {2:D12}-{3} \t {4} \t {5}{6}{7}",
                            nCount, created_privilegios == 1 ? "A" : "U", pis, nome,
                            created_codigo == 0 && created_senha == "" ? "" : (created_codigo + "/" + created_senha),
                            barras == "" ? "" : (" CB:" + created_barras),
                            created_rfid == 0 ? "" : (" RF:" + created_rfid),
                            1 == 0 ? "" : (" BIO:" + 1)));
                        Assert.Fail("Leitura do usuário criado feita incorretamente");
                    }
                } else if (PisTemplate == 0 && ndig > 0)
                {
                    PisTemplate = pis;
                }

                //bool r;
                //if(rep.RemoverUsuario(pis, out r) && r)
                //    nDelete++;
            }

            bool removeu;
            if(!rep.RemoverUsuario(created_pis, out removeu) && removeu)
            {
                Assert.Fail("Falha ao deletar o usuário criado");
            }

            if(nDelete>0)
                Console.WriteLine("\r\nUsuários Removidos: " + nDelete);

            if (PisTemplate > 0)
                Console.WriteLine("\r\nPisTemplate para teste: " + PisTemplate);
        }

        [TestMethod, TestCategory("RepCid")]
        public void Usuario_List_671()
        {
            string created_nome;
            long created_matricula;
            int created_codigo;
            string created_senha;
            string created_barras;
            uint created_rfid;
            int created_privilegios;
            bool created_gravou;
            string template_iDX = "SUNSUzIxAAAJwgMBAAAAAMUAxQDvADoBAAAAg0gUtgAWAJQPrwAhAJEPlABSAIwP0wBWABwPlQBcABcP4QB0AJ0PggCUAHsP5ACWABkOtgClACkPkgDDAJMPggDMAGcOQgDrAGAPqgD6AKYPeAD+AO0OogAIAZ8PbAAQAfcOmgATAYgPnwAfAYUMNAAnAekPugAoAYwORAdDCx97yP9HBht3MHfL/vtzloDjB+uTJI+7n2f/koAihUN3O+kTVkcWJn3f8B//v5hPEOeyWS3TbKMZBdVjfdvuP2ovdmt7MQgyICYi7fqqZp5TPRi5+CkeYQ6PcJd1KAfR6NLkrP/B6gn7i/dji4P/gQuOBpru19wMIDgBAk8eKgMAswYXwQYAbw2DwVwDAIgVDP4DAM4iGsAJAB4i8P/+U/3/CQCMIA9YQ8EFALMkEDgFACIq+l0NAFwgAC9LVmwTABo78MA+Nv1KRlQSAA9N6cD9wTVBRP9UDACQTYzAkHfAgwwAkFOJwMGQfowJAJhTEEDAWQ0AkFuMwcLAlMLAwnEIAJhbEP7AN8EUAA1c4jU4/sD+N/9EZAkAl2AXVFX/DAB+kYanwcB7wP4MAIaWFjFTwmsNAH6XgMPEwH7AwEMHALinKcDAaxgAB6nQwCrB/cL+/f///v3AwP//wMDAwP8IAI/AnMTGxcFcGQADwtBF/UD/wfz///3+wP/+wf/B/sL/CwB+yHfGwsD//1P+GQAJys9GQP/AKv7+///+W8DARwUAhs0W/UIGAH7Pa8TBOwQAhtYaKxoAB9facP7/Pv7+/v/9/v//wMD+wf/BRAsAftdiw/////3D/08IAH/fWk9TGQAS4NxzwP87/v78/v/+/sBYfv8IAIriJHHAXQkAguNT///+/8A9BACI4zTEwRsABevWwMDAwEY1/S79wP7+wGt0BQA97WDASwUAQ+9c/0oDAIP9CfwFAK39HsJZFxARA+DAwMHAZP7//P76/i/AwMJkCRBuC+f6+1rAwAQQpgsXZBcQEAziZX7A//79/Pv8/8DAwMDCdgQQcBDwGwYQaBJpwT4VENsUk0A/lsfGwcH/U0IGEJsfiZbABBBbJ23/wQgQYB/tLEcHEJMkg5DBwgMQliUA/QgQYTT0Pf5SBBB5NP09ABAAgyAT2AApABYPlgAsAIgPmQA4ABUPhABtAHcPvgB+ACgPigCXABkOmwCeAJYOmgClAJQOiQCuAGcOiwDPAD0ORwDVAFsPsADgAKYPggDnAAYPpwDxAJsPVQD3ANwPcwD3AO0PoQD4AIcPpwAGAYQPxQAPAYsP4wPrk7vzMHf7d0cTII+/omMDRmM74ttmu5S7lccTeYWFham2MAZ9fU0ysAJZLYl9BdXdUv3SkTsC2FaaVoFDcjNXLQ0xIyYm2RpJy5KBRBa59SUZpvBWgZvYceoWEJdo2O4pBNHjrfy96Qr4ggiW844Hd5UEIDUBAjMeeAUAuQAMQAcAigMPV0oGAGcHfYHCBgCrBQz+WAsAewgJ/8D//0xKDQCSKJDDfHdpwgwAki6GbMHBaXUJAJouDDVKwBMADTTkOP/AMv7//ldTCACdNhNM/8DADgCVN4nAwpB+wXgJAJw8F8BE/8H+FAAMQuD/Nv/+QcD9aETCDQB/boCed8DAQBMAu3qgwMGJxcDCwm97cwYAwoAiQsAHAL2CKcDAXBgA7I+ne2rCbpLCwMHAwv/EXgcAhZaAx8HCXA8AnJmew8WnwVvA/1UYAOmWosDAZITAw8PAwsT/wMGAcwkAn6InWMGEGQDsqal7c3zCwpJ3wItbDACFqnfGw0TAwEMKAI2vFv0+xHQLAIaxbcXBRFfACQCGwlrC/v9EwQkAiMlQL/5TGgAYzNpwQcD///v//P/+//3BwP/AwcFbHAAL19drU/84/Sr+Mf7Bwf/AwVYFAEPXXFQFAEjZVv5TCwCt3afAwcTKxcE2GgAS5+LBc23///39wfn9//7A/8DAwcJlBQCG6An+TgMAtv0WwRkA6e2X/sD/PsJuxcTDw8DD/1v/WQQAnfePqxYA6PqTQT6Ww8fEw///wF7BBgBr/mTBNgYQpAaJwsKUCBDfBJZTwP7+CQCOyiuHg/8JEMELkHGbwgcQwRGJwcCCBhBtFnDCVQQQXRVrXAgQ0x2PwmqMBRBzHHBzDBDYJon/hHVdBhCzK4OA/woQzyyG/sHDwMJpBRDJM4PCUQAAIACDLBS5AB4AkQ83ACIA9w+zACoAjg/YAFkAFA+PAJ4AeA8lAKYAVg/CAKoAJg+nAMIAkg6jAM0AkQ6TANkAYw6QAOUAHQ4mAPgA2g9WAPoAXQ+9AAEBpA+0ABQBnA+pABoBhA5jABsB2w99ABwB7A2wACYBgQ7PAC0BiQ9EBx9/b5+Pa4tr06PE/xt/QxsTixuHu/My6zvpE1Vrf1f7K+O+lbuU57E8A04w0m28A1UxTnRoSwXV/tAsv0KMPo+rfL8DZ4dWhaeEQ3ExCTogKiZQGy0dufno6ykE2uCp81aBp1sVE5ZrM5Gp/MnlCviCCJbtjgcXOAogMgECMx8hBABHAnd3BwBvAgP//sBGBQC2AxPBVwYAqwwMUf8MACkY7f48wEZUCgA6HvAzR0EEAL0gD0YKADsl/W39wP9MBQC3LAzAPxAALDbtMsEowT5aEgAYTuvAPjg3/kyEDwCcYIyIwMPAasHBwcAHAKBiE1RZFAAJZuJAVEE+RP9aEwARaedEOMD+//5U/1gUAA564EDAN/3/wPxdQv8VAO6LmmLAe4jCwMLB/8F4DACLmoOjeFf/FQDpnJzAZ8B6jMLB/8FwwQsAk58T/v7/VcNxDQCLoXrDw8CDQVkEACKpWnYGAMSsJ2v/FgDur6LBwMDBwMHBgsHBxFHCTRcA6bSewMBii8PCwcPBwMHAwsHAew8ApcCaw8XEw8DD/0ZGFwDlu6DAZISNkMHBaWQYAOvPosBiwMHCwMObwcF8a8D+CgCN2WfF/8D/wS8JAJbmHv//xP/CcxkA6+qg/1VuiMTBw8HCdMFKwAQAkPEtlxcAJvPXWUE8If7//cDBWsIRAFn22sI7/Pz7/j/BwnwHAI73UzVUBgBS+1z/wEMQALz9p8CIycVtVDsGAFf+V/7/RgsQuQKiwP/FysXA/8D+BBDBBRp2FxDrBpb//zZyxMWfeP8+/gcQmQwQ/sLBZRUQ7RWTwMD8RcPBw8fEwsD/wf/+PQMQpBiJxQQQeSBkTxEQ4SSQwDj+wMXPwP7////B/wYQrCaDwsHD/QgQzSiJWZsHEMsuhniPBhCRNfr/QkRCAQEAAAAWAAAAAAIFAAAAAAAARUIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==";
            string template_iDClass = RepCid.TemplateToiDClass(Convert.FromBase64String(template_iDX));
            string[] created_template = new string[] { template_iDClass };

            long created_cpf = Config.pisTEST + 413;
            if (!(rep.iDClass_GravarUsuario671(created_cpf, created_nome = "Auto-Test: Incluido", created_matricula = 4421, created_codigo = 456789, created_senha = "423456", created_barras = "456789", created_rfid = 457845, created_privilegios = 1, created_template, out created_gravou) && created_gravou))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Incluir");
            }

            int qtd;
            if (!rep.CarregarUsuarios671(true, out qtd))
                Assert.Fail("Erro ao carregar usuários");

            Console.WriteLine("Usuários: " + qtd);

            Int64 cpf;
            string nome;
            int codigo;
            string senha;
            string barras;
            uint rfid;
            int privilegios;
            int ndig;
            int nCount = 0;
            int nDelete = 0;
            PisTemplate = 0;
            while (rep.LerUsuario671(out cpf, out nome, out codigo, out senha, out barras, out rfid, out privilegios, out ndig))
            {
                nCount++;
                Console.WriteLine(string.Format("{0:D4}: {1} {2:D12}-{3} \t {4} \t {5}{6}{7}",
                    nCount, privilegios == 1 ? "A" : "U", cpf, nome,
                    codigo == 0 && senha == "" ? "" : (codigo + "/" + senha),
                    barras == "" ? "" : (" CB:" + barras),
                    rfid == 0 ? "" : (" RF:" + rfid),
                    ndig == 0 ? "" : (" BIO:" + ndig)));
                if (cpf == created_cpf)
                {
                    if (nome != created_nome || codigo != created_codigo || senha != created_senha || barras != created_barras || rfid != created_rfid || privilegios != created_privilegios || ndig != 1)
                    {
                        Console.WriteLine(string.Format("{0:D4}: {1} {2:D12}-{3} \t {4} \t {5}{6}{7}",
                            nCount, created_privilegios == 1 ? "A" : "U", cpf, nome,
                            created_codigo == 0 && created_senha == "" ? "" : (created_codigo + "/" + created_senha),
                            barras == "" ? "" : (" CB:" + created_barras),
                            created_rfid == 0 ? "" : (" RF:" + created_rfid),
                            1 == 0 ? "" : (" BIO:" + 1)));
                        Assert.Fail("Leitura do usuário criado feita incorretamente");
                    }
                }

                //bool r;
                //if(rep.RemoverUsuario(pis, out r) && r)
                //    nDelete++;
            }

            bool removeu;
            if (!rep.RemoverUsuario(created_cpf, out removeu) && removeu)
            {
                Assert.Fail("Falha ao deletar o usuário criado");
            }

            if (nDelete > 0)
                Console.WriteLine("\r\nUsuários Removidos: " + nDelete);

            if (PisTemplate > 0)
                Console.WriteLine("\r\nPisTemplate para teste: " + PisTemplate);
        }

        [TestMethod, TestCategory("RepCid")]
        public void Usuario_Counts()
        {
            int countUsr;
            if (rep.CarregarUsuarios(true, out countUsr))
            {
                int countDig = 0;
                int countAdm = 0;
                int countSenha = 0;
                int countRfid = 0;
                int countBarras = 0;
                foreach (DataRow row in rep.Usuarios.Rows)
                {
                    countDig += Convert.ToInt32(row["NUM_DIG"]);

                    if (row["PRIV"].ToString().Equals("1"))
                        countAdm++;

                    if (!row["CODIGO"].ToString().Equals("0"))
                        countSenha++;

                    if (!row["RFID"].ToString().Equals("0"))
                        countRfid++;

                    if (!string.IsNullOrWhiteSpace(row["BARRAS"].ToString()))
                        countBarras++;

                }
                Console.WriteLine(string.Format("{0} Usuários, {1} Admin, {2} Senhas, {3} RfId, {4} Barras, {5} Digitais", countUsr, countAdm, countSenha, countRfid, countBarras, countDig));
            }
        }

        [TestMethod, TestCategory("RepCid")]
        public void Usuario_GetTemplate()
        {
            if (PisTemplate == 0)
                PisTemplate = Config.pisTEST;

            int num_tmpls;
            if (rep.CarregarTemplatesUsuario(PisTemplate, out num_tmpls))
            {
                Console.WriteLine(PisTemplate +": " + num_tmpls + " templates localizados.");
                byte[] tmpl_bin;
                while (rep.LerTemplate(out tmpl_bin))
                {
                    string v=""; // para imprimir os 20 primeiros bytes do template
                    for (int i = 0; i < 20 && i < tmpl_bin.Length; i++)
                        v += string.Format("{0:X2} ", tmpl_bin[i]);

                    Console.WriteLine("\t" + v + Convert.ToBase64String(tmpl_bin));
                }
                    
            }
            else
                Assert.Inconclusive("Não há PIS registrado para obter um template");
        }

        string cNome = " X ";

        [TestMethod, TestCategory("RepCid")]
        public void Usuario_CRUD_Loop()
        {
            for (int i = 0; i < 10; i++)
            {
                cNome = " " + i;
                Usuario_CRUD();
            }
        }

        [TestMethod, TestCategory("RepCid")]
        public void Usuario_CRUD()
        {
            bool gravou;

            Int64 pis = Config.pisTEST;

            string nome1, nome2;
            int codigo1, codigo2;
            string senha1, senha2;
            string barras1, barras2;
            uint rfid1, rfid2;
            int privilegios1, privilegios2;

            // Inclusão
            if (!(rep.GravarUsuario(pis, nome1 = "Auto-Test: Incluido" + cNome, codigo1 = 112233, senha1 = "222111", barras1 = "134567", rfid1 = 6543219, privilegios1 = 1, out gravou) && gravou))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Incluir");
            }
            Console.WriteLine("Usuário Adicionado: " + nome1);

            // Valida inclusão
            if (!rep.LerDadosUsuario(pis, out nome2, out codigo2, out senha2, out barras2, out rfid2, out privilegios2))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Ler usuário incluido");
            }
            if (nome1 != nome2)
                Assert.Fail("Dados lidos não conferem na alteração: Nome");
            else if (codigo1 != codigo2)
                Assert.Fail("Dados lidos não conferem na alteração: Código");
            else if (senha1 != senha2)
                Assert.Fail("Dados lidos não conferem na alteração: Senha");
            else if (barras1 != barras2)
                Assert.Fail("Dados lidos não conferem na alteração: Barras");
            else if (rfid1 != rfid2)
                Assert.Fail("Dados lidos não conferem na alteração: RFID");
            else if (privilegios1 != privilegios2)
                Assert.Fail("Dados lidos não conferem na alteração: Privilegios");

            // Alteração
            if (!(rep.GravarUsuario(pis, nome1 = "Auto-Test: Alterado", codigo1 = 221133, senha1 = "112233", barras1 = "1232349", rfid1 = 9234234, privilegios1 = 0, out gravou) && gravou))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Alterar");
            }
            Console.WriteLine("Usuário Alterado");

            // Valida alteração
            if (!rep.LerDadosUsuario(pis, out nome2, out codigo2, out senha2, out barras2, out rfid2, out privilegios2))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Ler usuário alterado");
            }

            if (nome1 != nome2)
                Assert.Fail("Dados lidos não conferem na alteração: Nome");
            else if (codigo1 != codigo2)
                Assert.Fail("Dados lidos não conferem na alteração: Código");
            else if (senha1 != senha2)
                Assert.Fail("Dados lidos não conferem na alteração: Senha");
            else if (barras1 != barras2)
                Assert.Fail("Dados lidos não conferem na alteração: Barras");
            else if (rfid1 != rfid2)
                Assert.Fail("Dados lidos não conferem na alteração: RFID");
            else if (privilegios1 != privilegios2)
                Assert.Fail("Dados lidos não conferem na alteração: Privilegios");

            // Exclusão
            if (!(rep.RemoverUsuario(pis, out gravou) && gravou))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Excluir");
            }
            Console.WriteLine("Usuário Excluido");
        }

        [TestMethod, TestCategory("RepCid")]
        public void Usuario_CRUD_iDClass()
        {
            bool gravou;

            Int64 pis = Config.pisTEST + 15;

            string nome1, nome2;
            long matricula1, matricula2;
            int codigo1, codigo2;
            string senha1, senha2;
            string barras1, barras2;
            uint rfid1, rfid2;
            int privilegios1, privilegios2;
            string[] template = null;
            // Inclusão
            if (!(rep.iDClass_GravarUsuario(pis, nome1 = "Auto-Test: Incluido" + cNome, matricula1 = 5566, codigo1 = 112233, senha1 = "222111", barras1 = "134567", rfid1 = 6543219, privilegios1 = 1, template, out gravou) && gravou))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Incluir");
            }
            Console.WriteLine("Usuário Adicionado: " + nome1);

            // Valida inclusão
            if (!rep.iDClass_LerDadosUsuario(pis, out nome2, out matricula2, out codigo2, out senha2, out barras2, out rfid2, out privilegios2, out template))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Ler usuário incluido");
            }
            if (nome1 != nome2)
                Assert.Fail("Dados lidos não conferem na alteração: Nome");
            else if (matricula1 != matricula2)
                Assert.Fail("Dados lidos não conferem na alteração: Matricula");
            else if (codigo1 != codigo2)
                Assert.Fail("Dados lidos não conferem na alteração: Código");
            else if (senha1 != senha2)
                Assert.Fail("Dados lidos não conferem na alteração: Senha");
            else if (barras1 != barras2)
                Assert.Fail("Dados lidos não conferem na alteração: Barras");
            else if (rfid1 != rfid2)
                Assert.Fail("Dados lidos não conferem na alteração: RFID");
            else if (privilegios1 != privilegios2)
                Assert.Fail("Dados lidos não conferem na alteração: Privilegios");

            // Alteração
            if (!(rep.iDClass_GravarUsuario(pis, nome1 = "Auto-Test: Alterado", matricula1=22478, codigo1 = 221133, senha1 = "112233", barras1 = "1232349", rfid1 = 9234234, privilegios1 = 0, template, out gravou) && gravou))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Alterar");
            }
            Console.WriteLine("Usuário Alterado");

            // Valida alteração
            if (!rep.iDClass_LerDadosUsuario(pis, out nome2, out matricula2, out codigo2, out senha2, out barras2, out rfid2, out privilegios2, out template))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Ler usuário alterado");
            }

            if (nome1 != nome2)
                Assert.Fail("Dados lidos não conferem na alteração: Nome");
            else if (matricula1 != matricula2)
                Assert.Fail("Dados lidos não conferem na alteração: Matricula");
            else if (codigo1 != codigo2)
                Assert.Fail("Dados lidos não conferem na alteração: Código");
            else if (senha1 != senha2)
                Assert.Fail("Dados lidos não conferem na alteração: Senha");
            else if (barras1 != barras2)
                Assert.Fail("Dados lidos não conferem na alteração: Barras");
            else if (rfid1 != rfid2)
                Assert.Fail("Dados lidos não conferem na alteração: RFID");
            else if (privilegios1 != privilegios2)
                Assert.Fail("Dados lidos não conferem na alteração: Privilegios");

            // Exclusão
            if (!(rep.RemoverUsuario(pis, out gravou) && gravou))
            {
                Console.WriteLine(rep.LastLog());
                Assert.Fail("Erro ao Excluir");
            }
            Console.WriteLine("Usuário Excluido");
        }

        [TestMethod, TestCategory("RepCid")]
        public void Templete_Test()
        {
            string template_iDClass = "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";
            string template_iDX = "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AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==";

            bool a, b;
            Console.WriteLine("template iDClass: ", a = RepCid.TemplateIsValid(Convert.FromBase64String(template_iDClass), 3));
            Console.WriteLine("template iDX: ", b = RepCid.TemplateIsValid(Convert.FromBase64String(template_iDX), 3));

            Assert.IsTrue(a & b, "Erro Templates invalidos");
        }

        [TestMethod, TestCategory("RepCid")]
        public void Usuario_ToUSB()
        {
            int qtd;
            if (!rep.CarregarUsuarios(true, out qtd))
                Assert.Fail("Erro ao carregar usuários");

            Console.WriteLine("Usuários:" + qtd);
            Int64 pis;
            string nome;
            int codigo;
            string senha;
            string barras;
            uint rfid;
            int privilegios;
            int ndig;
            int nCount = 0;
            int nBio;
            byte[] template;
            RepCidUsb usb = new RepCidUsb();
            usb.IniciaGravacao();
            while (rep.LerUsuario(out pis, out nome, out codigo, out senha, out barras, out rfid, out privilegios, out ndig))
            {
                nCount++;
                //Console.WriteLine(string.Format("{0:D4}: {1} {2:D12}-{3} \t {4} \t {5}{6}{7}",
                //    nCount, privilegios == 1 ? "A" : "U", pis, nome,
                //    codigo == 0 && senha == "" ? "" : (codigo + "/" + senha),
                //    barras == "" ? "" : (" CB:" + barras),
                //    rfid == 0 ? "" : (" RF:" + rfid),
                //    ndig == 0 ? "" : (" BIO:" + ndig)));

                //Console.WriteLine(
                //    PadValue(pis, 12) +
                //    PadValue(nome, 52) +
                //    PadValue(codigo, 6) +
                //    PadValue(senha, 6) +
                //    PadValue(rfid, 8) +
                //    PadValue(barras, 16) +
                //    PadValue(privilegios, 1));

                if (!usb.AdicionarUsuario(pis, nome, (uint)codigo, senha, barras, (uint)rfid, privilegios))
                    Console.WriteLine("Erro em adicionar: " + usb.GetLastError());

                if (ndig>0)
                {
                    if (!rep.CarregarTemplatesUsuario(pis, out nBio) || nBio != ndig)
                        Assert.Fail("Erro ao carregar usuários: " + ndig + "<>" + nBio);

                    while (rep.LerTemplate(out template) && nBio-->0)
                        usb.AdicionarTemplate(pis, template);

                    Assert.IsTrue(nBio == 0, "Erro ao ler todas as digitais");
                }
            }

            if (!usb.FinalizarGravacao(@"C:\usuarios.dat", @"C:\digitais.dat"))
                Console.WriteLine("Erro em finalizar: " + usb.GetLastError());
        }

        public string PadValue(object value, int nSize)
        {
            string cValue;
            if (value is string)
            {
                cValue = value as string;
                if (cValue.Length > nSize)
                    cValue = cValue.Substring(0, nSize);
                else if (cValue.Length < nSize)
                    cValue = cValue + new string(' ', nSize - cValue.Length);
            }
            else
            {
                cValue = value.ToString();
                if (cValue.Length > nSize)
                    cValue = cValue.Substring(0, nSize);
                else if (cValue.Length < nSize)
                    cValue = new string('0', nSize - cValue.Length) + cValue;
            }
            return cValue;
        }
    }
}