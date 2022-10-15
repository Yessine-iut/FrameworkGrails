package com.mbds.grails

import grails.converters.JSON
import grails.converters.XML
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.http.HttpMethod
import com.mbds.grails.UserRole

@Secured(['ROLE_ADMIN','ROLE_MODERATOR','ROLE_USER'])

class ApiController {

    /**
     * Singleton
     * Gestion des points d'entrée : GET / PUT / PATCH / DELETE
     */
    def annonce() {
        String typeDonnees=request.getContentType();
        // On vérifie qu'un ID ait bien été fourni
        if (!params.id)
            return response.status = 400
        // On vérifie que l'id corresponde bien à une instance existante
        def annonceInstance = Annonce.get(params.id)
        if (!annonceInstance)
            return response.status = 404

        switch (request.getMethod()) {
            case "GET":
                //Test OK
                renderThis(request.getHeader("Accept"), annonceInstance)
                break;
            case "PUT":
                switch(true){
                    case typeDonnees=='application/xml' || typeDonnees=='text/xml':
                        //TEST OK
                        if(!(request.getXML().getAt("title") == "") && !(request.getXML().getAt("price") == "") && !(request.getXML().getAt("description") == "")
                                && !(request.getXML().getAt("active") == "") && !(request.getXML().getAt("author") == ""))
                        {
                            if(!User.get(Integer.parseInt(request.getXML().getAt("author").toString()))){
                                auteurIntrouvable();
                                return;
                            }
                            annonceInstance.title=request.getXML().title
                            try {
                                String pri=request.getXML().price;
                                annonceInstance.price=Float.parseFloat(pri);
                            } catch (final NumberFormatException e) {
                                prixNotFloat()
                                return;
                            }
                            annonceInstance.description=request.getXML().description
                            annonceInstance.active=new Boolean(request.getXML().getAt("active").toString())
                            annonceInstance.author=User.get(Integer.parseInt(request.getXML().getAt("author").toString()))
                            annonceInstance.save(flush: true, failOnError: true)
                            return response.status = 200
                        }else{
                            parametresManquant()
                            return response.status = 400
                        }
                        break;
                    case typeDonnees=='application/json' || typeDonnees=='text/json':
                        //Tester OK
                        if(request.JSON.title && request.JSON.description && request.JSON.price && request.JSON.active &&
                                request.JSON.author){
                            if(!User.get(request.JSON.author)){
                                auteurIntrouvable();
                                return response.status = 400
                            }
                            try {
                                String pri=request.JSON.price;
                                annonceInstance.price=Float.parseFloat(pri);
                            } catch (final NumberFormatException e) {
                                render "Le prix n'est pas un float."
                                return response.status = 400
                            }
                            annonceInstance.title=request.JSON.title
                            annonceInstance.description=request.JSON.description
                            Boolean b=new Boolean(request.JSON.active)
                            annonceInstance.active=b
                            annonceInstance.author=User.get(request.JSON.author)
                            annonceInstance.save(flush: true, failOnError: true)
                            return response.status = 200
                        }else{
                            parametresManquant()
                            return response.status = 400
                        }
                        break;
                }
                return response.status = 200
                break;
            case "PATCH":
                switch(true){
                    case typeDonnees=='application/xml' || typeDonnees=='text/xml':
                        //Tester OK
                        if(!(request.getXML().getAt("title") == "")){
                            annonceInstance.title=request.getXML().title
                        }
                        if(!(request.getXML().getAt("price") == "")){
                            try {
                                String pri=request.getXML().price;
                                annonceInstance.price=Float.parseFloat(pri);
                            } catch (final NumberFormatException e) {
                                prixNotFloat()
                            }
                        }
                        if(!(request.getXML().getAt("description") == "")){
                            annonceInstance.description=request.getXML().description
                        }
                        if(!(request.getXML().getAt("active") == ""))
                            annonceInstance.active=new Boolean(request.getXML().active)
                        if(!(request.getXML().getAt("author") == "")){
                         if(!User.get(Integer.parseInt(request.getXML().getAt("author").toString()))){
                             auteurIntrouvable();
                         }else annonceInstance.author=User.get(Integer.parseInt(request.getXML().getAt("author").toString()))

                        }
                        annonceInstance.save(flush: true, failOnError: true)
                        return response.status = 200
                        break;
                    case typeDonnees=='application/json' || typeDonnees=='text/json':
                        //Tester OK
                        if(request.JSON.title){
                            annonceInstance.title=request.JSON.title
                        }
                        if(request.JSON.description){
                            annonceInstance.description=request.JSON.description
                        }
                        if(request.JSON.price){
                            try {
                                String pri=request.JSON.price;
                                annonceInstance.price=Float.parseFloat(pri);
                            } catch (final NumberFormatException e) {
                                prixNotFloat();
                                return;
                            }
                        }
                        if(request.JSON.active)
                            annonceInstance.active=new Boolean(request.JSON.active)
                        if(request.JSON.author){
                            if(!User.get(request.JSON.author)){
                                auteurIntrouvable();
                                return;
                            }else
                            annonceInstance.author=User.get(request.JSON.author)

                        }
                        if(!annonceInstance.save(flush: true, failOnError: true)){
                            nonSauvegarder();
                            return;
                        }
                        return response.status = 200
                        break;
                }
                return response.status = 200
                break;
            case "DELETE":
                annonceInstance.delete(flush:true)
                return response.status = 200
                break;
            default:
                return response.status = 405
                break;
        }
        return response.status = 406
    }

    /**
     * Collection
     * POST / GET
     */
    def annonces() {
        def annoncesList = Annonce.list()
        String typeDonnees=request.getContentType();
        switch (request.getMethod()) {
            case "GET":
                renderThis(request.getHeader("Accept"), annoncesList)
                break;
            case "POST":
                switch(true) {
                    case typeDonnees=='application/json' || typeDonnees=='text/json':
                        //Tester OK
                        def newAnnonce=new Annonce();

                        if(request.JSON.title && request.JSON.description && request.JSON.price && request.JSON.author && request.JSON.active){
                            newAnnonce.active=new Boolean(request.JSON.active);
                            if(!User.get(request.JSON.author)){
                                auteurIntrouvable();
                                return;
                            }
                            newAnnonce.title=request.JSON.title
                            newAnnonce.description=request.JSON.description
                            try {
                                Float pri=Float.parseFloat(request.JSON.price)
                                newAnnonce.price=pri
                            } catch (final NumberFormatException e) {
                                prixNotFloat()
                                return;
                            }
                            newAnnonce.author=User.get(request.JSON.author)
                            if(request.JSON.illustration){
                                int i=0
                                File assets=new File(grailsApplication.config.illustrations.basePath)
                                int idFile=assets.listFiles().length+1;
                                while(request.JSON.illustration[i]){
                                    String encoded = request.JSON.illustration[i] // You complete String
                                    encoded.replaceAll("\r", "")
                                    encoded.replaceAll("\n", "")
                                    byte[] decoded = encoded.decodeBase64()
                                    new File(grailsApplication.config.illustrations.basePath+"/"+idFile+".jpg").withOutputStream {
                                        it.write(decoded);
                                    }
                                    i++;
                                    newAnnonce.addToIllustrations(new Illustration(filename : idFile+".jpg"))
                                    idFile++;
                                }
                            }
                            if(!newAnnonce.save(flush: true, failOnError: true)){
                                nonSauvegarder();
                                return;
                            }
                        }else{
                            parametresManquant()
                            return;
                        }

                        return response.status = 200
                        break;
                    case typeDonnees=='application/xml' || typeDonnees=='text/xml':
                        //Tester OK
                        def newAnnonce=new Annonce();
                        if(!(request.getXML().getAt("title") == "") && !(request.getXML().getAt("active") == "") && !(request.getXML().getAt("price") == "") && !(request.getXML().getAt("description") == "")
                                && !(request.getXML().getAt("author") == "") && !(request.getXML().getAt("author") == "")){
                            if(!User.get(Integer.parseInt(request.getXML().getAt("author").toString()))){
                                auteurIntrouvable();
                            }
                            newAnnonce.active=new Boolean(request.getXML().getAt("active").toString())

                            newAnnonce.title=request.XML.title
                            newAnnonce.description=request.XML.description
                            String pri=request.getXML().price;
                            newAnnonce.price=Float.parseFloat(pri);
                            newAnnonce.author=User.get(Integer.parseInt(request.getXML().getAt("author").toString()))
                            if(!(request.getXML().getAt("illustration") == "")){
                                File assets=new File(grailsApplication.config.illustrations.basePath)
                                int idFile=assets.listFiles().length+1;
                                String []illustrations=request.getXML().getAt("illustration").toString().split(",")
                                for(int i=0;i<illustrations.length;i++){
                                    String encoded = illustrations[i] // You complete String
                                    encoded.replaceAll("\r", "")
                                    encoded.replaceAll("\n", "")
                                    byte[] decoded = encoded.decodeBase64()
                                    new File(grailsApplication.config.illustrations.basePath+"/"+idFile+".jpg").withOutputStream {
                                        it.write(decoded);
                                    }
                                    newAnnonce.addToIllustrations(new Illustration(filename : idFile+".jpg"))
                                    idFile++;
                                }
                            }
                            if(!newAnnonce.save(flush: true, failOnError: true)){
                                nonSauvegarder();
                                return;
                            }

                        }else {
                            parametresManquant()
                            return;
                        }

                        return response.status = 200
                        break;
                }
                break;
            default:
                return response.status = 405
                break;
        }
        return response.status = 406
    }

    def user() {
        String typeDonnees=request.getContentType();
        if (!params.id)
            return response.status = 400
        def userInstance = User.get(params.id)
        if (!userInstance)
            return response.status = 404

        switch (request.getMethod()) {
            case "GET":
                renderThis(request.getHeader("Accept"), userInstance)
                break;
            case "PUT":
                switch(true) {
                    case typeDonnees=='application/xml' || typeDonnees=='text/xml':
                        if (!(request.getXML().getAt("username") == "") && !(request.getXML().getAt("password") == "")
                                && !(request.getXML().getAt("role") == "")) {
                            if(User.findByUsername(request.XML.username)){
                                usernameExistant()
                                return;
                            }
                            userInstance.username = request.getXML().username
                            userInstance.password = request.getXML().password
                            ArrayList<Role> roles= UserRole.findAllByUser(userInstance)
                            roles*.delete(flush:true)
                            def role =  Role.findByAuthority(request.XML.role)
                            UserRole.create(userInstance, role, true)

                            if(!role){
                                roleIntrouvable()
                                return;
                            }
                            if(!userInstance.save(flush: true, failOnError: true)){
                                nonSauvegarder()
                                return;
                            }
                            return response.status = 200
                        } else {
                            parametresManquant()
                        }
                        break;
                    case typeDonnees=='application/json' || typeDonnees=='text/json':
                        //Tester OK
                        //Vérifier que le username n'existe pas déjà (unique en BD)
                        if (request.JSON.username && request.JSON.password && request.JSON.role) {
                            if(User.findByUsername(request.JSON.username)){
                                usernameExistant()
                                return;
                            }

                            def role =  Role.findByAuthority(request.JSON.role)
                            if(!role){
                                roleIntrouvable()
                                return;
                            }
                            userInstance.username = request.JSON.username
                            userInstance.password = request.JSON.password
                            if(!userInstance.save(flush: true, failOnError: true)){
                                nonSauvegarder();
                            }
                            ArrayList<Role> roles= UserRole.findAllByUser(userInstance)
                            roles*.delete(flush:true)
                            UserRole.create(userInstance, role, true)
                            return response.status = 200
                        } else parametresManquant();
                        break;
                }
                break;
            case "PATCH":
                switch(true) {
                    case typeDonnees=='application/xml' || typeDonnees=='text/xml':
                        //Tester OK
                        if (!(request.getXML().getAt("username") == "")){
                            if(!User.findByUsername(request.XML.username)){
                                userInstance.username=request.XML.username
                            }else {
                                usernameExistant()
                                return;
                            }
                        }
                        if(!(request.getXML().getAt("password") == "")){
                            userInstance.password=request.XML.password
                        }
                        if(!(request.getXML().getAt("role") == "")){
                            def role =  Role.findByAuthority(request.XML.role)
                            if(!role){
                                roleIntrouvable()
                                return;
                            }
                            UserRole.create(userInstance, role, true)
                            ArrayList<Role> roles= UserRole.findAllByUser(userInstance)
                            roles*.delete(flush:true)
                            UserRole.create(userInstance, role, true)
                        }
                        if(!userInstance.save(flush: true, failOnError: true)){
                            nonSauvegarder()
                            return;
                        }
                        return response.status = 200
                        break;
                    case typeDonnees=='application/json' || typeDonnees=='text/json':
                        //Tester OK
                        if(request.JSON.username){
                            if(User.findByUsername(request.JSON.username)){
                                usernameExistant()
                                return;
                            }
                            userInstance.username=request.JSON.username
                        }
                        if(request.JSON.password){
                            userInstance.password=request.JSON.password
                        }
                        if(request.JSON.role){
                            def role =  Role.findByAuthority(request.JSON.role)
                            if(!role){
                                roleIntrouvable()
                                return;
                            }
                            ArrayList<Role> roles= UserRole.findAllByUser(userInstance)
                            roles*.delete(flush:true)
                            UserRole.create(userInstance, role, true)
                        }
                        if(!userInstance.save(flush: true, failOnError: true)){
                            nonSauvegarder();
                            return;
                        }
                        return response.status = 200
                        break;
                }
                break;
            case "DELETE":
                //Tester OK
                ArrayList<Annonce> a= Annonce.findAllByAuthor(userInstance)
                a*.delete(flush:true)
                ArrayList<Role> roles= UserRole.findAllByUser(userInstance)
                roles*.delete(flush:true)
                userInstance.delete(flush:true)
                return response.status = 200
                break;
            default:
                return response.status = 405
                break;
        }
        return response.status = 406
    }


    def users() {
        def usersList = User.list()
        String typeDonnees=request.getContentType();
        switch (request.getMethod()) {
            case "GET":
                renderThis(request.getHeader("Accept"), usersList)
                break;
            case "POST":
                switch(true) {
                    case typeDonnees=='application/xml' || typeDonnees=='text/xml':
                        //Tester OK
                        def newUser=new User();
                        if (!(request.getXML().getAt("username") == "") && !(request.getXML().getAt("password") == "")
                        && !(request.getXML().getAt("role") == "")){
                            if(User.findByUsername(request.XML.username)){
                                usernameExistant()
                                return;
                            }

                                def role =  Role.findByAuthority(request.XML.role)
                                if(!role){
                                    roleIntrouvable()
                                    return;
                                }

                                newUser.username=request.XML.username
                                newUser.password=request.XML.password
                                newUser.save(flush: true, failOnError: true)
                                UserRole.create(newUser, role, true)
                            return response.status = 200

                        }else {
                            parametresManquant()
                            return;
                        }
                        break;
                    case typeDonnees=='application/json' || typeDonnees=='text/json':
                        //Tester OK
                        if(request.JSON.username && request.JSON.password && request.JSON.role){

                            if(User.findByUsername(request.JSON.username)){
                                usernameExistant()
                                return;
                            }
                            def role =  Role.findByAuthority(request.JSON.role)
                            if(!role){
                                roleIntrouvable()
                                return;
                            }
                            def newUser = new User(username: request.JSON.username,password: request.JSON.password).save()
                            UserRole.create(newUser, role, true)
                            return response.status = 200
                        }else {
                            parametresManquant()
                            return;
                        }
                        break;
                }
                break;
            default:
                return response.status = 405
                break;
        }
        return response.status = 406
    }
    def auteurIntrouvable(){
        render ([status:400,text:"L'auteur est introuvable, veuillez saisir un identifiant valide."]) as JSON

    }
    def parametresManquant(){
        render ([status:400,text:"Les paramètres ne sont pas tous renseignés."]) as JSON
    }
    def usernameExistant(){
       render ([status:400,message : "L'username est déjà existant."]) as JSON
    }
    def roleIntrouvable(){
        render ([status:400,text:"Rôle introuvable, veuillez saisir un rôle qui existe."]) as JSON
    }
    def prixNotFloat(){
        render ([status:400,text:"Le prix n'est pas un float."]) as JSON
    }
    def nonSauvegarder(){
        render ([status:400,text:"Ca n'a pas été sauvegardé en base de données."]) as JSON
    }
    def renderThis(String acceptHeader, Object object) {
        switch (true) {
            case acceptHeader=='application/xml' || acceptHeader=='text/xml':
                render object as XML
                break;
            case acceptHeader=='application/json' || acceptHeader=='text/json' :
                render object as JSON
                break;
        }
    }
}