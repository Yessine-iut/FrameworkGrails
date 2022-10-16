<%--
  Created by IntelliJ IDEA.
  User: Anthony
  Date: 30/09/2022
  Time: 14:25
--%>

<%@ page contentType="text/html;charset=UTF-8" import="grails.plugin.springsecurity.SpringSecurityService; com.mbds.grails.Annonce; com.mbds.grails.User"  %>
<html>
<head>
    <meta name="layout" content="client" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Liste des annonces</title>


</head>

<body>

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <div class="col-md-12">
                <ul class="breadcrumb-tree">
                    <li class="active"><a href="/client/annoncesList">Show all annonces (${Annonce.count})</a></li>
                </ul>
            </div>
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /BREADCRUMB -->

<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <!-- ASIDE -->
            <div id="aside" class="col-md-3">
                <!-- aside Widget -->
                <div class="aside">
                    <h3 class="aside-title">Authors</h3>
                    <div class="checkbox-filter">
                        <g:each in="${User.list()}" var="user">
                            <div class="input-checkbox">
                                <label for="category-1">
                                    <span></span>
                                    <a href="/client/annoncesList?author=${user.id}">${user.username}</a>

                                </label>
                            </div>
                        </g:each>
                    </div>
                </div>
                <!-- /aside Widget -->
            </div>
            <!-- /ASIDE -->

            <!-- STORE -->
            <div id="store" class="col-md-9">
                <a href="/client/newAnnonce" class="btn btn-secondary">Create new annonce</a>
                <!-- store products -->
                <div class="row">

                    <g:if test="${params.author}">
                        <g:set var="annonceData" value="${User.findById(params.author).getAnnonces()}" />
                    </g:if>
                    <g:else>
                        <g:set var="annonceData" value="${Annonce.list()}" />
                    </g:else>
                    <g:each in="${annonceData}" var="annonce">
                        <div class="col-md-4 col-xs-6">
                            <div class="product">
                                <div class="product-img">
                                    <img src="${grailsApplication.config.illustrations.baseUrl+annonce.illustrations.first().filename}">
                                    <div class="product-label">
                                        <span class="new">NEW</span>
                                    </div>
                                </div>
                                <div class="product-body">

                                    <h3 class="product-name"><a href="/client/product/${annonce.id}">${annonce.title}</a></h3>
                                    <h4 class="product-price">$${annonce.price}</h4>
                                    <p class="product-category">${annonce.description}</p>
                                    <div class="product-rating">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                    </div>
                                    <g:if test="${sec.loggedInUserInfo(field: 'username') == annonce.getAuthor().username.toString()}">
                                        <form action="/annonce/delete/${annonce.id}" method="post">
                                            <input type="hidden" name="_method" value="DELETE" id="_method">
                                            <div hidden class="form-group fieldcontain required">
                                                <label for="redirectUrl"></label>
                                                <input type="text" class="form-control" name="redirectUrl" value="/client/annoncesList" id="redirectUrl">
                                            </div>

                                            <a class="btn btn-secondary" href="/client/editAnnonce/${annonce.id}"><i class="fa fa-edit"></i>Edit</a>
                                            <input type="submit" name="delete" class="btn btn-danger" value="Delete" id="delete" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" >

                                        </form>

                                    </g:if>
                                </div>

                            </div>
                        </div>
                    </g:each>

                </div>
                <!-- /store products -->

                <!-- store bottom filter -->
                <!--<div class="store-filter clearfix">
                    <span class="store-qty">Showing 20-${annonceCount} products</span>
                    <ul class="store-pagination">
                        <li class="active">1</li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#"><i class="fa fa-angle-right"></i></a></li>
                    </ul>
                </div> -->
                <!--<g:paginate next="Forward" prev="Back"
                maxsteps="0" controller="annonce"
                action="list" total="${annonceCount}" /> -->
                <!-- /store bottom filter -->
            </div>
            <!-- /STORE -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->
</body>
</html>