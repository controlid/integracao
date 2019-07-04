package br.com.controlid.leitorbiometrico;

import CIDBio.CIDBio;
import CIDBio.RetCode;
import CIDBio.IdentifyResult;

import java.util.logging.Logger;

public class Leitor {

	private static final Logger LOGGER = Logger.getLogger(Leitor.class.getName());

	private final CIDBio idbio;

	public Leitor() {
		LOGGER.info("Inicializando iDBio...");

		RetCode init = CIDBio.Init();

		LOGGER.info("RetCode [" + init.name() + "]");

		idbio = new CIDBio();
	}

	public void cadastrar(Long id) {
		RetCode retCode = idbio.CaptureAndEnroll(id);
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
		RetCode retCode = idbio.DeleteAllTemplates();
		System.out.println("RetCode [" + retCode.name() + "]");
	}

	public void identificar() {
		IdentifyResult identifyResult = idbio.CaptureAndIdentify();

		System.out.println("Identificando...");

		System.out.println("RetCode [" + identifyResult.getRetCode().name() + "]");
		long id = identifyResult.getId();
		int score = identifyResult.getScore();
		int quality = identifyResult.getQuality();

		System.out.println("IdentifyResult - ID: " + id + "| Score: " + score +" | Quality: " + quality);

	}

	public CIDBio getIdbio() {
		return idbio;
	}
}
