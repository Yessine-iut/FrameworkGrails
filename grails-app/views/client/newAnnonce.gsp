<%--
  Created by IntelliJ IDEA.
  User: Anthony
  Date: 15/10/2022
  Time: 23:48
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>

<body>
<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.annonce}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.annonce}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <form action="/annonce/save" method="post" enctype="multipart/form-data">
        <div class="form-group fieldcontain required">
            <label for="title">Title</label>
            <input type="text" class="form-control" name="title" value="" maxlength="100" id="title" placeholder="Enter title" required="">
        </div>
        <div class="form-group fieldcontain required">
            <label for="description">Description</label>
            <input type="text" class="form-control" id="description" name="description" value="" placeholder="Enter description" required="">
        </div>
        <div class="form-group fieldcontain required">
            <label for="price">Price</label>
            <input type="number decimal" class="form-control" id="price" step="0.01" min="0.0" name="price" value="" placeholder="Enter price" required="">
        </div>
        <div class="form-check">
            <label class="form-check-label" for="active">Active</label>
            <input class="form-check-input" type="checkbox" name="active" id="active">
        </div>
        <div class="custom-file">
            <input type="file" class="custom-file-input" id="avatar" name="annonces[]" multiple="multiple">
        </div>
        <input type="hidden" name="redirectUrl" value="/client/annoncesList" id="redirectUrl">
        <input type="hidden" name="author.id" value="${sec.loggedInUserInfo(field: 'id')}" id="author">
        <input type="submit" name="create" class="save btn btn-secondary mt-2" value="Create" id="create">
    </form>
</div>
</div>
</div>
</body>
</html>