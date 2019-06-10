package br.com.controlid.springboot.api;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PushAPI {

    @GetMapping("/push")
    public ResponseEntity push(Long deviceId, String uuid) {
        System.out.println("PushAPI.push");
        System.out.println("deviceId = [" + deviceId + "], uuid = [" + uuid + "]");

        //code

        return ResponseEntity.ok().build();
    }

    @PostMapping("/result")
    public ResponseEntity result(Long deviceId, String uuid, String endpoint, @RequestBody String response) {
        System.out.println("PushAPI.result");
        System.out.println("deviceId = [" + deviceId + "], uuid = [" + uuid + "], endpoint = [" + endpoint + "], response = [" + response + "]");

        //code

        return ResponseEntity.ok().build();
    }

}
