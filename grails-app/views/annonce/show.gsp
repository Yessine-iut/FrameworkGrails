<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
<div id="show-annonce" class="content scaffold-show" role="main">
    <h1>Show Annonce</h1>

    <ul class="list-group list-group-flush property-list annonce">
        <li class="list-group-item">
            <div class="property-value" aria-labelledby="title-label"><b id="title-label" class="property-label">Title: </b>${this.annonce.title}</div>
        </li>
        <li class="list-group-item">
            <div class="property-value" aria-labelledby="description-label"><b id="description-label" class="property-label">Description: </b>${this.annonce.description}</div>
        </li>
        <li class="list-group-item">
            <div class="property-value" aria-labelledby="price-label"><b id="price-label" class="property-label">Price: </b>${this.annonce.price}</div>

        </li>
        <li class="list-group-item">
            <div class="property-value" aria-labelledby="active-label"><b id="active-label" class="property-label">Active: </b>${this.annonce.active}</div>
        </li>
        <li class="list-group-item">
            <div class="property-value" aria-labelledby="active-label"><b class="property-label">Author: </b><a href="/user/show/${this.annonce.author.id}">${this.annonce.author.username}</a></div>
        </li>

    </ul>
    <div class="d-flex flex-row">
        <g:each in="${this.annonce.illustrations}" var="illu">
            <div class="property-value" aria-labelledby="illustrations-label">
                <a href="/illustration/show/${illu.id}">${illu}</a>
                <img width="150px" src="/assets/${illu.filename}" />
            </div>
        </g:each>
    </div>
    <form action="/annonce/delete/${this.annonce.id}" method="post"><input type="hidden" name="_method" value="DELETE" id="_method">
        <fieldset class="buttons">
            <button class="btn btn-secondary"><a style="color: white; text-decoration: none" href="/annonce/edit/${this.annonce.id}" class="edit">Edit</a>
            </button>
            <input type="submit" name="delete" class="btn btn-danger" value="Delete" id="delete" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" >
        </fieldset>
    </form>
</div>

</div>
</body>
</html>
