package br.com.controlid.leitorbiometrico;

import CIDBio.CIDBio;
import CIDBio.RetCode;
import CIDBio.IdentifyResult;

import java.util.Scanner;

public class Menu {

	private final CIDBio iDBio = new CIDBio();

	public boolean showMenu() {
		System.out.println("--- MENU ---");
		System.out.println("1 - Cadastrar");
		System.out.println("2 - Identificar");
		System.out.println("3 - Formatar iDBio");
		System.out.println("4 - Sair\n");

		System.out.print("Digite o numero da opcao: ");

		Scanner scanner = new Scanner(System.in);
		String menuOption = scanner.next();

		RetCode retCode;

		switch (menuOption) {
			case "1":
				System.out.print("Digite o ID para cadastro: ");

				String id = scanner.next();

				System.out.println("\nColoque o dedo no iDBio 3 vezes...");

				retCode = iDBio.CaptureAndEnroll(Long.valueOf(id));

				System.out.println("Cadastro - RetCode [" + retCode.name() + "]");

				return true;
			case "2":
				System.out.println("Coloque o dedo no iDBio...");

				IdentifyResult identifyResult = iDBio.CaptureAndIdentify();

				retCode = identifyResult.getRetCode();

				System.out.println("Identificação - RetCode [" + retCode.name() + "]");

				long idIdentified = identifyResult.getId();
				int score = identifyResult.getScore();
				int quality = identifyResult.getQuality();

				if (RetCode.SUCCESS.equals(retCode)) {
					System.out.println("IdentifyResult - ID: " + idIdentified + " | Score: " + score +" | Quality: " + quality);
				}

				return true;
			case "3":
				retCode = iDBio.DeleteAllTemplates();

				System.out.println("Formatação - RetCode [" + retCode.name() + "]");

				return true;
			case "4":
				System.out.println("Saindo...");

				return false;
			default:
				System.out.println("Opção '" + menuOption + "' não existe");

				return true;
		}
	}
	
}
