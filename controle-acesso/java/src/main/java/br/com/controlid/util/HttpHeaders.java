package br.com.controlid.util;

import java.util.AbstractMap.SimpleEntry;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

public abstract class HttpHeaders {

	public static Map<String, String> newEmptyHeaders() {
		Map<String, String> headers = new HashMap<>();
		return headers;
	}

	public static void addHeader(Map<String, String> headers, Entry<String, String> header) {
		if (headers == null || header == null) {
			return;
		}

		headers.put(header.getKey(), header.getValue());
	}

	public static Entry<String, String> createContentTypeHeader(String headerValue) {
		Entry<String, String> header = createHeader("Content-Type", headerValue);

		return header;
	}

	public static Entry<String, String> createHeader(String headerName, String headerValue) {
		SimpleEntry header = new SimpleEntry(headerName, headerValue);

		return header;
	}

}
