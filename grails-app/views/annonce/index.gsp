<%@ page import="com.mbds.grails.Annonce" %>
<%@ page import="com.mbds.grails.UserRole" %>
<%@ page import="com.mbds.grails.User"  %>
<script src="https://www.kryogenix.org/code/browser/sorttable/sorttable.js"></script>
<script src="https://www.w3schools.com/lib/w3.js"></script>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<table class="table" id="usersTable">
    <thead>
    <tr>
        <g:sortableColumn property="${Annonce.list(title)}" title="Title"
                          style="width: 200px" />
        <g:sortableColumn property="${Annonce.list(description)}" title="Description"
                          style="width: 200px" />
        <g:sortableColumn property="${Annonce.list(price)}" title="Price"
                          style="width: 200px" />
        <g:sortableColumn property="this.annonce.active" title="active"
                          style="width: 200px" />
        <th>Illustrations</th>
        <g:sortableColumn property="${Annonce.list(author)}" title="author"
                          style="width: 200px" />
    </tr>
    </thead>
    <tbody>
    <g:each in="${Annonce.list()}" var="annonce">
        <tr class="even">
            <td><a href="/annonce/show/${annonce.id}">${annonce.title}</a></td>
            <td>${annonce.description}</td>
            <td>${annonce.price}</td>
            <td>${annonce.active}</td>
            <td>
                <g:each in="${annonce.illustrations}" var="illustration">
                    <a href="/illustration/show/${illustration.id}"><img width="50px" src="${grailsApplication.config.illustrations.baseUrl+illustration.filename}" /></a>
                </g:each>
            </td>
            <td><a href="/user/show/${annonce.author.id}">${annonce.author}</a></td>
            <td>
                <div class="d-flex flex-row">
                    <a href="/annonce/edit/${annonce.id}"  style="text-decoration: none;"><button class="btn btn-secondary"><i class="fas fa-pen"></i></button></a>
                    <form action="/annonce/delete/${annonce.id}" method="post"><input type="hidden" name="_method" value="DELETE" id="_method">
                        <g:set var="usernameLog" value="${sec.username()}" />
                        <g:set var="role" value="${UserRole.findByUser(User.findByUsername(usernameLog))}" />
                        <g:if test="${role.getRole().getAuthority() == 'ROLE_ADMIN'}">
                            <button class="btn btn-danger delete" type="submit" value="Delete" onclick="return confirm('Are you sure?');"><i style="color: white" class="fas fa-trash"></i></button>
                        </g:if>
                    </form>
                </div>
            </td>
        </tr>
    </g:each>

    </tbody>
</table>
<div class="pagination">
    <g:paginate total="${annonceCount ?: 0}" />
</div>
</div>
</body>
</html>