package com.spring.book.repository;

import com.spring.book.model.Author;
import com.spring.book.model.Book;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by ???? on 01.07.2016.
 */

public interface BookRepository {

	List<Book> findAll();

	void save(Book book);

	Book findById(Long id);

	void deleteBook(Long id);

	List<Book> findByName(String name);

	List<Book> findByAuthorName(String authorName);

}
