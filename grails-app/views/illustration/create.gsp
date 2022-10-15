<%--
  Created by IntelliJ IDEA.
  User: Anthony
  Date: 11/10/2022
  Time: 17:11
--%>

<%@ page import="com.mbds.grails.Annonce" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'illustration.label', default: 'Illustration')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>

<body>
<h1><g:message code="default.create.label" args="[entityName]" /></h1>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<g:hasErrors bean="${this.illustration}">
    <ul class="errors" role="alert">
        <g:eachError bean="${this.illustration}" var="error">
            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
        </g:eachError>
    </ul>
</g:hasErrors>
<form action="/illustration/save" method="post">
    <div class="form-group fieldcontain required">
        <label for="filename">Filename</label>
        <input type="text" class="form-control" id="filename" name="filename" value="" placeholder="Enter filename" required="">
    </div>
    <div class="form-group fieldcontain required">
        <label for="annonce">Annonce</label>
        <select class="form-control" type="role" name="annonce" required="true" id="annonce">
            <g:each in="${com.mbds.grails.Annonce.list()}" var="annonce">
                <option value="${annonce.getId()}">${annonce}</option>
            </g:each>
        </select>
    </div>
    <input type="submit" name="create" class="save btn btn-secondary mt-2" value="Create" id="create">
</form>
</body>
</html>