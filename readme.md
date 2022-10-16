# Présentation du projet

Ce projet consiste à creer et mettre en place une application e-commerce
simplifiée à l'aide du framework
Grails.
<br><br>
L'objectif est la prise en charge de rôle utilisateur, de gestion d'acces
et une utilisation optimale des
ressources, controleur et services Grails.
<br><br>
Une segmentation d'interfaces utilisateurs permet d'utiliser une version cliente comme LeBonCoin
et un Dashboard d'administration.

# Installation

```bash
  git clone https://github.com/Master-2-MIAGE-MBDS/grails-lecoincoin-gograils.git
  cd grails-lecoincoin-gograils
  grails run-app
```

# Versions
Version de Grails : 3.3.8

Java : OpenJDK 1.8

Git : version non pertinente

# How it works ?

## Backend

### Fonctionnalités présentes

- Utilisation de SpringSecurity pour la gestion des rôles et des accés
### API REST

## Frontends

### Fonctionnalités présentes

- S'identifier / Se deconnecter
- Redirection dynamique à la connexion (User client -> frontend client)
- 
### Dashboard Admin
- Seul les moderateurs et admin ont acces
- Toutes les opérations du CRUD sont disponibles sur
  - User
  - Annonces

### Lecoincoin Client

# Postman

# Heroku

# Critères de notation
- **Y a t'il un readme utile et complet ?**
- Est ce que le code métier est correct, respect des bonnes pratiques, code propre ?
- Y a t'il des fonctionnalités "bonus" ?
### Backend
- Est ce que les interfaces produits ont fait l'objet d'un soin particulier ?
- Est ce que la segmentation Controller / Service / Modèle a été faite correctement
- **Est ce que les fonctionnalités minimales sont présentes**
### API REST
- **Est ce que tous les points d'entrée sont bien gérés ?**
- Est ce que les codes d'état HTTP retournés sont bien pertinents ?
- **Est ce que la collection Postman est bien présente ?**
