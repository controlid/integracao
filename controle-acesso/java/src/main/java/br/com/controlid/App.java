package br.com.controlid;

import br.com.controlid.device.IDAccess;
import br.com.controlid.device.IDFlex;

import java.io.UnsupportedEncodingException;

public class App {

	private static final String IDACCESS_IP = "192.168.15.3";

	private static final String IDFLEX_IP = "192.168.15.1";

	public static void main( String[] args ) throws UnsupportedEncodingException {
//		IDFlex idFlex = new IDFlex("192.168.15.1");
//
//		idFlex.loginWithDefaultCredential();
//		idFlex.grantAccess();

		IDAccess idAccess = new IDAccess(IDACCESS_IP);

		idAccess.loginWithDefaultCredential();

		idAccess.grantAccessAllDoors();


	}
}
