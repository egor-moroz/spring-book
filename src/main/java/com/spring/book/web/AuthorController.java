package com.spring.book.web;

import com.spring.book.model.Author;
import com.spring.book.service.impl.BookServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
@RequestMapping("/author")
public class AuthorController {

    @Autowired
    BookServiceImpl bookService;

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(method = RequestMethod.GET)
    public String listAuthors(Model model) {
        model.addAttribute("authorList", bookService.findAllAuthors());
        return "/list-authors";
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(method = RequestMethod.GET, value = "/{id}")
    public String showAuthor(@PathVariable("id") Long id, Model model) {
        model.addAttribute("author", bookService.findAuthorById(id));
        model.addAttribute("books", bookService.findAllBooks());
        model.addAttribute("action", "edit");
        return "/add-author";
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(method = RequestMethod.POST, value = "/{id}")
    public String editAuthor(@Valid Author author, BindingResult result, @PathVariable("id") Long id, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("author", author);
            model.addAttribute("action", "edit");
            return "/add-author";
        } else {
            bookService.saveAuthor(author);
            model.addAttribute("authorList", bookService.findAllAuthors());
            return "redirect:/author";
        }
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(method = RequestMethod.POST)
    public String addAuthor(@Valid Author author, BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("author", author);

            return "/add-author";
        } else {
            bookService.saveAuthor(author);
            model.addAttribute("authorList", bookService.findAllAuthors());
            return "redirect:/author";
        }
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(method = RequestMethod.GET, params = "addForm")
    public String addForm(Model model) {
        model.addAttribute("author", new Author());
        return "/add-author";
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(method = RequestMethod.GET, params = {"nameSearch", "searchAction"})
    public String searchByName(@RequestParam("nameSearch") String nameSearch, @RequestParam("searchAction")
            String searchAction, Model model) {
        switch (searchAction) {
            case "searchByBookTitle":
                model.addAttribute("authorList", bookService.findAuthorByBookTitle(nameSearch));
                return "/list-authors";
            case "searchByAuthorName":
                model.addAttribute("authorList", bookService.findAuthorByName(nameSearch));
                return "/list-authors";
            default:
                model.addAttribute("authorList", bookService.findAuthorByName(nameSearch));
                return "/list-authors";

        }
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(method = RequestMethod.POST, value = "delete/{id}")
    public String deleteAuthor(@PathVariable("id") Long id, Model model) {
        bookService.deleteAuthor(id);
        model.addAttribute("authorList", bookService.findAllAuthors());
        return "/list-authors";
    }
}
