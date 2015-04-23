package com.focus.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.focus.dao.PersonDAO;
import com.focus.model.Person;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author marcio
 */
@Service
@Transactional
public class PersonServiceImpl implements PersonService {

    @Autowired
    private PersonDAO personDAO;

    @Override
    public void addPerson(Person person) {
        personDAO.addPerson(person);
    }

    @Override
    public void updatePerson(Person person) {
        personDAO.updatePerson(person);
    }

    @Override
    public Person getPerson(int id) {
        return personDAO.getPerson(id);
    }

    @Override
    public void deletePerson(int id) {
        personDAO.deletePerson(id);
    }

    @Override
    public List<Person> getAll() {
        return personDAO.getAll();
    }
    
    @Override
    public List<Person> getByNameEmail(String value) {
        return personDAO.getByNameEmail(value);
    }


}
