package br.com.controlid.springboot.api;

import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
public class MonitorAPI {

    @RequestMapping("/api/notifications/dao")
    public ResponseEntity dao(@RequestBody ObjectNode objectNode) {
        System.out.println("MonitorAPI.dao");
        System.out.println("objectNode = [" + objectNode + "]");

        return ResponseEntity.ok().build();
    }

    @RequestMapping("/api/notifications/template")
    public ResponseEntity template(HttpServletRequest httpServletRequest) {
        System.out.println("MonitorAPI.template");
        System.out.println(httpServletRequest.getContentLength());

        return ResponseEntity.ok().build();
    }

    @RequestMapping("/api/notifications/card")
    public ResponseEntity card(@RequestBody ObjectNode objectNode) {
        System.out.println("MonitorAPI.card");
        System.out.println("objectNode = [" + objectNode + "]");

        return ResponseEntity.ok().build();
    }

    @RequestMapping("/api/notifications/catra_event")
    public ResponseEntity catraEvent(@RequestBody ObjectNode objectNode) {
        System.out.println("MonitorAPI.catraEvent");
        System.out.println("objectNode = [" + objectNode + "]");

        return ResponseEntity.ok().build();
    }

    @RequestMapping("/api/notifications/operation_mode")
    public ResponseEntity operationMode(@RequestBody ObjectNode objectNode) {
        System.out.println("MonitorAPI.operationMode");
        System.out.println("objectNode = [" + objectNode + "]");

        return ResponseEntity.ok().build();
    }

    @RequestMapping("/api/notifications/door")
    public ResponseEntity door(@RequestBody ObjectNode objectNode) {
        System.out.println("MonitorAPI.door");
        System.out.println("objectNode = [" + objectNode + "]");

        return ResponseEntity.ok().build();
    }

    @RequestMapping("/api/notifications/secbox")
    public ResponseEntity secbox(@RequestBody ObjectNode objectNode) {
        System.out.println("MonitorAPI.secbox");
        System.out.println("objectNode = [" + objectNode + "]");

        return ResponseEntity.ok().build();
    }

}
