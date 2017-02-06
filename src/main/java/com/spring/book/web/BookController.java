package com.spring.book.web;

import com.spring.book.model.Author;
import com.spring.book.model.Book;
import com.spring.book.service.impl.BookServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.beans.PropertyEditorSupport;

@Controller
@RequestMapping("/book")
public class BookController {

    @Autowired
    BookServiceImpl bookService;

    @RequestMapping(method = RequestMethod.GET)
    public String listBooks(Model model) {
        model.addAttribute("bookList", bookService.findAllBooks());
        return "/list-books";
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(method = RequestMethod.GET, value = "/{id}")
    public String show(@PathVariable("id") Long id, Model model) {
        model.addAttribute("book", bookService.findBookById(id));
        model.addAttribute("authors", bookService.findAllAuthors());
        model.addAttribute("action", "edit");
        return "/add-book";
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(method = RequestMethod.POST, value = "/{id}")
    public String editBook(@Valid Book book, BindingResult result, @PathVariable("id") Long id, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("book", book);
            model.addAttribute("authors", bookService.findAllAuthors());
            model.addAttribute("action", "edit");
            return "/add-book";
        } else {
            bookService.saveBook(book);
            model.addAttribute("bookList", bookService.findAllBooks());
            return "redirect:/book";
        }
    }
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(method = RequestMethod.POST)
    public String addBook(@Valid Book book, BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("book", book);
            model.addAttribute("authors", bookService.findAllAuthors());
            return "/add-book";
        }
        bookService.saveBook(book);
        model.addAttribute("authors", bookService.findAllAuthors());
        model.addAttribute("bookList", bookService.findAllBooks());
        return "redirect:/book";
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(method = RequestMethod.GET, params = "addForm")
    public String addForm(Model model) {
        model.addAttribute("book", new Book());
        model.addAttribute("authors", bookService.findAllAuthors());
        model.addAttribute("author", new Author());
        return "/add-book";
    }

    @RequestMapping(method = RequestMethod.GET, params = {"nameSearch", "searchAction"})
    public String searchByName(@RequestParam("nameSearch") String nameSearch, @RequestParam("searchAction")
            String searchAction, Model model) {
        switch (searchAction) {
            case "searchByBookTitle":
                model.addAttribute("bookList", bookService.findBookByName(nameSearch));
                return "/list-books";
            case "searchByAuthorName":
                model.addAttribute("bookList", bookService.findBookByAuthorName(nameSearch));
                return "/list-books";
            default:
                model.addAttribute("bookList", bookService.findBookByName(nameSearch));
                return "/list-books";

        }
    }
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(method = RequestMethod.POST, value = "delete/{id}")
    public String deleteBook(@PathVariable("id") Long id, Model model) {
        bookService.deleteBook(id);
        model.addAttribute("bookList", bookService.findAllBooks());
        return "/list-books";
    }


    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Author.class, new PropertyEditorSupport() {

            @Override
            public void setAsText(String text) throws IllegalArgumentException {
                Author author = bookService.findAuthorById(Long.parseLong(text));
                setValue(author);
            }
        });
    }

}
