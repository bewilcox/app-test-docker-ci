package org.example.controller.rest;

import org.example.entity.Person;
import org.example.repository.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * Created by bewilcox on 16/06/2014.
 */
@RestController
@RequestMapping("/rest/persons")
public class PersonRestService {

    @Autowired
    private PersonRepository personRepository;

    @RequestMapping
    public Iterable<Person> getAllPersons() {
        return this.personRepository.findAll();
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public Person getPersonById(@PathVariable("id") Long id) {
        return this.personRepository.findOne(id);
    }
}
