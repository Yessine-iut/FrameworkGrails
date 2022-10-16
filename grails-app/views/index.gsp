<%@ page import="com.mbds.grails.Annonce; com.mbds.grails.User; com.mbds.grails.Illustration" %>

<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Dashboard</title>
</head>
<body>

<div id="content" role="main">
    <h1>Welcome to the Dashboard !</h1>
    <p>Présentation du projet ?</p>
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