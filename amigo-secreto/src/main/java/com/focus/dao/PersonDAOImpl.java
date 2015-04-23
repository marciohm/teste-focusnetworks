package com.focus.dao;

import com.focus.dao.PersonDAO;
import com.focus.model.Person;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author marcio
 */
@Repository
public class PersonDAOImpl implements PersonDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void addPerson(Person person) {
        getCurrentSession().save(person);
    }

    @Override
    public void updatePerson(Person person) {
        Person personToUpdate = getPerson(person.getId());
        personToUpdate.setName(person.getName());
        personToUpdate.setEmail(person.getEmail());
        getCurrentSession().update(personToUpdate);

    }

    @Override
    public Person getPerson(int id) {
        Person person = (Person) getCurrentSession().get(Person.class, id);
        return person;

    }

    @Override
    public void deletePerson(int id) {
        Person person = getPerson(id);
        if (person != null) {
            getCurrentSession().delete(person);
        }
    }

    @Override
    public List<Person> getAll() {
        return getCurrentSession().createQuery("from Person").list();
    }

     @Override
    public List<Person> getByNameEmail(String value) {
        return getCurrentSession().createQuery("from Person where (lower(name) like '%" + value.toLowerCase() + "%' or lower(email) like '%" + value.toLowerCase() + "%')").list();
    }

}
