<%@ page import="com.mbds.grails.Illustration" %>
<%@ page import="com.mbds.grails.Annonce" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
<div id="edit-annonce" class="content scaffold-edit" role="main">
    <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
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
    <g:form resource="${this.annonce}" method="PUT" enctype="multipart/form-data">
        <div class="form-group fieldcontain required">
            <label for="title">Title</label>
            <span class="required-indicator">*</span>
            <input type="text" class="form-control" name="title" value="${this.annonce.title}" required="" maxlength="100" id="title">
        </div>
        <div class="form-group fieldcontain required">
            <label for="description">Description</label>
            <span class="required-indicator">*</span>
            <input type="text" class="form-control" name="description" value="${this.annonce.description}" required="" maxlength="100" id="description">
        </div>
        <div class="form-group fieldcontain required">
            <label for="price">Price</label>
            <span class="required-indicator">*</span>
            <input class="form-control" name="price" value="${this.annonce.price}" required="" step="0.01" min="0.0" id="price">
        </div>
        <div class="form-group fieldcontain">
            <label for="active"> Active </label>
            <g:if test="${this.annonce.active}">
                <input type="checkbox" name="active" id="active" checked>
            </g:if>
            <g:else>
                <input type="checkbox" name="active" id="active" >
            </g:else>
        </div>
        <div class="form-group fieldcontain">
            <label for="annonces[]"> Ajouter des illustrations </label>
            <input  class="form-control" type="file"
                   name="annonces[]" multiple="multiple"
            >
        </div>
        <div class="form-group fieldcontain" style="margin-top:4px;margin-bottom: 4px;">
            <g:each in="${this.annonce.illustrations}" var="illu">
                <div>
                    <img width="50px" src="${grailsApplication.config.illustrations.baseUrl+illu.filename}" />
                    <input type="checkbox" name="${illu.id}"/> supprimer ${illu.id}
                </div>
            </g:each>
        </div>


        <fieldset class="buttons">
            <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
        </fieldset>
    </g:form>

</div>
</body>
</html>
