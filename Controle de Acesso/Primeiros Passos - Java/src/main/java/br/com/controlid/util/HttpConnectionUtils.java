package br.com.controlid.util;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

public class HttpConnectionUtils {

	public static HttpURLConnection post(String hostname, int port, String path, Map<String, String> headers, Map<String, Object> params, byte[] body) {
		return makeConnection(hostname, port, path, "POST", headers, params, body);
	}

	public static HttpURLConnection makeConnection(String hostname, int port, String path, String method, Map<String, String> headers, Map<String, Object> params, byte[] body) {
		try {
			System.out.println("\n--- NEW CONNECTION ---");

			StringBuilder stringBuilder = new StringBuilder("Http://").append(hostname).append(":").append(port).append("/").append(path);

			System.out.println("URL -> " + stringBuilder.toString());

			addParams(stringBuilder, params);

			URL url = new URL(stringBuilder.toString());

			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod(method);
			connection.setDoInput(true);
			connection.setDoOutput(true);

			addRequestHeaders(connection, headers);
			addRequestBody(connection, body);

			System.out.println("Connected -> " + connection.getURL().toString());
			System.out.println("Response code -> " + connection.getResponseCode() + " - " + connection.getResponseMessage());

			return connection;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	private static void addRequestHeaders(HttpURLConnection connection, Map<String, String> headers) {
		if (headers == null || headers.isEmpty()) {
			return;
		}

		for (Map.Entry<String, String> header : headers.entrySet()) {
			System.out.println("Header -> " + header);
			connection.setRequestProperty(header.getKey(), header.getValue());
		}

	}

	private static void addParams(StringBuilder stringBuilder, Map<String, Object> params) {
		if (params == null || params.isEmpty()) {
			return;
		}

		StringBuilder stringBuilderParams = new StringBuilder("?");

		for (Map.Entry<String, Object> param : params.entrySet()) {
			stringBuilderParams.append(param.getKey()).append("=").append(param.getValue().toString()).append("&");
		}

		System.out.println("Query param -> " + stringBuilderParams.toString());

		stringBuilder.append(stringBuilderParams.toString());

	}

	private static void addRequestBody(HttpURLConnection connection, byte[] body) {
		if (body.length == 0) {
			return;
		}

		try {
			OutputStream outputStream = connection.getOutputStream();
			outputStream.write(body);
		} catch (Exception e) {
			e.printStackTrace();
			return;
		}

	}
}
