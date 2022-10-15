<%@ page import="com.mbds.grails.Role" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>
<body>
<h1><g:message code="default.create.label" args="[entityName]" /></h1>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<g:hasErrors bean="${this.user}">
    <ul class="errors" role="alert">
        <g:eachError bean="${this.user}" var="error">
            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
        </g:eachError>
    </ul>
</g:hasErrors>
<form action="/user/save" method="post">
    <div class="form-group fieldcontain required">
        <label for="username">Username</label>
        <input type="text" class="form-control" id="username" name="username" value="" placeholder="Enter username" required="">
    </div>
    <div class="form-group fieldcontain required">
        <label for="password">Password</label>
        <input type="password" class="form-control" id="password" name="password" value="" placeholder="Enter password" required="">
    </div>
    <div class="form-group fieldcontain required">
        <label for="role">Rôle</label>
        <select class="form-control" type="role" name="role" required="true" id="role">
            <g:each in="${Role.list()}" var="role">
                <option value="${role.authority}">${role}</option>
            </g:each>
        </select>
    </div>
    <input type="submit" name="create" class="save btn btn-secondary mt-2" value="Create" id="create">
</form>

</body>
</html>
