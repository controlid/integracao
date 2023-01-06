using System.Runtime.InteropServices;
using System.Text;

namespace ControliD
{
    public class CIDSAT
    {
        // In C a boolean is at least a 8 bit integer, we'll use char type to represent it
        private const char false_eval = (char)0;

        public static unsafe bool ConfigurarPortaSerial(string commPort)
        {
            char retCode;
            byte[] bCommPort = Encoding.ASCII.GetBytes(commPort);
            fixed (byte* cCommPort = bCommPort)
                retCode = LibSatiD.ConfigurarPortaSerial((char*)cCommPort);

            return retCode != false_eval;
        }

        public static unsafe bool Init()
        {
            return LibSatiD.SATiDlibInit() != false_eval;
        }

        public static unsafe bool Terminate()
        {
            return LibSatiD.SATiDlibDeInit() != false_eval;
        }

        public unsafe bool DispositivoConectado()
        {
            return LibSatiD.DispositivoConectado() != false_eval;
        }

        public unsafe string AtivarSAT(int numeroSessao, int subComando, string codigoDeAtivacao, string CNPJ, int cUF)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao), CNPJBytes = Encoding.ASCII.GetBytes(CNPJ);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes, cCNPJ = CNPJBytes)
                ret = LibSatiD.AtivarSAT(numeroSessao, subComando, (char*)cCodigoDeAtivacao, (char*)cCNPJ, cUF);

            return CopyAndDelete(ret);
        }

        public unsafe string AssociarAssinatura(int numeroSessao, string codigoDeAtivacao, string CNPJvalue, string assinaturaCNPJs)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao),
                CNPJBytes = Encoding.ASCII.GetBytes(CNPJvalue),
                assinaturaCNPJsBytes = Encoding.ASCII.GetBytes(assinaturaCNPJs);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes, cCNPJ = CNPJBytes, cAssinaturaCNPJs = assinaturaCNPJsBytes)
                ret = LibSatiD.AssociarAssinatura(numeroSessao, (char*)cCodigoDeAtivacao, (char*)cCNPJ, (char*)cAssinaturaCNPJs);

            return CopyAndDelete(ret);
        }

        public unsafe string EnviarDadosVenda(int numeroSessao, string codigoDeAtivacao, string dadosVenda)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao), dadosVendaBytes = Encoding.ASCII.GetBytes(dadosVenda);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes, cDadosVenda = dadosVendaBytes)
                ret = LibSatiD.EnviarDadosVenda(numeroSessao, (char*)cCodigoDeAtivacao, (char*)cDadosVenda);

            return CopyAndDelete(ret);
        }

        public unsafe string CancelarUltimaVenda(int numeroSessao, string codigoDeAtivacao, string chave, string dadosCancelamento)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao), chaveBytes = Encoding.ASCII.GetBytes(chave), dadosCancelamentoBytes = Encoding.ASCII.GetBytes(dadosCancelamento);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes, cChave = chaveBytes, cDadosCancelamento = dadosCancelamentoBytes)
                ret = LibSatiD.CancelarUltimaVenda(numeroSessao, (char*)cCodigoDeAtivacao, (char*)cChave, (char*)cDadosCancelamento);

            return CopyAndDelete(ret);
        }


        public unsafe string ConsultarSAT(int numeroSessao)
        {
            char* ret;
            ret = LibSatiD.ConsultarSAT(numeroSessao);
            return CopyAndDelete(ret);
        }

        public unsafe string TesteFimAFim(int numeroSessao, string codigoDeAtivacao, string dadosVenda)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao), dadosVendaBytes = Encoding.ASCII.GetBytes(dadosVenda);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes, cDadosVenda = dadosVendaBytes)
                ret = LibSatiD.TesteFimAFim(numeroSessao, (char*)cCodigoDeAtivacao, (char*)cDadosVenda);

            return CopyAndDelete(ret);
        }

        public unsafe string ConsultarStatusOperacional(int numeroSessao, string codigoDeAtivacao)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes)
                ret = LibSatiD.ConsultarStatusOperacional(numeroSessao, (char*)cCodigoDeAtivacao);

            return CopyAndDelete(ret);
        }

        public unsafe string ConsultarNumeroSessao(int numeroSessao, string codigoDeAtivacao, int cNumeroDeSessao)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes)
                ret = LibSatiD.ConsultarNumeroSessao(numeroSessao, (char*)cCodigoDeAtivacao, cNumeroDeSessao);

            return CopyAndDelete(ret);
        }

        public unsafe string ConfigurarInterfaceDeRede(int numeroSessao, string codigoDeAtivacao, string dadosConfiguracao)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao), dadosConfiguracaoBytes = Encoding.ASCII.GetBytes(dadosConfiguracao);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes, cDadosConfiguracao = dadosConfiguracaoBytes)
                ret = LibSatiD.ConfigurarInterfaceDeRede(numeroSessao, (char*)cCodigoDeAtivacao, (char*)cDadosConfiguracao);

            return CopyAndDelete(ret);
        }

        public unsafe string AtualizarSoftwareSAT(int numeroSessao, string codigoDeAtivacao)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes)
                ret = LibSatiD.AtualizarSoftwareSAT(numeroSessao, (char*)cCodigoDeAtivacao);

            return CopyAndDelete(ret);
        }

        public unsafe string ExtrairLogs(int numeroSessao, string codigoDeAtivacao)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes)
                ret = LibSatiD.ExtrairLogs(numeroSessao, (char*)cCodigoDeAtivacao);

            return CopyAndDelete(ret);
        }

        public unsafe string BloquearSAT(int numeroSessao, string codigoDeAtivacao)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes)
                ret = LibSatiD.BloquearSAT(numeroSessao, (char*)cCodigoDeAtivacao);

            return CopyAndDelete(ret);
        }

        public unsafe string DesbloquearSAT(int numeroSessao, string codigoDeAtivacao)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes)
                ret = LibSatiD.DesbloquearSAT(numeroSessao, (char*)cCodigoDeAtivacao);

            return CopyAndDelete(ret);
        }

        public unsafe string TrocarCodigoDeAtivacao(int numeroSessao, string codigoDeAtivacao, int opcao, string novoCodigo, string confNovoCodigo)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao), novoCodigoBytes = Encoding.ASCII.GetBytes(novoCodigo), confNovoCodigoBytes = Encoding.ASCII.GetBytes(confNovoCodigo);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes, cNovoCodigo = novoCodigoBytes, cConfNovoCodigo = confNovoCodigoBytes)
                ret = LibSatiD.TrocarCodigoDeAtivacao(numeroSessao, (char*)cCodigoDeAtivacao, opcao, (char*)cNovoCodigo, (char*)cConfNovoCodigo);

            return CopyAndDelete(ret);
        }

        public unsafe string ConsultarUltimaSessaoFiscal(int numeroSessao, string codigoDeAtivacao)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes)
                ret = LibSatiD.ConsultarUltimaSessaoFiscal(numeroSessao, (char*)cCodigoDeAtivacao);

            return CopyAndDelete(ret);
        }

        public unsafe string ComunicarCertificadoICPBRASIL(int numeroSessao, string codigoDeAtivacao, string certificado)
        {
            char* ret;
            byte[] codigoDeAtivacaoBytes = Encoding.ASCII.GetBytes(codigoDeAtivacao), certificadoBytes = Encoding.ASCII.GetBytes(certificado);

            fixed (byte* cCodigoDeAtivacao = codigoDeAtivacaoBytes, cCertificado = certificadoBytes)
                ret = LibSatiD.ComunicarCertificadoICPBRASIL(numeroSessao, (char*)cCodigoDeAtivacao, (char*)cCertificado);

            return CopyAndDelete(ret);
        }

        private static unsafe string CopyAndDelete(char* ptr)
        {
            if (ptr == null)
                return "";

            string? str = Marshal.PtrToStringUTF8(new IntPtr(ptr));
            LibSatiD.DesalocarString(ptr);
            return str ?? "";
        }

        private class LibSatiD
        {

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char SATiDlibInit();

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char SATiDlibDeInit();

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char DispositivoConectado();

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char ConfigurarPortaSerial(char* commPort);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* AtivarSAT(int numeroSessao, int subComando, char* codigoDeAtivacao, char* CNPJ, int cUF);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* AssociarAssinatura(int numeroSessao, char* codigoDeAtivacao, char* CNPJvalue, char* assinaturaCNPJs);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* EnviarDadosVenda(int numeroSessao, char* codigoDeAtivacao, char* dadosVenda);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* CancelarUltimaVenda(int numeroSessao, char* codigoDeAtivacao, char* chave, char* dadosCancelamento);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* ConsultarSAT(int numeroSessao);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* TesteFimAFim(int numeroSessao, char* codigoDeAtivacao, char* dadosVenda);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* ConsultarStatusOperacional(int numeroSessao, char* codigoDeAtivacao);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* ConsultarNumeroSessao(int numeroSessao, char* codigoDeAtivacao, int cNumeroDeSessao);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* ConfigurarInterfaceDeRede(int numeroSessao, char* codigoDeAtivacao, char* dadosConfiguracao);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* AtualizarSoftwareSAT(int numeroSessao, char* codigoDeAtivacao);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* ExtrairLogs(int numeroSessao, char* codigoDeAtivacao);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* BloquearSAT(int numeroSessao, char* codigoDeAtivacao);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* DesbloquearSAT(int numeroSessao, char* codigoDeAtivacao);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* TrocarCodigoDeAtivacao(int numeroSessao, char* codigoDeAtivacao, int opcao, char* novoCodigo, char* confNovoCodigo);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* ConsultarUltimaSessaoFiscal(int numeroSessao, char* codigoDeAtivacao);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe char* ComunicarCertificadoICPBRASIL(int numeroSessao, char* codigoDeAtivacao, char* certificado);

            [DllImport(@"libsatid.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
            public static extern unsafe void DesalocarString(char* str);
        }
    }
}
