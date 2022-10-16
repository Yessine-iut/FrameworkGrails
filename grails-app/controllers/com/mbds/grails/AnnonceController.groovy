package com.mbds.grails

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException

import javax.servlet.http.Part

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_MODERATOR'])
class AnnonceController {

    AnnonceService annonceService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond annonceService.list(params), model:[annonceCount: annonceService.count()]
    }

    def show(Long id) {
        respond annonceService.get(id)
    }

    @Secured(value=["hasRole('ROLE_ADMIN')"])
    def create() {
        respond new Annonce(params)
    }

    @Secured(['ROLE_ADMIN', 'ROLE_CLIENT'])
    def save(Annonce annonce) {
        def userIdLog = springSecurityService.getCurrentUserId().toString()
        def userinstance = User.findById(Integer.parseInt(userIdLog))
        def userrole = UserRole.findByUser(userinstance)

        if(userrole.role.getAuthority() == "ROLE_CLIENT" && userIdLog != params.author.id) {
            //error
            redirect(uri: "/client/annoncesList")
            return
        }

        File assets=new File(grailsApplication.config.illustrations.basePath)
        int idFile=assets.listFiles().length+1;
        request.getFiles("annonces[]").each { file ->
            if(file.getSize()!=0){
                file.transferTo(new File(grailsApplication.config.illustrations.basePath+"/"+idFile+".jpg"));
                annonce.addToIllustrations(new Illustration(filename : idFile+".jpg"))
                idFile++;
            }
        }



        if (annonce == null) {
            notFound()
            return
        }

        try {
            annonceService.save(annonce)
        } catch (ValidationException e) {
            respond annonce.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'annonce.label', default: 'Annonce'), annonce.id])
                if(params.redirectUrl) {
                    redirect(uri: params.redirectUrl)
                }else {
                    redirect annonce
                }
            }
            '*' { respond annonce, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond annonceService.get(id)
    }

    @Secured(['ROLE_ADMIN', 'ROLE_CLIENT'])
    def update() {
        Annonce annonce = Annonce.get(params.id)

        def userIdLog = springSecurityService.getCurrentUserId().toString()
        def userinstance = User.findById(Integer.parseInt(userIdLog))
        def userrole = UserRole.findByUser(userinstance)

        if(userrole.role.getAuthority() == "ROLE_CLIENT" && userIdLog != annonce.author.id) {
            //error
            redirect(uri: "/client/annoncesList")
            return
        }
        if (annonce == null) {
            notFound()
            return
        }
        try {

            ArrayList<Illustration> illustrationSuppr=new ArrayList<Illustration>();
            for (int i=0;i<annonce.illustrations.size();i++){
                Illustration illu=annonce.illustrations[i]
                if(params.get(illu.id.toString())){
                    illustrationSuppr.add(illu)
                }
            }
            for(int i=0;i<illustrationSuppr.size();i++){
                println illustrationSuppr.get(i).id
                annonce.removeFromIllustrations(illustrationSuppr.get(i))
                illustrationSuppr.get(i).delete()
            }
            File assets=new File(grailsApplication.config.illustrations.basePath)
            int idFile=assets.listFiles().length+1;
            for (Part file : request.getParts()) {
                if(file.getSize()!=0 && file.getName().equals("annonces[]")){
                    file.write(grailsApplication.config.illustrations.basePath+"/"+idFile+".jpg")
                    annonce.addToIllustrations(new Illustration(filename : idFile+".jpg"))
                    idFile++;
                }
            }
            annonce.price = Float.parseFloat(params.price)
            annonce.title = params.title
            annonce.description = params.description
            annonce.active = params.active
            if(params.active.equals("on")){
                annonce.active=Boolean.TRUE
            }
            if (params.active==null){
                annonce.active=Boolean.FALSE
            }
            annonceService.save(annonce)
        } catch (ValidationException e) {
            respond annonce.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'annonce.label', default: 'Annonce'), annonce.id])
                if(params.redirectUrl) {
                    redirect(uri: params.redirectUrl)
                }else {
                    redirect annonce
                }
            }
            '*'{ respond annonce, [status: OK] }
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_CLIENT'])
    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        annonceService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'annonce.label', default: 'Annonce'), id])
                if(params.redirectUrl) {
                    redirect(uri: params.redirectUrl)
                }else {
                    redirect action:"index", method:"GET"
                }
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'annonce.label', default: 'Annonce'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
