package br.com.controlid.util;

import br.com.controlid.action.Action;

public abstract class ActionUtils {

	public static Action createSecBoxAction() {
		return new Action("sec_box", "id=65793");
	}

	public static Action createCatraAction(String direction) {
		return new Action("catra", new StringBuilder("allow=").append(direction).toString());
	}

	public static Action createCatraClockwiseAction() {
		return ActionUtils.createCatraAction("clockwise");
	}

	public static Action createCatraAnticlockwiseAction() {
		return ActionUtils.createCatraAction("anticlockwise");
	}

	public static Action createDoorAction(int doorNumber) {
		return new Action("door", new StringBuilder("door=").append(doorNumber).toString());
	}

	public static Action createDoor1Action() {
		return ActionUtils.createDoorAction(1);
	}

	public static Action createDoor2Action() {
		return ActionUtils.createDoorAction(2);
	}

	public static Action createDoor3Action() {
		return ActionUtils.createDoorAction(3);
	}

	public static Action createDoor4Action() {
		return ActionUtils.createDoorAction(4);
	}

}
