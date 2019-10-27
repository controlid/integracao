package br.com.controlid.leitorbiometrico;

public class App {

	public static void main(String[] args) throws InterruptedException, IllegalAccessException, InstantiationException {
		Menu menu = new Menu();

		while (menu.showMenu()) {
			System.out.println("--------------------------------------------");
		}

	}

}