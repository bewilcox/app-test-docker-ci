package org.example.controller;

import org.example.entity.Person;
import org.example.repository.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class HelloController {

    @Autowired
    private PersonRepository personRepository;

    @RequestMapping("/")
    public ModelAndView welcome() {
        Iterable<Person> persons = this.personRepository.findAll();
        return new ModelAndView("persons/list","persons",persons);
    }
    
}
