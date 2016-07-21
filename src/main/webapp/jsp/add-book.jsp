<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" type="text/css">
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

    <spring:message code="label_book_choose_author" var="labelChooseAuthor"/>
    <spring:message code="label_book_title" var="labelBookTitle"/>
    <spring:message code="label_book_price" var="labelBookPrice"/>
    <spring:message code="label_book_nbofpage" var="labelBookNbOfPage"/>
    <spring:message code="label_book_description" var="labelBookDescription"/>
    <spring:message code="label_accept" var="labelBookAccept"/>
    <spring:message code="label_edit" var="labelEdit"/>
    <spring:message code="label_add" var="labelAdd"/>
    <spring:message code="label_book" var="labelBook"/>
    <spring:message code="label_go_to_books" var="labelGoToBooks"/>
    <spring:message code="label_go_to_authors" var="labelGoToAuthors"/>
    <spring:message code="label_log_out" var="labelLogOut"/>
    <c:url var="logoutUrl" value="/logout"/>


    <c:choose>
        <c:when test="${empty action }">
            <c:set var="action" value="${labelAdd}"/>
        </c:when>
        <c:otherwise>
            <c:set var="action" value="${labelEdit}"/>
        </c:otherwise>
    </c:choose>
    <title>${action} ${labelBook}</title>

</head>
<body>
<div class="container">
    <div class="btn-toolbar pull-right" style="margin:5">
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/book" class="btn btn-primary btn-md">${labelGoToBooks}</a>
        </div>
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/author"
               class="btn btn btn-primary btn-md">${labelGoToAuthors}</a>
        </div>
        <div class="btn-group">
            <form class="form-inline" action="${logoutUrl}" method="post">
                <input type="submit" class="btn btn btn-primary btn-md" value="${labelLogOut}"/>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
        </div>
    </div>
    <form:form modelAttribute="book" action="${pageContext.request.contextPath}/book/${book.id}"
               method="post" role="form" data-toggle="validator">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <h2>${action} ${labelBook}</h2>

        <div class="row">
            <div class="form-group col-md-12">
                <label for="title" class="control-label col-xs-4">${labelBookTitle}</label>
                <form:input path="title" type="text" name="title" id="title" class="form-control"
                            value="${book.title}" required="true"/>
                <div class="has-error">
                    <form:errors path="title" cssClass="help-inline"/>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-md-12">
                <label for="price" class="control-label col-xs-4">${labelBookPrice}</label>
                <form:input path="price" type="text" name="price" id="price" class="form-control"
                            value="${book.price}" required="true"/>
                <div class="has-error">
                    <form:errors path="price" cssClass="help-inline"/>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-md-12">
                <label for="nbOfPage" class="control-label col-xs-4">${labelBookNbOfPage}</label>
                <form:input path="nbOfPage" type="text" name="nbOfPage" id="nbOfPage" class="form-control"
                            value="${book.nbOfPage}" required="true"/>
                <div class="has-error">
                    <form:errors path="nbOfPage" cssClass="help-inline"/>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-md-12">
                <label for="description" class="control-label col-xs-4">${labelBookDescription}</label>
                <form:input path="description" type="text" name="description" id="description" class="form-control"
                            value="${book.description}" required="true"/>
                <div class="has-error">
                    <form:errors path="description" cssClass="help-inline"/>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-12">
                <label class="col-md-3 control-lable" for="authors">${labelChooseAuthor} </label>
                <div class="col-md-7">
                    <form:select path="authors" multiple="true"
                                 name="authors" id="authors" class="form-control input-sm">
                        <form:options items="${authors}" itemValue="id" itemLabel="name"></form:options>
                    </form:select>
                    <div class="has-error">
                        <form:errors path="authors" class="help-inline"/>
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary btn-md">${labelBookAccept}</button>

    </form:form>
</div>

</body>
</html>
