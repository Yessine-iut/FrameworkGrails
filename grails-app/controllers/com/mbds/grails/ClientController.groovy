package com.mbds.grails

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException

import javax.servlet.http.Part

import static org.springframework.http.HttpStatus.CREATED
import static org.springframework.http.HttpStatus.OK

@Secured(['ROLE_ADMIN', 'ROLE_MODERATOR','ROLE_CLIENT'])
class ClientController {

    AnnonceService annonceService

    def index() { }

    def annoncesList() {
        respond annonceService.list(params), model:[annonceCount: annonceService.count()]
    }

    def newAnnonce() { }


    def product(Long id) {
        respond annonceService.get(id)
    }

    def myannonces(Long id) {
        respond annonceService.get(id)
    }

    def editAnnonce(Long id) {
        respond annonceService.get(id)
    }
}
