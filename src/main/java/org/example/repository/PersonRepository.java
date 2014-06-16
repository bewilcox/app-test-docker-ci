package org.example.repository;


import org.example.entity.Person;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by bewilcox on 11/06/2014.
 */
@Repository
public interface PersonRepository extends CrudRepository<Person, Long> {

}
