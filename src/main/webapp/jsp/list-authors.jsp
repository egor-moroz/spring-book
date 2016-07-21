<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" type="text/css">
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <title>List books</title>
    <spring:message code="label_en_US" var="labelEnUs"/>
    <spring:message code="label_ru_RU" var="labelRuRU"/>
    <spring:message code="label_go_to_books" var="labelGoToBooks"/>
    <spring:message code="label_place_holder_search" var="labelPlaceholderSearch"/>
    <spring:message code="label_search_by_book_title" var="labelSerchByBookTitle"/>
    <spring:message code="label_search_by_author_name" var="labelSerchByAuthorName"/>
    <spring:message code="label_book_list" var="labelBookList"/>
    <spring:message code="label_search" var="labelSearch"/>
    <spring:message code="label_remove" var="labelRemove"/>
    <spring:message code="label_author_name" var="labelAuthorName"/>
    <spring:message code="label_author_list" var="labelAuthorList"/>
    <spring:message code="label_no_found" var="labelNoFound"/>
    <spring:message code="label_add_new_author" var="labelAddNewAuthor"/>
    <spring:message code="label_log_out" var="labelLogOut"/>
    <spring:url value="/author" var="homeUrl"/>
    <c:url var="logoutUrl" value="/logout"/>


</head>
<body>
<div class="container">
    <h2>${labelAuthorList}</h2>
    <div class="btn-toolbar pull-right" style="margin:5">
        <div class="btn-group">
            <a href="${homeUrl}?lang=ru_RU" class="btn pull-right btn-primary btn-md">${labelRuRU}</a>
        </div>
        <div class="btn-group">
            <a href="${homeUrl}?lang=en_US" class="btn pull-right btn-primary btn-md">${labelEnUs}</a>
        </div>
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/book" class="btn pull-right btn-primary btn-md">${labelGoToBooks}</a>
        </div>
        <div class="btn-group">
            <form class="form-inline" action="${logoutUrl}" method="post">
                <input type="submit" class="btn btn btn-primary btn-md" value="${labelLogOut}"/>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
        </div>
    </div>
    <form action="${pageContext.request.contextPath}/author" method="get" id="seachAuthorForm" role="form">
        <div class="form-group col-xs-5">
            <input type="text" name="nameSearch" id="nameSearch" class="form-control" required="true"
                   placeholder="${labelPlaceholderSearch}."/>
        </div>
        <button type="submit" class="btn btn-info">
            <span class="glyphicon goliphicon-search"></span>${labelSearch}
        </button>
        <br></br>
        <input type="radio" id="searchByAuthorName" name="searchAction" value="searchByAuthorName" checked="checked"/>
        ${labelSerchByAuthorName}&nbsp
        <input type="radio" id="searchByBookTitle" name="searchAction" value="searchByBookTitle"/>
        ${labelSerchByBookTitle}
    </form>
    <form action="${pageContext.request.contextPath}/author/${author.id}" method="post" role="form" id="authorsForm">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <c:choose>
            <c:when test="${not empty authorList}">
                <div class="table-responsive">
                    <table style="width: auto" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>${labelAuthorName}</th>
                            <th>${labelBookList}</th>
                            <th>${labelRemove}</th>
                        </tr>
                        </thead>
                        <c:forEach var="author" items="${authorList}" varStatus="counter">
                            <tr class="${classSucess}">
                                <td>
                                    <a href="${pageContext.request.contextPath}/author/${author.id}">${counter.count}</a>
                                </td>
                                <td>${author.name}</td>
                                <td><c:forEach var="books" items="${author.books}" varStatus="loop">
                                    ${books.title}<c:if test="${!loop.last}">,</c:if>
                                </c:forEach>
                                </td>
                                <td><a href="#" id="remove"
                                       onclick="document.getElementById('authorsForm')
                                               .action='${pageContext.request.contextPath}/author/delete/${author.id}';
                                               document.getElementById('authorsForm').submit();">
                                    <span class="glyphicon glyphicon-trash"/>
                                </a></td>
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
    <br></br>
    <a href="${pageContext.request.contextPath}/author?addForm" class="btn btn-primary btn-md">${labelAddNewAuthor}</a>
</div>

</body>
</html>

