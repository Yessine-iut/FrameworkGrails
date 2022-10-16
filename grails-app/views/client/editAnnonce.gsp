<%--
  Created by IntelliJ IDEA.
  User: Anthony
  Date: 15/10/2022
  Time: 22:26
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

    <div hidden class="form-group fieldcontain required">
        <label for="redirectUrl">Title</label>
        <input type="text" class="form-control" name="redirectUrl" value="/client/annoncesList" id="redirectUrl">
    </div>

    <fieldset class="buttons">
        <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
    </fieldset>
</g:form>

</div>
</div>
</div>
</body>
</html>