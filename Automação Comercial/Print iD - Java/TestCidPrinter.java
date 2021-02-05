import com.controlid.cidprinter.CidPrinter;
import com.controlid.cidprinter.StatusImpressora;
import java.nio.charset.Charset;
import java.text.Normalizer;

public class TestCidPrinter {
	public static void main(String[] args) {
		if (args.length<2)
		{
			System.out.println("Informe o IP e Porta");
			System.exit(1);
		}

		try {

			CidPrinter cidprint = new CidPrinter(args[0], Integer.parseInt(args[1]));

			System.out.println("Iniciando comunicação com a impressora "+args[0]+" porta " + args[1]);
			cidprint.Iniciar();

			System.out.println("Enviando comando de teste de impressao");
			cidprint.ImprimirFormatado("Teste Impressao\n", false, false, false, false, false);

			System.out.println("Enviando impressao em negrito");
			cidprint.ImprimirFormatado("Teste Impressao negrito\n", false, false, false, true, false);

			System.out.println("Enviando impressao em italico");
			cidprint.ImprimirFormatado("Teste Impressao italico\n", true, false, false, false, false);

			System.out.println("Enviando comando para imprimir um codigo de barras");
                	cidprint.ConfigurarCodigoDeBarras(0x32, 0x02, CidPrinter.PosicaoCaracteresBarras.SEM_CARACTERES);
                	cidprint.ImprimirCodigoDeBarras("223344", CidPrinter.TipoCodigoBarras.CODE39);

                	cidprint.ImprimirCodigoQR("Esse e um conteudo de QRCode");

			String fw = cidprint.GetFirmwareVersion();
			System.out.println("Leu a versao do firmware da impressora: " + fw);

			System.out.println("Leu o fabricante da impressora: " + cidprint.GetManufacturersName());
			System.out.println("Leu o modelo da impressora: " + cidprint.GetModelName());
			System.out.println("Leu o serial da impressora: " + cidprint.GetSerialNumber());

			System.out.println("Imprimindo o logo");
			cidprint.ImprimirLogo(32, 32);

			cidprint.ImprimirFormatado("\n\n", false, false, false, false, false);

			System.out.println("Imprimindo com alinhamento central");
			cidprint.Alinhar(CidPrinter.Alinhamento.CENTRAL);
			cidprint.ImprimirFormatado("alinhamento central", false, false, false, false, false);

			System.out.println("Enviando comando para ativar a gilhotina");
                	cidprint.AtivarGuilhotina(CidPrinter.TipoCorte.PARCIAL);

			System.out.println("Abre gaveta");
			cidprint.AbrirGaveta();

			StatusImpressora status = cidprint.LerStatus();
			System.out.println("Status impressora: " + status.Online + "," + status.Erro+ "," + status.SemPapel+ "," + status.TampaAberta);
			System.out.println("Status gaveta: " + cidprint.LerStatusGaveta().toString());
			System.out.println("Status papel: " + cidprint.LerStatusPapel().toString());


			System.out.println("Vai fazer a impressao de testes");
			cidprint.ImprimirTeste();

			System.out.println("Encerrando a comunicacao com a impressora");
			cidprint.Finalizar();

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
