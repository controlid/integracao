package br.com.controlid.device;

import br.com.controlid.action.Action;
import br.com.controlid.util.ActionUtils;

public class IDFlex extends AccessControl {

	public IDFlex(String ip) {
		super(ip);
	}

	public IDFlex(String ip, int porta) {
		super(ip, porta);
	}

	@Override
	public boolean grantAccess() {
		Action secBoxAction = ActionUtils.createSecBoxAction();

		return super.executeActions(secBoxAction);
	}

	@Override
	public boolean grantAccess(int doorNumber) {
		return false;
	}

	@Override
	public boolean grantAccessDoor1() {
		return false;
	}

	@Override
	public boolean grantAccessDoor2() {
		return false;
	}

	@Override
	public boolean grantAccessDoor3() {
		return false;
	}

	@Override
	public boolean grantAccessDoor4() {
		return false;
	}

	@Override
	public boolean grantAccessAllDoors() {
		return false;
	}

	@Override
	public boolean grantAccess(String direction) {
		return false;
	}

	@Override
	public boolean grantAccessClockwise() {
		return false;
	}

	@Override
	public boolean grantAccessAnticlockwise() {
		return false;
	}
}
