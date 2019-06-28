package br.com.controlid.device;

import br.com.controlid.action.Action;
import br.com.controlid.util.ActionUtils;

import java.util.ArrayList;
import java.util.List;

public class IDAccess extends AccessControl {

	public IDAccess(String ip) {
		super(ip);
	}

	public IDAccess(String ip, int porta) {
		super(ip, porta);
	}

	@Override
	public boolean grantAccess() {
		return false;
	}

	@Override
	public boolean grantAccess(int doorNumber) {
		Action doorAction = ActionUtils.createDoorAction(doorNumber);

		return super.executeActions(doorAction);
	}

	@Override
	public boolean grantAccessDoor1() {
		return this.grantAccess(1);
	}

	@Override
	public boolean grantAccessDoor2() {
		return this.grantAccess(2);
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
		List<Action> actions = new ArrayList<>();

		actions.add(ActionUtils.createDoor1Action());
		actions.add(ActionUtils.createDoor2Action());

		return super.executeActions(actions);
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
