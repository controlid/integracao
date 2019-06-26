package br.com.controlid;

import CIDBio.CIDBio;
import CIDBio.RetCode;
import CIDBio.IdentifyResult;

import java.util.logging.Logger;

public class Leitor {

	private static final Logger LOGGER = Logger.getLogger(Leitor.class.getName());

	private CIDBio idBio;

	public Leitor() {
		LOGGER.info("Inicializando iDBio...");

		RetCode init = CIDBio.Init();

		LOGGER.info("RetCode [" + init.name() + "]");

		idBio = new CIDBio();
	}


	public void cadastrar(Long id) {
		RetCode retCode = idBio.CaptureAndEnroll(id);
		System.out.println("Cadastrando...");
		System.out.println("RetCode [" + retCode.name() + "]");
	}

	public void desconectar() {
		LOGGER.info("Finalizando iDBio...");

		RetCode init = CIDBio.Terminate();

		LOGGER.info("RetCode [" + init.name() + "]");
	}

	public void formatar() {
		System.out.println("Formatando...");
		RetCode retCode = idBio.DeleteAllTemplates();
		System.out.println("RetCode [" + retCode.name() + "]");
	}

	public void identificar() {
		IdentifyResult identifyResult = idBio.CaptureAndIdentify();

		System.out.println("Identificando...");

		System.out.println("RetCode [" + identifyResult.getRetCode().name() + "]");
		long id = identifyResult.getId();
		int score = identifyResult.getScore();
		int quality = identifyResult.getQuality();

		System.out.println("IdentifyResult - ID: " + id + "| Score: " + score +" | Quality: " + quality);

	}
}
