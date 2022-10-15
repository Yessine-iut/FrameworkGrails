package com.mbds.grails

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_MODERATOR'])
class UserController {

    UserService userService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond userService.list(params), model:[userCount: userService.count()]
    }

    def show(Long id) {
        respond userService.get(id)
    }
    @Secured(value=["hasRole('ROLE_ADMIN')"])
    def create() {
        respond new User(params)
    }
    @Secured(value=["hasRole('ROLE_ADMIN')"])
    def save(User user) {
        if (user == null) {
            notFound()
            return
        }

        try {
            def role= Role.findByAuthority(request.getParameter("role"))
            userService.save(user)
            UserRole.create(user, role, true)

        } catch (ValidationException e) {
            respond user.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*' { respond user, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond userService.get(id)
    }

    def update(User user) {
        if (user == null) {
            notFound()
            return
        }

        try {
            def role= Role.findByAuthority(request.getParameter("role"))
            ArrayList<Role> roles= UserRole.findAllByUser(user)
            roles*.delete(flush:true)
            UserRole.create(user, role, true)
            userService.save(user)
        } catch (ValidationException e) {
            respond user.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*'{ respond user, [status: OK] }
        }
    }
    @Secured(value=["hasRole('ROLE_ADMIN')"])
    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }
        def userInstance = User.get(id)
        ArrayList<Role> roles= UserRole.findAllByUser(userInstance)
        roles*.delete(flush:true)
        userService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
