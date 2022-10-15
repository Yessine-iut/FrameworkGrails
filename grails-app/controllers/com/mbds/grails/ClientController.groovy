package com.mbds.grails

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN', 'ROLE_MODERATOR','ROLE_CLIENT'])
class ClientController {

    AnnonceService annonceService

    def index() { }

    def annoncesList() {
        respond annonceService.list(params), model:[annonceCount: annonceService.count()]
    }
}
