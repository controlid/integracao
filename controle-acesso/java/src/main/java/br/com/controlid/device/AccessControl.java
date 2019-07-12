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
		Map<String, String> headers = HttpHeaders.newEmptyHeaders();
		HttpHeaders.addHeader(headers, HttpHeaders.createContentTypeHeader("application/json"));

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

		HttpURLConnection httpURLConnection = HttpConnectionUtils.post(this.getIp(), this.getPort(), "execute_actions.fcgi", headers, params, json.toString().getBytes());

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

	public JsonObject templateExtract(int width, int height, byte[] image) {
		Map<String, String> headers = HttpHeaders.newEmptyHeaders();
		HttpHeaders.addHeader(headers, HttpHeaders.createContentTypeHeader("application/octet-stream"));;

		Map<String, Object> params = new HashMap<>();
		params.put("session", this.getSession());
		params.put("width", width);
		params.put("height", height);

		HttpURLConnection httpURLConnection = HttpConnectionUtils.post(this.getIp(), this.getPort(), "template_extract.fcgi", headers, params, image);

		try {
			if (httpURLConnection.getResponseCode() != 200) {
				InputStreamUtils.inputStreamToString(httpURLConnection.getErrorStream());
			}

			JsonObject response = InputStreamUtils.inputStreamToJsonObject(httpURLConnection.getInputStream());

			return response;
		} catch (Exception e) {
			e.printStackTrace();

			return null;
		}
	}

	public JsonObject templateMatch(List<byte[]> templates) {
		Map<String, String> headers = HttpHeaders.newEmptyHeaders();
		HttpHeaders.addHeader(headers, HttpHeaders.createContentTypeHeader("application/octet-stream"));;

		Map<String, Object> params = new HashMap<>();
		params.put("session", this.getSession());
		params.put("temp_num", templates.size());

		for (int i = 0; i < templates.size(); i++) {
			byte[] bytes = templates.get(i);

			params.put("size" + i, bytes.length);
		}

		int length = templates.stream().mapToInt(bytes -> bytes.length).sum();

		byte[] body = new byte[length];

		for (int i = 0; i < templates.size(); i++) {
			byte[] template = templates.get(i);

			int lastTemplateIndex = i - 1;

			if (lastTemplateIndex < 0) {
				System.arraycopy(template, 0, body, 0, template.length);

				continue;
			}

			System.arraycopy(template, 0, body, templates.get(lastTemplateIndex).length, template.length);

		}

		HttpURLConnection httpURLConnection = HttpConnectionUtils.post(this.getIp(), this.getPort(), "template_match.fcgi", headers, params, body);

		try {
			if (httpURLConnection.getResponseCode() != 200) {
				InputStreamUtils.inputStreamToString(httpURLConnection.getErrorStream());
			}

			JsonObject jsonObject = InputStreamUtils.inputStreamToJsonObject(httpURLConnection.getInputStream());

			return jsonObject;
		} catch (Exception e) {
			e.printStackTrace();

			return null;
		}
	}

}
