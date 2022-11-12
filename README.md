# APAL

## Description du projet

- Le projet APAL est une application permettant de suivre les événements Esportifs des équipes de la structure KCorp à l’aide d’un Agenda mis-à-jour par un ou plusieurs admin(s).
- Les admins peuvent ajouter ou modifier un événement par jour sur le calendrier de l’application avec précisé : Le nom de l’évènement, la description, la chaîne Twitch de diffusion, le jeu, le lien du live (si celui-ci existe)

## Déployer l'application en local

- Pour déployer l’application localement commencez par cloner le dépôt Github avec la commande :

>`clone https://github.com/Danalias/APAL`

- Une fois le dépôt cloné, effectuez la commande : `flutter pub get` afin de récupérer les dépendances nécessaires au projet
- Après cela, selon votre plateforme effectuez l’une des commandes suivantes :
  - `Flutter build apk` (Android) et mettre le fichier .apk créé dans build/android/ sur un smartphone android pour l’installer
  - `Flutter build  ipa –export-method ad-hoc` (IOS) et installer le fichier créé dans build/ios/ sur votre Iphone
  - `Flutter build web –web-renderer html` (web) cela va créer un dossier build/web/ dans lequel se trouve l’application. Pour la lancer sur web vous devez ouvrir un terminal dans le dossier et héberger l’application en local avec Python ou un serveur node par exemple (`python -m http.server 8000`) et vous rendre à l’adresse localhost:8000 pour y retrouver l'application

Architecture :
Les widgets de notre projet se trouvent dans Lib.
Tous réparties dans des sous dossiers qui portent le nom de la feature :

    `|--Lib
        '|--<feature1>
            --<feature1>.dart
            ...
         |--<Feature2>
            ...
         --main.dart

- **Adaptive_bar** comprend les navbars qui seront afficher en fonction de la taille de l’écran et qui seront présent sur les pages en dehors de l’identification. Chaque fichier porte le nom de l’appareille sur lequel il sera affiché.
- **Authentication** comprend tous les widgets liés à firebase et notamment à l’inscription, la connexion, et la réinitialisation du mot de passe. Chacun est séparé dans un fichier qui porte le nom du widget en question. On y trouve également le fichier de configuration de firebase.
- **Calendar** comprend tout ce qui est lié à notre feature principale. Toutes les fonctionnalités du calendrier se retrouvent séparés dans différents fichiers nommés après elles. On y trouve également le dossier adaptive_view qui comprend les trois différentes vues qui seront affichés toujours en fonction de la taille de l’écran, chacune répartie dans un fichier différent.
- **Profile** contient le widget en rapport avec la page profile. Lui aussi comprend un dossier adaptive_view dans lequel on peut trouver les trois vues différentes possibles en fonction de la taille de l’écran.
- Le **main.dart** comprend tout ce qui se passe au lancement de l’application (eg. Animation, Redirection)

## Packages externes utilisés

- Les packages externes utilisés sont :

  - **Cloud_firestore** = Pour le stockage des données du calendrier et pour récupérer le type de compte d’un utilisateur
  - **Firebase_auth** = Pour l’authentification et la gestion des utilisateurs
  - **Firebase_core** = Package cœur de Firebase (nécessaire pour les autres packages Firebase)
  - **Firebase_crashlytics** = Pour analyser en cas de crash mobile
  - **Firebase_storage** = Pour le stockage des photos de profil des utilisateurs
  - **Image_picker** = Pour récupérer les images sur mobile et web
  - **Intl** = Pour le formattage de certains textes
  - **Provider** = Pour la gestion des states
  - **Table_calendar** = Pour le calendrier
