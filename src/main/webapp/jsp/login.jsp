<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login page</title>
    <link rel="stylesheet" href="resources/css/bootstrap.css" type="text/css">
    <link rel="stylesheet" href="resources/css/style.css" type="text/css">
    <script src="resources/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css"
          href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.css"/>

    <spring:message code="label_en_US" var="labelEnUs"/>
    <spring:message code="label_ru_RU" var="labelRuRU"/>
    <spring:message code="label_placeholder_username" var="labelPlaceholderUserName"/>
    <spring:message code="label_placeholder_password" var="labelPlaceholderPaassword"/>
    <spring:message code="label_login" var="labelLogin"/>
    <spring:message code="label_ru_RU" var="labelRuRU"/>
    <spring:url value="/login" var="homeUrl"/>

</head>

<body>
<div id="mainWrapper">
    <div class="btn-toolbar pull-right" style="margin:5">
        <div class="btn-group">
            <a href="${homeUrl}?lang=ru_RU" class="btn pull-right btn btn-primary btn-md">${labelRuRU}</a>
        </div>
        <div class="btn-group">
            <a href="${homeUrl}?lang=en_US" class="btn pull-right btn btn-primary btn-md">${labelEnUs}</a>
        </div>
    </div>
    <div class="login-container">

        <div class="login-card">
            <div class="login-form">
                <c:if test="${message != null}">
                    <div class="alert alert-danger">
                        <p>${message.toString()}</p>
                    </div>
                </c:if>
                <c:url var="loginUrl" value="/login"/>
                <form action="${loginUrl}" method="post" class="form-horizontal">

                    <div class="input-group input-sm">
                        <label class="input-group-addon" for="username"><i class="fa fa-user"></i></label>
                        <input type="text" class="form-control" id="username" name="username"
                               placeholder="${labelPlaceholderUserName}"
                               required>
                    </div>
                    <div class="input-group input-sm">
                        <label class="input-group-addon" for="password"><i class="fa fa-lock"></i></label>
                        <input type="password" class="form-control" id="password" name="password"
                               placeholder="${labelPlaceholderPaassword}" required>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                    <div class="form-actions">
                        <input type="submit"
                               class="btn btn-block btn-primary btn-default" value="${labelLogin}">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
