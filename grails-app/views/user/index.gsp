<%--
  Created by IntelliJ IDEA.
  User: Anthony
  Date: 11/10/2022
  Time: 22:18
--%>
<%@ page import="com.mbds.grails.UserRole" %>
<%@ page contentType="text/html;charset=UTF-8" import="com.mbds.grails.User"  %>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
<table class="table">
    <thead>
    <tr>
        <th scope="col">#</th>
        <th scope="col">Username</th>
        <th scope="col">Password</th>
        <th scope="col">Account Expired</th>
        <th scope="col">Account Locked</th>
        <th scope="col">Annonces</th>
        <th scope="col">Action</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${User.list()}" var="user">
        <tr>
            <th scope="row">${user.id}</th>
            <td><a href="/user/show/${user.id}">${user.username}</a></td>
            <td>${user.getPassword()}</td>
            <td>${user.accountExpired}</td>
            <td>${user.accountLocked}</td>
            <td>
                <g:each in="${user.getAnnonces()}" var="annonce">
                    <ul class="list-group">
                        <li class="list-group-item"><a href="/annonce/show/${annonce.getId()}">${annonce.getTitle()}</a></li>
                    </ul>
                </g:each>
            </td>
            <td>
                <div class="d-flex flex-row">
                    <a href="/user/edit/${user.id}" style="text-decoration: none;"><button class="btn btn-secondary"><i class="fas fa-pen"></i></button></a>
                    <form action="/user/delete/${user.id}" method="post"><input type="hidden" name="_method" value="DELETE" id="_method">
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
</body>
</html>