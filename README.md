# Mise en contexte
Un parc d'attractions veut numériser toutes ses données et services dans une base de données.
Chaque visiteur du parc d'attractions achète un billet à l’entrée et est ensuite inséré dans la
base de données ainsi que le moment de sa visite. Si celui-ci existe déjà alors on ne l’insère
pas à nouveau, mais on se contente d’enregistrer le moment de sa visite. Chacun est doté d’un
bracelet leur permettant l’accès à une attraction et le système enregistre la visite du client. Le
parc a déjà identifié les différentes entités et leurs associations requises pour la numérisation
de ses activités.


Ils sont arrivés à ce modèle relationnel :
Manège (nom, hauteur_minimale, niveau_membre)
Visiteur (id, courriel, prenom, nom, hauteur, niveau_membre) *
VisiteManège (#nom_manege, #id_visiteur, date)
VisiteVisiteur (#id_visiteur, date)
InspectionManege (#no_employe, date, #nom_manege)
Employe (no_employe, nom, salaire)

On assume que la hauteur est remesurée à chaque visite lors de l’achat du billet
Sachant que :
Le champ courriel est unique pour chaque visiteurLe niveau de membre est soit 0, 1 ou 2.
0 : Régulier
1 : VIP
2 : Méga VIP



# Travail demandé
Exécuter le script "Création des tables.sql" disponible dans les fichiers joints.

Prenez bien le temps d’analyser les données insérées ainsi que des relations entre les tables afin de vous aider pour la suite.
Écrivez ensuite les requêtes SQL permettant de :
1. Donner le nom de tous les manèges accessibles uniquement aux visiteurs Méga VIP.
2. Donner tous les manèges auxquels Salim a accès selon son niveau de membre et sa taille.
3. Donner la liste des visiteurs (leurs noms et prénoms) pouvant accéder aux "Montagnes Russes" selon leur taille et leur niveau de membre.
4. Donner le nombre total de visites de visiteurs ayant eu lieu entre le 1er février 2024 et le 28 février 2024.
5. Donner un tableau contenant, pour chaque visiteur (leurs noms), le nombre de manèges différents qu’il a visités.
6. Donner tous les manèges n’ayant pas été inspectés aujourd’hui (la date au moment de l’exécution).
7. Donner le nom de l’employé ayant effectué le plus grand nombre d’inspections.
8. Donner le nom, prénom et le nom du manège le plus fréquenté de chaque visiteur. Le visiteur doit avoir embarqué au moins 3 fois dans son attraction préférée pour qu’on affiche son manège préféré.
9. Donner la taille moyenne des visiteurs du parc le 25 février 2024.
10. Créer une procédure stockée qui affiche la liste des visiteurs ayant utilisé un certain manège (en utilisant son nom). Appeler cette procédure 3 fois avec différents paramètres.
11. Créer une fonction prenant en argument le nom d’un manège et qui retourne le nombre total de visites de ce manège. Appeler cette fonction 3 fois avec différents paramètres.
12. Créer une procédure utilisant un curseur qui parcourt tous les manèges et affiche, pour chacun, le nombre total de visites enregistrées pour ce manège. Le curseur devra parcourir les manèges un par un et afficher leur nom ainsi que leur nombre de visites.
13. Créer un déclencheur (trigger) qui empêche la suppression d’un manège s’il a déjà été visité au moins une fois. Tester ce déclencheur à l'aide d'une requête DELETE.
Attention! Soyez sûr que votre script puisse s’exécuter autant de fois que l’on veut! Donc y apporter les changements nécessaires (ex : CREATE OR ALTER PROCEDURE, CREATE OR ALTER FUNCTION, etc.)

