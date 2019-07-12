package br.com.controlid.device;

import br.com.controlid.util.HttpConnectionUtils;
import br.com.controlid.util.HttpHeaders;
import br.com.controlid.util.InputStreamUtils;
import com.google.gson.JsonObject;

import java.net.HttpURLConnection;
import java.util.Map;

public abstract class Accesible {

	private String ip;

	private int port = 80;

	private String session;

	public Accesible(String ip) {
		this.ip = ip;
	}

	public Accesible(String ip, int port) {
		this.ip = ip;
		this.port = port;
	}

	public String loginWithDefaultCredential() {
		return login("admin", "admin");
	}

	public String login(String login, String password) {
		Map<String, String> headers = HttpHeaders.newEmptyHeaders();
		HttpHeaders.addHeader(headers, HttpHeaders.createContentTypeHeader("application/json"));

		JsonObject body = new JsonObject();
		body.addProperty("login", login);
		body.addProperty("password", password);

		HttpURLConnection httpURLConnection = HttpConnectionUtils.post(ip, port, "login.fcgi", headers, null, body.toString().getBytes());

		try {
			if (httpURLConnection.getResponseCode() != 200) {
				InputStreamUtils.inputStreamToString(httpURLConnection.getErrorStream());

				return null;
			}

			JsonObject response = InputStreamUtils.inputStreamToJsonObject(httpURLConnection.getInputStream());

			String session = response.get("session").getAsString();

			this.session = session;

			return session;
		} catch (Exception e) {
			e.printStackTrace();

			return null;
		}
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public int getPort() {
		return port;
	}

	public String getSession() {
		return session;
	}

	public void setSession(String session) {
		this.session = session;
	}
}
