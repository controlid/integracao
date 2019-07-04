package br.com.controlid.springboot.api;

import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
public class EventAPI {

	@PostMapping("/new_biometric_image.fcgi")
	public ResponseEntity newBiometricImage(@RequestBody byte[] image, String session, @RequestParam("device_id") String deviceId, @RequestParam("identifier_id") String identifierId, String width, String height) {
		System.out.println("EventAPI.newBiometricImage");
		System.out.println("session = [" + session + "], deviceId = [" + deviceId + "], identifierId = [" + identifierId + "], width = [" + width + "], height = [" + height + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@PostMapping("/new_biometric_template.fcgi")
	public ResponseEntity newBiometricTemplate(@RequestBody byte[] template, @RequestParam String session, @RequestParam("device_id") String deviceId, @RequestParam("identifier_id") String identifierId) {
		System.out.println("EventAPI.newBiometricTemplate");
		System.out.println("template = [" + template + "], session = [" + session + "], deviceId = [" + deviceId + "], identifierId = [" + identifierId + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@PostMapping("/new_card.fcgi")
	public ResponseEntity newCard(@RequestParam String session, @RequestParam String uuid, @RequestParam("device_id") String deviceId, @RequestParam("identifier_id") String identifierId, @RequestParam("card_value") String cardValue, @RequestParam("portal_id") Integer portalId) {
		System.out.println("EventAPI.newCard");
		System.out.println("session = [" + session + "], uuid = [" + uuid + "], deviceId = [" + deviceId + "], identifierId = [" + identifierId + "], cardValue = [" + cardValue + "], portalId = [" + portalId + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@PostMapping("/new_user_id_and_password.fcgi")
	public ResponseEntity newUserIdAndPassword(@RequestParam String session, @RequestParam("device_id") String deviceId, @RequestParam("identifier_id") String identifierId, @RequestParam("user_id") Long userId, String password) {
		System.out.println("EventAPI.newUserIdAndPassword");
		System.out.println("session = [" + session + "], deviceId = [" + deviceId + "], identifierId = [" + identifierId + "], userId = [" + userId + "], password = [" + password + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@PostMapping("/new_user_identified.fcgi")
	public ResponseEntity newUserIdentified(@RequestParam String session, @RequestParam("device_id") String deviceId, @RequestParam("identifier_id") String identifierId, @RequestParam Integer event, @RequestParam("user_id") Long userId, @RequestParam Integer duress) {
		System.out.println("IdentificationAPI.newUserIdentified");
		System.out.println("session = [" + session + "], deviceId = [" + deviceId + "], identifierId = [" + identifierId + "], event = [" + event + "], userId = [" + userId + "], duress = [" + duress + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@GetMapping("/user_get_image.fcgi")
	public ResponseEntity userGetImage(HttpServletRequest httpServletRequest, @RequestParam String session, @RequestParam("user_id") Long userId) {
		System.out.println("EventAPI.userGetImage");
		System.out.println("session = [" + session + "], userId = [" + userId + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@PostMapping("/device_is_alive.fcgi")
	public ResponseEntity deviceIsAlive(@RequestParam("device_id") Long deviceId) {
		System.out.println("EventAPI.deviceIsAlive");
		System.out.println("deviceId = [" + deviceId + "]");

		//code

		return ResponseEntity.ok().build();
	}

	@PostMapping("/template_create.fcgi")
	public ResponseEntity templateCreate(@RequestBody byte[] bodyContent, @RequestParam("size0") Integer bodySize, @RequestParam("user_id") Long userId, @RequestParam("device_id") String deviceId, @RequestParam("finger_type") Integer fingerType) {
		System.out.println("EventAPI.templateCreate");
		System.out.println("bodyContent = [" + (bodyContent.length != 0) + "], bodySize = [" + bodySize + "], userId = [" + userId + "], deviceId = [" + deviceId + "], fingerType = [" + fingerType + "]");

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
