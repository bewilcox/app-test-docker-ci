package org.example.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @RequestMapping("/")
    public String index() {
        //return "Greetings from Spring Boot (version 1.1.0)! with " + this.personRepository.count() + "persons";
        return "Greetings from Spring Boot (version 1.1.0)!";
    }
    
}
