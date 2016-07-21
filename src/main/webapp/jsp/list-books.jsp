<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" type="text/css">
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <title>List books</title>

    <spring:message code="label_book_list" var="labelBookList"/>
    <spring:message code="label_search" var="labelSearch"/>
    <spring:message code="label_add_new_book" var="labelAddNewBook"/>
    <spring:message code="label_book_title" var="labelBookTitle"/>
    <spring:message code="label_book_price" var="labelBookPrice"/>
    <spring:message code="label_book_nbofpage" var="labelBookNbOfPage"/>
    <spring:message code="label_book_description" var="labelBookDescription"/>
    <spring:message code="label_place_holder_search" var="labelPlaceholderSearch"/>
    <spring:message code="label_search_by_book_title" var="labelSerchByBookTitle"/>
    <spring:message code="label_search_by_author_name" var="labelSerchByAuthorName"/>
    <spring:message code="label_remove" var="labelRemove"/>
    <spring:message code="label_book_authors" var="labelBookAuthors"/>
    <spring:message code="label_no_found" var="labelNoFound"/>
    <spring:message code="label_en_US" var="labelEnUs"/>
    <spring:message code="label_ru_RU" var="labelRuRU"/>
    <spring:message code="label_go_to_authors" var="goToAuthors"/>
    <spring:url value="/book" var="homeUrl"/>
    <spring:message code="label_book_choose_author" var="ChooseAuthor"/>
    <spring:message code="label_log_out" var="labelLogOut"/>
    <c:url var="logoutUrl" value="/logout"/>

</head>
<body>
<div class="container">
    <h2>${labelBookList}</h2>
    <div class="btn-toolbar pull-right" style="margin:5">
        <div class="btn-group">
            <a href="${homeUrl}?lang=ru_RU" class="btn pull-right btn btn-primary btn-md">${labelRuRU}</a>
        </div>
        <div class="btn-group">
            <a href="${homeUrl}?lang=en_US" class="btn pull-right btn btn-primary btn-md">${labelEnUs}</a>
        </div>
        <sec:authorize access="hasRole('ROLE_ADMIN')">
            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/author"
                   class="btn pull-right btn btn-primary btn-md">${goToAuthors}</a>
            </div>
        </sec:authorize>
        <div class="btn-group">
            <form class="form-inline" action="${logoutUrl}" method="post">
                <input type="submit" class="btn btn btn-primary btn-md" value="${labelLogOut}"/>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
        </div>
    </div>
    <form action="${pageContext.request.contextPath}/book" method="get" id="seachBookForm" role="form">
        <div class="form-group col-xs-5">
            <input type="text" name="nameSearch" id="nameSearch" class="form-control" required="true"
                   placeholder="${labelPlaceholderSearch}"/>
        </div>
        <button type="submit" class="btn btn-info">
            <span class="glyphicon goliphicon-search"></span>${labelSearch}
        </button>
        <br></br>
        <input type="radio" id="searchByBookTitle" name="searchAction" value="searchByBookTitle"
               checked="checked"/>${labelSerchByBookTitle}
        &nbsp
        <input type="radio" id="searchByAuthorName" name="searchAction"
               value="searchByAuthorName"/>${labelSerchByAuthorName}
    </form>
    <form action="${pageContext.request.contextPath}/book/${book.id}" method="post" role="form" id="booksForm">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <c:choose>
            <c:when test="${not empty bookList}">
                <div class="table-responsive">
                    <table style="width: auto" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>${labelBookTitle}</th>
                            <th>${labelBookPrice}</th>
                            <th>${labelBookAuthors}</th>
                            <th>${labelBookNbOfPage}</th>
                            <th>${labelBookDescription}</th>
                            <sec:authorize access="hasRole('ROLE_ADMIN')">
                                <th>${labelRemove}</th>
                            </sec:authorize>
                        </tr>
                        </thead>
                        <c:forEach var="book" items="${bookList}" varStatus="counter">
                            <tr class="${classSucess}">
                                <td>
                                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                                        <a href="${pageContext.request.contextPath}/book/${book.id}">${counter.count}</a>
                                    </sec:authorize>
                                    <sec:authorize access="hasRole('ROLE_USER')">
                                        ${counter.count}
                                    </sec:authorize>
                                </td>
                                <td>${book.title}</td>
                                <td>${book.price}</td>
                                <td><c:forEach var="authors" items="${book.authors}" varStatus="loop">
                                    ${authors.name}<c:if test="${!loop.last}">,</c:if>
                                </c:forEach>
                                </td>
                                <td>${book.nbOfPage}</td>
                                <td>${book.description}</td>
                                <sec:authorize access="hasRole('ROLE_ADMIN')">
                                    <td><a href="#" id="remove"
                                           onclick="document.getElementById('booksForm')
                                                   .action='${pageContext.request.contextPath}/book/delete/${book.id}';
                                                   document.getElementById('booksForm').submit();">
                                        <span class="glyphicon glyphicon-trash"/>
                                    </a></td>
                                </sec:authorize>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <br></br>
                <div class="alert alert-info">
                        ${labelNoFound}
                </div>
            </c:otherwise>
        </c:choose>
    </form>
    <sec:authorize access="hasRole('ROLE_ADMIN')">
        <a href="${pageContext.request.contextPath}/book?addForm" class="btn btn-primary btn-md">${labelAddNewBook}</a>
    </sec:authorize>
</div>

</body>
</html>
