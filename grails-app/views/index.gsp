<%@ page contentType="text/html;charset=UTF-8" import="com.mbds.grails.Annonce" import="com.mbds.grails.Illustration" import="com.mbds.grails.User"  import="com.mbds.grails.UserRole"%>


<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Dashboard</title>
    <sec:ifLoggedIn>
        <g:set var="usernameLog" value="${sec.username()}" />
        <g:set var="user" value="${User.findByUsername(usernameLog)}" />
        <g:set var="role" value="${UserRole.findByUser(user)}" />
        <g:if test="${role.getRole().getAuthority() == 'ROLE_CLIENT'}">
            <meta http-equiv="Refresh" content="0; url=/client/annoncesList" />
        </g:if>
    </sec:ifLoggedIn>
</head>
<body>

<div id="content" role="main">
    <h1>Welcome to the Dashboard !</h1>
    <div class="d-flex justify-content-around mt-5">
        <a href="/user/index" class="item-dashboard btn">
            <div class="d-flex flex-column">
                <i class="fas fa-user mb-2"></i>
                <h5><b>Controller: </b><span>User</span></h5>
                <p>${User.count()} entités</p>
            </div>
        </a>
        <a href="/annonce/index" class="item-dashboard btn">
            <div class="d-flex flex-column">
                <i class="fas fa-book mb-2"></i>
                <h5><b>Controller: </b><span>Annonce</span></h5>
                <p>${Annonce.count()} entités</p>

            </div>
        </a>
        <!--<a href="/illustration/index" class="item-dashboard btn">
            <div class="d-flex flex-column">
                <i class="fas fa-image mb-2"></i>
                <h5><b>Controller: </b><span>Illustration</span></h5>
                <p>${Illustration.count()} entités</p>
            </div>
        </a>-->
    </div>
</div>

</body>
</html>