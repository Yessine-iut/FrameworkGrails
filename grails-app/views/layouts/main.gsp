<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
    <g:layoutTitle default="Grails"/>
    </title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" />

    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:stylesheet src="dashboard.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" integrity="sha512-HK5fgLBL+xu6dm/Ii3z4xhlSUyZgTT9tuc/hSrtw6uzJOvgRr2a9jyxxT1ely+B+xFAmJKVSTbpM/CuL7qxO8w==" crossorigin="anonymous" />
    <g:layoutHead/>

</head>
<body>

<section class="main">
    <div class="btn btn-hamburger">
        <i class="fas fa-bars"></i>
    </div>
    <div class="sidebar">
        <div class="sidebar-top">
            <div class="sb-logo">
                <img src="/assets/logo.png">
            </div>
            <ul class="sb-ul">
                <li><a href="/"><i class="fas fa-home fontawesome"></i>Accueil</a>
                </li>
                <li><a><i class="fas fa-user fontawesome"></i>Users<i class="fas fa-chevron-down chev-pos"></i></a>
                    <ul class="sb-sub-ul">
                        <li><a href="/user/create"><i class="fas fa-plus fontawesome"></i>New user</a></li>
                        <li><a href="/user/index"><i class="fas fa-list fontawesome"></i>User list</a></li>
                    </ul>
                </li>
                <li><a><i class="fas fa-book fontawesome"></i>Annonces<i class="fas fa-chevron-down chev-pos"></i></a>
                    <ul class="sb-sub-ul">
                        <li><a href="/annonce/create"><i class="fas fa-plus fontawesome"></i>New annonce</a></li>
                        <li><a href="/annonce/index"><i class="fas fa-list fontawesome"></i>Annonce list</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <a href="/client/annoncesList" class="btn btn-success">Go to Lecoincoin page</a>
        <sec:ifNotLoggedIn>
            <div class="sidebar-bottom">
                <a href="/login" class="btn btn-login">S'identifier</a>
            </div>
        </sec:ifNotLoggedIn>
        <sec:ifLoggedIn>
            <div class="sidebar-bottom">
                <b>connected as <sec:loggedInUserInfo field="username"/></b>
                <a href="/logout" class="btn btn-logout">Se deconnecter</a>
            </div>
        </sec:ifLoggedIn>
    </div>
    <div class="dashboard">
        <g:layoutBody/>
    </div>
</section>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<asset:javascript src="dashboard.js"/>

</body>
</html>
