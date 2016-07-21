package com.spring.book;



import com.spring.book.model.Author;
import com.spring.book.model.Book;
import com.spring.book.service.BookServiceImpl;
import org.springframework.context.support.GenericXmlApplicationContext;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        GenericXmlApplicationContext ctx =
                new GenericXmlApplicationContext();
        ctx.load("classpath:META-INF/application-context.xml");
        ctx.refresh();
        BookServiceImpl employeeService = ctx.getBean( "bookService", BookServiceImpl.class );
		/*Book book = new Book();
		book.setTitle("New book");
		book.setDescription("book about new");
		book.setNbOfPage(1000);
		book.setPrice(12.5f);
		System.out.println("book id = "+book.getId());
		employeeService.saveBook(book);
		System.out.println("book id = "+book.getId());
		book.setPrice(15.5f);
		Author author = new Author();
		Set<Author> authors = new HashSet<>();
		authors.add(author);
		book.setAuthors(authors);
		employeeService.saveBook(book);
		Author authorId = employeeService.findAuthorById(1L);
		System.out.println("authorId = "+authorId.getId()+" "+authorId.getName());*/

		Author author1 = new Author();
		author1.setName("sdgdfg");
		employeeService.saveAuthor(author1);

		Book book1 = new Book();
		book1.setTitle("dfgsdgdsg");
		book1.setPrice(12F);
		book1.setDescription("dsfgdsgsdgds");
		employeeService.saveBook(book1);

		List<Author> autors = employeeService.findAllAuthors();
		for(Author author:autors){
			System.out.println(	"Autor id = "+ author.getId());
			System.out.println(	"Autor name = "+ author.getName());
		}

       /* Employee employee = new Employee("sdfsd", "sdfsdf", "sdfsdf", "dsfsdf", "sdfsdf", "sdfsdf");
        long id = employeeService.addEmployee(employee);
        System.out.println(id);*/

    }
}
