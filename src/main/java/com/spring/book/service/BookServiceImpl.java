package com.spring.book.service;

import com.spring.book.model.Author;
import com.spring.book.model.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import com.spring.book.repository.AuthorRepository;
import com.spring.book.repository.BookRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service("bookService")
public class BookServiceImpl implements BookService {

	@Autowired
	private AuthorRepository authorRepository;
	@Autowired
	private BookRepository bookRepository;

	public List<Book> findAllBooks() {
		return bookRepository.findAll();
	}

	public List<Author> findAllAuthors() {
		return authorRepository.findAll();
	}

	public void saveAuthor(Author author) {
		authorRepository.save(author);
	}

	public void saveBook(Book book) {
		System.out.println("book id in service = "+book.getId());
		bookRepository.save(book);
	}

	public List<Book> findBookByName(String name) {
		return bookRepository.findByName(name);
	}

	public Book findBookById(Long id) {
		return bookRepository.findById(id);
	}

	public Author findAuthorById(Long id) {
		return authorRepository.findById(id);
	}

	public List<Book> findBookByAuthorName(String AuthorName) {
		return bookRepository.findByAuthorName(AuthorName);
	}

	public void deleteAuthor(Long id) {
		authorRepository.delete(id);
	}

	@Override
	public List<Author> findAuthorByBookTitle(String title) {
		return authorRepository.findAuthorByBookTitle(title);
	}

	@Override
	public List<Author> findAuthorByName(String authorName) {
		return authorRepository.findAuthorByName(authorName);
	}

	public void deleteBook(Long id) {
		bookRepository.deleteBook(id);
	}
}
