package br.com.controlid.leitorbiometrico;

import CIDBio.ConfigParam;
import CIDBio.Image;
import CIDBio.ImageAndTemplate;
import CIDBio.Template;

import javax.imageio.ImageIO;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.Scanner;
import java.util.UUID;

public class App {

	public static Leitor leitor = new Leitor();

	public static boolean running = false;

	public static int iteration = 0;

	public static void main(String[] args) throws IOException {
		ImageAndTemplate imageAndTemplate = leitor.getIdbio().CaptureImageAndTemplate();

		Template template = imageAndTemplate.getTemplate();

		System.out.println("RetCode [" + template.getRetCode().name() + "]");

		System.out.println("Template base64: " + template.getTemplate());

		byte[] templateData = Base64.getDecoder().decode(template.getTemplate());

		System.out.println("Template length: " + templateData.length);

		Path path = Paths.get("template-data-" + UUID.randomUUID().toString());

		System.out.println("Writing file : \"" + path.getFileName() + "\"");

		Files.write(path, templateData);

		leitor.desconectar();

		System.exit(0);

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