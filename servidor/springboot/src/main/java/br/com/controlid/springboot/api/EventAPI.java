package br.com.controlid.springboot.api;

import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class EventAPI {

	@PostMapping("/new_biometric_image.fcgi")
	public ResponseEntity newBiometricImage(@RequestBody byte[] requestBody, Map<String, String> allRequestParams) {
		System.out.println("EventAPI.newBiometricImage");
		System.out.println("requestBodyLength = [" + ( requestBody != null ? requestBody.length : 0 ) + "], allRequestParams = [" + allRequestParams + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@PostMapping("/new_biometric_template.fcgi")
	public ResponseEntity newBiometricTemplate(@RequestBody byte[] requestBody, Map<String, String> allRequestParams) {
		System.out.println("EventAPI.newBiometricTemplate");
		System.out.println("requestBodyLength = [" + ( requestBody != null ? requestBody.length : 0 ) + "], allRequestParams = [" + allRequestParams + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@PostMapping("/new_card.fcgi")
	public ResponseEntity newCard(Map<String, String> allRequestParams) {
		System.out.println("EventAPI.newCard");
		System.out.println("allRequestParams = [" + allRequestParams + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@PostMapping("/new_user_id_and_password.fcgi")
	public ResponseEntity newUserIdAndPassword(Map<String, String> allRequestParams) {
		System.out.println("EventAPI.newUserIdAndPassword");
		System.out.println("allRequestParams = [" + allRequestParams + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@PostMapping("/new_user_identified.fcgi")
	public ResponseEntity newUserIdentified(Map<String, String> allRequestParams) {
		System.out.println("IdentificationAPI.newUserIdentified");
		System.out.println("allRequestParams = [" + allRequestParams + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@GetMapping("/user_get_image.fcgi")
	public ResponseEntity userGetImage(Map<String, String> allRequestParams) {
		System.out.println("EventAPI.userGetImage");
		System.out.println("allRequestParams = [" + allRequestParams + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@PostMapping("/device_is_alive.fcgi")
	public ResponseEntity deviceIsAlive(Map<String, String> allRequestParams) {
		System.out.println("EventAPI.deviceIsAlive");
		System.out.println("allRequestParams = [" + allRequestParams + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@PostMapping("/template_create.fcgi")
	public ResponseEntity templateCreate(@RequestBody byte[] requestBody, Map<String, String> allRequestParams) {
		System.out.println("EventAPI.templateCreate");
		System.out.println("requestBodyLength = [" + ( requestBody != null ? requestBody.length : 0 ) + "], allRequestParams = [" + allRequestParams + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@PostMapping("/card_create.fcgi")
	public ResponseEntity cardCreate(@RequestBody ObjectNode objectNode) {
		System.out.println("EventAPI.cardCreate");
		System.out.println("objectNode = [" + objectNode + "]");

		//code

		return ResponseEntity.ok().build();
	}

}
