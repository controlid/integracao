package br.com.controlid;

import br.com.controlid.device.IDAccess;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class App {

	private static final String IDACCESS_IP = "192.168.121.1";

	private static final String IDFLEX_IP = "192.168.15.1";

	public static void main( String[] args ) throws IOException {
//		IDFlex idFlex = new IDFlex("192.168.15.1");
//
//		idFlex.loginWithDefaultCredential();
//		idFlex.grantAccess();

		IDAccess idAccess = new IDAccess(IDACCESS_IP);

		idAccess.loginWithDefaultCredential();

		byte[] bytes = Files.readAllBytes(Paths.get("file"));

		List<byte[]> templates = new ArrayList<>();
		templates.add(bytes);
		templates.add(bytes);

		idAccess.templateMatch(templates);

	}
}
