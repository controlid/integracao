package br.com.controlid.util;

import java.util.HashMap;
import java.util.Map;

public abstract class HttpHeaders {

	public static Map<String, String> dafaultHeader() {
		Map<String, String> defaultHeader = new HashMap<>();
		defaultHeader.put("Content-Type", "application/json");

		return defaultHeader;
	}

}
