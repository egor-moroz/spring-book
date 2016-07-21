package com.spring.book.service;

import com.spring.book.model.Author;
import com.spring.book.model.Book;

import java.util.List;


public interface BookService {

	List<Book> findAllBooks();

	List<Author> findAllAuthors();

	void saveAuthor(Author author);

	void saveBook(Book book);

	List<Book> findBookByName(String name);

	Book findBookById(Long id);

	Author findAuthorById(Long id);

	List<Book> findBookByAuthorName(String AuthorName);

	void deleteAuthor(Long id);

	List<Author> findAuthorByBookTitle(String title);

	List<Author> findAuthorByName(String authorName);

	void deleteBook(Long id);


}
