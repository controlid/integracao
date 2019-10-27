package br.com.controlid.util;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.stream.Collectors;

public abstract class InputStreamUtils {

	public static JsonObject inputStreamToJsonObject(InputStream inputStream) {
		String responseAsString = inputStreamToString(inputStream);

		JsonObject jsonObject = new Gson().fromJson(responseAsString, JsonObject.class);

		return jsonObject;
	}

	public static String inputStreamToString(InputStream inputStream) {
		try {
			try (BufferedReader br = new BufferedReader(new InputStreamReader(inputStream, Charset.defaultCharset()))) {
				String response = br.lines().collect(Collectors.joining(System.lineSeparator()));

				System.out.println("Response body -> " + response);

				return response;
			}
		} catch (Exception e) {
			e.printStackTrace();

			return null;
		}
	}

}
