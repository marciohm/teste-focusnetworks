package com.focus.controller;

import com.focus.model.Person;
import com.focus.service.PersonService;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author marcio
 */
@Controller
@RequestMapping(value = "/person")
public class PersonController {

    @Autowired
    private PersonService personService;

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public ModelAndView addPersonPage() {
        ModelAndView modelAndView = new ModelAndView("personAdd");
        modelAndView.addObject("person", new Person());
        return modelAndView;
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public ModelAndView addingPerson(@ModelAttribute Person person) {

        ModelAndView modelAndView = new ModelAndView("home");
        String message = "";
        try {
            personService.addPerson(person);
            message = "Pessoa adicionada com sucesso!";
        } catch (Exception e) {
            message = "Erro ao cadastrar!<br>" + e.toString();
        }

        modelAndView.addObject("message", message);

        return modelAndView;
    }

    @RequestMapping(value = "/list")
    public ModelAndView listOfPersons() {
        ModelAndView modelAndView = new ModelAndView("personList");

        List<Person> persons = personService.getAll();
        modelAndView.addObject("persons", persons);

        return modelAndView;
    }

    /*
     @RequestMapping(value = "/list/{id}", method = RequestMethod.GET)
     public ModelAndView getPerson(@PathVariable Integer id) {
     ModelAndView modelAndView = new ModelAndView("personList");

     List<Person> persons = new ArrayList<>();
     persons.add(personService.getPerson(id));
     modelAndView.addObject("persons", persons);

     return modelAndView;
     }
     */
    @RequestMapping(value = "/list/{id}", method = RequestMethod.GET)
    public ModelAndView getPerson(@PathVariable String id) {
        ModelAndView modelAndView = new ModelAndView("personList");

        List<Person> persons = personService.getByNameEmail(id);
        modelAndView.addObject("persons", persons);

        return modelAndView;
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public ModelAndView editPersonPage(@PathVariable Integer id) {
        ModelAndView modelAndView = new ModelAndView("personEdit");
        Person person = personService.getPerson(id);
        modelAndView.addObject("person", person);
        return modelAndView;
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public ModelAndView edditingPerson(@ModelAttribute Person person, @PathVariable Integer id) {

        ModelAndView modelAndView = new ModelAndView("home");

        personService.updatePerson(person);

        String message = "Pessoa modificada com sucesso!";
        modelAndView.addObject("message", message);

        return modelAndView;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public ModelAndView deletePerson(@PathVariable Integer id) {
        ModelAndView modelAndView = new ModelAndView("home");
        personService.deletePerson(id);
        String message = "Pessoa excluida com sucesso";
        modelAndView.addObject("message", message);
        return modelAndView;
    }

}
