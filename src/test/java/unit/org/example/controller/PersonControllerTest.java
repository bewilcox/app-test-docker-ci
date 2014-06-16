package unit.org.example.controller;

import org.example.controller.PersonController;
import org.example.entity.Person;
import org.example.repository.PersonRepository;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.Matchers.*;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Created by bewilcox on 16/06/2014.
 */
@RunWith(MockitoJUnitRunner.class)
public class PersonControllerTest {

    @Mock
    private PersonRepository personRepository;

    @InjectMocks
    private PersonController personController;

    private MockMvc mockMvc;

    @Before
    public void setup() {
        // Process Mock Annotations
        MockitoAnnotations.initMocks(this);

        // Steup Pring Test in standalone mode
        this.mockMvc = MockMvcBuilders.standaloneSetup(personController).build();
    }

    @Test
    public void testAccessRoot() throws Exception {

        // Datas
        List<Person> persons = new ArrayList<Person>();
        persons.add(new Person("first1","last1"));
        persons.add(new Person("first2","last2"));


        // Mock Config
        when(this.personRepository.findAll())
                .thenReturn(persons);


        this.mockMvc.perform(get("/"))
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("persons"))
                .andExpect(model().attribute("persons",hasSize(2)))
                .andExpect(model().attribute("persons", hasItem(
                        allOf(
                                hasProperty("firstName", is("first1")),
                                hasProperty("lastName", is("last1"))
                        )
                )))
                .andExpect(model().attribute("persons", hasItem(
                        allOf(
                                hasProperty("firstName", is("first2")),
                                hasProperty("lastName", is("last2"))
                        )
                )));

    }
}
