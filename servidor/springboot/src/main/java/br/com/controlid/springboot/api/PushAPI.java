package br.com.controlid.springboot.api;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class PushAPI {

	@GetMapping("/push")
	public ResponseEntity push(@RequestParam Map<String, String> allRequestParams) {
		System.out.println("PushAPI.push");
		System.out.println("allRequestParams = [" + allRequestParams + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@PostMapping("/result")
	public ResponseEntity result(@RequestBody String response, @RequestParam Map<String, String> allRequestParams) {
		System.out.println("PushAPI.result");
		System.out.println("response = [" + response + "], allRequestParams = [" + allRequestParams + "]");

		//code

		return ResponseEntity.ok().build();
	}

}
