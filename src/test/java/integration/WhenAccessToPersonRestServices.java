package integration;

import org.example.Application;
import org.example.entity.Person;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.IntegrationTest;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.boot.test.TestRestTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
@WebAppConfiguration
@IntegrationTest("server.port:0")
@DirtiesContext
public class WhenAccessToPersonRestServices {

    @Value("${local.server.port}")
    private int port;


    @Test
    public void testPersonsList() throws Exception {
        ArrayList<Person> persons = new TestRestTemplate()
                .getForObject("http://localhost:" + this.port + "/rest/persons", ArrayList.class);

        assertEquals(1, persons.size());

    }

    @Test
    public void testGetPerson() throws Exception {

        ResponseEntity<Person> entity = new TestRestTemplate().getForEntity(
                "http://localhost:" + this.port + "/rest/persons/1", Person.class);

        assertEquals(HttpStatus.OK, entity.getStatusCode());
        assertEquals("Doe", entity.getBody().getLastName());
        assertEquals("John", entity.getBody().getFirstName());
    }
}