package com.spring.book.repository;


import com.spring.book.model.Author;
import com.spring.book.model.Book;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


public interface AuthorRepository {

	List<Author> findAll();

	void save(Author author);

	Author findById(Long id);

	void delete(Long id);

	List<Author> findAuthorByBookTitle(String title);

	List<Author> findAuthorByName(String authorName);

}
