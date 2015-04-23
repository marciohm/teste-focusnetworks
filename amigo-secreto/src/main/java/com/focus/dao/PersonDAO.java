package com.focus.dao;

import com.focus.model.Person;
import java.util.List;

/**
 *
 * @author marcio
 */
public interface PersonDAO {

    public void addPerson(Person person);

    public void updatePerson(Person person);

    public Person getPerson(int id);

    public void deletePerson(int id);

    public List<Person> getAll();
    
    public List<Person> getByNameEmail(String value);
}
