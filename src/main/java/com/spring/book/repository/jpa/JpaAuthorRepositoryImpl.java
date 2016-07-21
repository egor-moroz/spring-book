package com.spring.book.repository.jpa;

import com.spring.book.model.Author;
import com.spring.book.repository.AuthorRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

/**
 * Created by ???? on 01.07.2016.
 */
@Repository
public class JpaAuthorRepositoryImpl implements AuthorRepository {

	@PersistenceContext
	private EntityManager entityManager;

	@Transactional(readOnly = true)
	public List<Author> findAll() {
		return this.entityManager.createQuery("FROM Author author ORDER BY author.name", Author.class).getResultList();
	}

	@Transactional
	public void save(Author author) {
		if (author.getId() == null) {
			this.entityManager.persist(author);
		} else {
			this.entityManager.merge(author);
		}
	}
	@Transactional(readOnly = true)
	public Author findById(Long id) {
		Query query = this.entityManager.createQuery("select distinct author FROM Author author where author.id =:id");
		query.setParameter("id", id);
		return (Author) query.getSingleResult();
	}

	@Transactional
	public void delete(Long id) {
		Author author = findById(id);
		if(author.getId()!= null) {
			entityManager.remove(author);
		}
	}

	@Override
	@Transactional(readOnly = true)
	public List<Author> findAuthorByBookTitle(String title) {
		Query query = this.entityManager.createQuery("select distinct author from Author author left join author.books book where UPPER(book.title) like :title");
		query.setParameter("title", title.toUpperCase() + "%");
		return query.getResultList();
	}

	@Override
	@Transactional(readOnly = true)
	public List<Author> findAuthorByName(String authorName) {
			Query query = this.entityManager.createQuery("select distinct author from Author author left join author.books book where author.name like :authorName");
			query.setParameter("authorName", authorName.toUpperCase() + "%");
			return query.getResultList();
	}

}
