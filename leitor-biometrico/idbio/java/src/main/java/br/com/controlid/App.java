package br.com.controlid;

import java.util.Scanner;

public class App {

	public static Leitor leitor = new Leitor();

	public static boolean running = true;

	public static int iteration = 0;

	public static void main(String[] args) {
		while (running) {
			if (iteration > 0) {
				System.out.println("--------------------------------------------");
			}

			iteration++;

			System.out.println("--- MENU ---");
			System.out.println("1 - Cadastrar");
			System.out.println("2 - Identificar");
			System.out.println("3 - Formatar iDBio");
			System.out.println("4 - Sair\n");

			System.out.println("Digite o numero da opcao:");

			Scanner scanner = new Scanner(System.in);
			String opcaoMenu = scanner.next();

			System.out.println();

			switch (opcaoMenu) {
				case "1":
					System.out.println("Digite o ID para cadastro:");

					String id = scanner.next();

					System.out.println("\nColoque o dedo no iDBio 3 vezes...");

					leitor.cadastrar(Long.valueOf(id));

					break;
				case "2":
					System.out.println("Coloque o dedo no iDBio...");
					leitor.identificar();
					break;
				case "3":
					leitor.formatar();
					break;
				case "4":
					System.out.println("Saindo...");
					leitor.desconectar();
					App.running = false;
					break;
				default:
					System.out.println("Opção: \"" + opcaoMenu + "\" inválida");
					leitor.desconectar();
					App.running = false;
					break;
			}
		}
	}

}