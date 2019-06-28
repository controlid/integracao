package br.com.controlid.device;

import br.com.controlid.action.Action;
import br.com.controlid.util.HttpConnectionUtils;
import br.com.controlid.util.HttpHeaders;
import br.com.controlid.util.InputStreamUtils;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import java.net.HttpURLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public abstract class AccessControl extends Accesible implements IAccessControl {

	public AccessControl(String ip) {
		super(ip);
	}

	public AccessControl(String ip, int porta) {
		super(ip, porta);
	}

	public boolean executeActions(Action action) {
		List<Action> actions = new ArrayList<>();
		actions.add(action);

		return executeActions(actions);
	}

	public boolean executeActions(List<Action> actions) {
		Map<String, String> defaultHeader = HttpHeaders.dafaultHeader();

		Map<String, Object> params = new HashMap<>();
		params.put("session", this.getSession());

		JsonArray jsonArrayActions = new JsonArray();

		for (Action action : actions) {
			JsonObject jsonObjectAction = new JsonObject();
			jsonObjectAction.addProperty("action", action.getName());
			jsonObjectAction.addProperty("parameters", action.getValue());

			jsonArrayActions.add(jsonObjectAction);
		}

		JsonObject json = new JsonObject();
		json.add("actions", jsonArrayActions);

		HttpURLConnection httpURLConnection = HttpConnectionUtils.post(this.getIp(), this.getPort(), "execute_actions.fcgi", defaultHeader, params, json);

		try {
			if (httpURLConnection.getResponseCode() != 200) {
				InputStreamUtils.inputStreamToString(httpURLConnection.getErrorStream());

				return false;
			}

			return true;
		} catch (Exception e) {
			e.printStackTrace();

			return false;
		}

	}

}
