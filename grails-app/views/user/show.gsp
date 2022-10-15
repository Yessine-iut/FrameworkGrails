<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
             <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>

    <g:form method="DELETE" resource="${this.user}">
        <ul class="list-group list-group-flush property-list annonce">
            <li class="list-group-item">
                <div class="property-value" aria-labelledby="username-label"><b id="username" class="property-label">Username: </b>${this.user.username}</div>
            </li>
            <li class="list-group-item">
                <div class="property-value" aria-labelledby="password-label"><b id="password" class="property-label">Password: </b>${this.user.password}</div>
            </li>
            <li class="list-group-item">
                <div class="property-value" aria-labelledby="role-label"><b id="password expired" class="property-label">Rôle: </b>${(this.user.getAuthorities().authority)}</div>

            </li>
            <li class="list-group-item">
                <div class="property-value" aria-labelledby="passwordExpired-label"><b id="password expired" class="property-label">Password expired: </b>${this.user.passwordExpired}</div>

            </li>
            <li class="list-group-item">
                <div class="property-value" aria-labelledby="accountLocked-label"><b id="account locked" class="property-label">Account locked: </b>${this.user.accountLocked}</div>
            </li>
            <li class="list-group-item">
                <div class="property-value" aria-labelledby="acountExpired-label"><b id="account expired" class="property-label">Account expired: </b>${this.user.accountExpired}</div>
            </li>
            <li class="list-group-item">
                <div class="property-value" aria-labelledby="enabled-label"><b id="enabled" class="property-label">Enabled: </b>${this.user.enabled}</div>
            </li>
        </ul>
        <h2>Annonces: </h2>
        <g:each in="${user.getAnnonces()}" var="annonce">
            <ul class="list-group">
                <li class="list-group-item"><a href="/annonce/show/${annonce.getId()}">${annonce.getTitle()}</a></li>
            </ul>
        </g:each>
        <form action="/user/delete/${this.user.id}" class="mt-2 d-flex flex-row" method="post">
            <button class="btn btn-secondary"><a style="color: white; text-decoration: none" href="/user/edit/${this.user.id}">Edit</a></button>
            <input type="submit" name="delete" class="btn btn-danger" value="Delete" id="delete" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" >
        </form>
    </g:form>
    </body>
</html>
