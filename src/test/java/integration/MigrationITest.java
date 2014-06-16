package integration;

import org.example.Application;
import org.example.repository.PersonRepository;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertEquals;

/**
 * Created by bewilcox on 11/06/2014.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
public class MigrationITest {

    @Autowired
    private JdbcTemplate template;

    @Autowired
    private PersonRepository personRepository;

    @Test
    public void testMigrationJDBC() throws Exception {
        assertEquals("Select count * should return 1",
                new Integer(1),
                this.template.queryForObject("SELECT COUNT(*) from person", Integer.class));
    }

    @Test
    public void testMigrationJpaRepository() throws Exception {
        assertEquals("Person repository should have one element",
                1,
                this.personRepository.count());
    }

}
