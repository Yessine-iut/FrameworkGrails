<%@ page import="com.mbds.grails.Illustration; com.mbds.grails.Annonce" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'illustration.label', default: 'Illustration')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="list-illustration" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <!--<f:table collection="${illustrationList}" /> -->

            <table class="table">
                <thead>
                <tr>
                    <th scope="col">Filename</th>
                    <th scope="col">Annonce</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${Illustration.list()}" var="illustration">
                    <tr>
                        <td>${illustration.filename}</td>
                        <td><a href="/annonce/show/${illustration.getAnnonce().id}">${illustration.getAnnonce()}</a></td>
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${illustrationCount ?: 0}" />
            </div>
        </div>
    </body>
</html>