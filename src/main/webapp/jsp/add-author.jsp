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
    <spring:message code="label_accept" var="labelAuthorAccept"/>
    <spring:message code="label_author_name" var="labelAuthorName"/>
    <spring:message code="label_edit" var="labelEdit"/>
    <spring:message code="label_add" var="labelAdd"/>
    <spring:message code="label_author" var="labelAuthor"/>
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
    <title>${action} ${labelAuthor}</title>
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
    <form:form modelAttribute="author" action="${pageContext.request.contextPath}/author/${author.id}"
               method="post" role="form" data-toggle="validator">

    <h2>${action} ${labelAuthor}</h2>

    <div class="row">
        <div class="form-group col-md-12">
            <label for="name" class="control-label col-xs-4">${labelAuthorName}</label>
            <form:input path="name" type="text" name="name" id="name" class="form-control"
                        value="${author.name}" required="true"/>
            <div class="has-error">
                <form:errors path="name" cssClass="help-inline"/>
            </div>
        </div>
    </div>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <button type="submit" class="btn btn-primary btn-md">${labelAuthorAccept}</button>

    </form:form>
    <form class="form-inline" action="${logoutUrl}" method="post">
        <input type="submit" value="Log out"/>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
</body>
</html>

