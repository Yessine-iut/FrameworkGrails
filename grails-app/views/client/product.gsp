<%--
  Created by IntelliJ IDEA.
  User: Anthony
  Date: 15/10/2022
  Time: 19:24
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />

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
                    <li><a href="/client/annoncesList">Listes des annonces</a></li>
                    <li class="active">Annonce ${this.annonce.id}</li>
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
            <!-- Product main img -->
            <div class="col-md-5 col-md-push-2">
                <div id="product-main-img">
                    <g:each in="${this.annonce.illustrations}" var="illustration">
                        <div class="product-preview">
                            <img src="${grailsApplication.config.illustrations.baseUrl+illustration.filename}" alt="">
                        </div>
                    </g:each>
                </div>
            </div>
            <!-- /Product main img -->

            <!-- Product thumb imgs -->
            <div class="col-md-2  col-md-pull-5">
                <div id="product-imgs">
                    <g:each in="${this.annonce.illustrations}" var="illustration">
                        <div class="product-preview">
                            <img src="${grailsApplication.config.illustrations.baseUrl+illustration.filename}" alt="">
                        </div>
                    </g:each>
                </div>
            </div>
            <!-- /Product thumb imgs -->

            <!-- Product details -->
            <div class="col-md-5">
                <div class="product-details">
                    <h2 class="product-name">${annonce.title}</h2>
                    <div>
                        <div class="product-rating">
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star-o"></i>
                        </div>
                    </div>
                    <div>
                        <h3 class="product-price">$${annonce.price}</h3>
                        <g:if test="${annonce.active}">
                            <span class="product-available">Available</span>
                        </g:if>
                        <g:else>
                            <span class="product-available">Unavailable</span>
                        </g:else>

                    </div>
                    <p>${annonce.description}</p>


                    <div class="add-to-cart">
                        <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                    </div>

                    <ul class="product-links">
                        <li>Author:</li>
                        <li><p>${annonce.author.username}</p></li>
                    </ul>

                </div>
            </div>
            <!-- /Product details -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->
</body>
</html>