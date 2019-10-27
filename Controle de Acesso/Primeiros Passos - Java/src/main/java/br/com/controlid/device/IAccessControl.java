package br.com.controlid.device;

public interface IAccessControl {

	//common functions
	boolean grantAccess();

	//iDAccess and iDBox functions
	boolean grantAccess(int doorNumber);

	boolean grantAccessDoor1();

	boolean grantAccessDoor2();

	boolean grantAccessDoor3();

	boolean grantAccessDoor4();

	boolean grantAccessAllDoors();

	//iDBlock functions
	boolean grantAccess(String direction);

	boolean grantAccessClockwise();

	boolean grantAccessAnticlockwise();



}
