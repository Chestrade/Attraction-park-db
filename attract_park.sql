-- Création des tables pour le parc d'attraction
-- Éxécuter ce fichier et répondez aux questions du TP

-- Réinitialisation de la DB
-- À exécuter au début

use master;
go
DROP DATABASE IF EXISTS ParcAttraction;
go
CREATE DATABASE ParcAttraction;
GO

-- Utilisation de la base de données créée
USE ParcAttraction;
GO

DROP TABLE IF EXISTS VisiteManege;
DROP TABLE IF EXISTS InspectionManege;
DROP TABLE IF EXISTS VisiteVisiteur;
DROP TABLE IF EXISTS Visiteur;
DROP TABLE IF EXISTS Employe;
DROP TABLE IF EXISTS Manege;



-- Création de la table Manège
CREATE TABLE Manege (
    nom VARCHAR(50) PRIMARY KEY,
    hauteur_minimale INT,
    niveau_membre INT CHECK (niveau_membre IN (0, 1, 2))
);
GO

-- Création de la table Visiteur
CREATE TABLE Visiteur (
    id INT PRIMARY KEY,
    courriel VARCHAR(100) UNIQUE,
    prenom VARCHAR(50),
    nom VARCHAR(50),
    hauteur INT,
    niveau_membre INT CHECK (niveau_membre IN (0, 1, 2))
);
GO

-- Création de la table Employe
CREATE TABLE Employe (
    no_employe INT PRIMARY KEY,
    nom VARCHAR(50),
    salaire DECIMAL(10, 2)
);
GO

-- Création de la table VisiteManège
CREATE TABLE VisiteManege (
    nom_manege VARCHAR(50),
    id_visiteur INT,
    date DATE,
    FOREIGN KEY (nom_manege) REFERENCES Manege(nom),
    FOREIGN KEY (id_visiteur) REFERENCES Visiteur(id),
    PRIMARY KEY (nom_manege, id_visiteur, date)
);
GO

-- Création de la table VisiteVisiteur
CREATE TABLE VisiteVisiteur (
    id_visiteur INT,
    date DATE,
    FOREIGN KEY (id_visiteur) REFERENCES Visiteur(id),
    PRIMARY KEY (id_visiteur, date)
);
GO

-- Création de la table InspectionManege
CREATE TABLE InspectionManege (
    no_employe INT,
    date DATE,
    nom_manege VARCHAR(50),
    FOREIGN KEY (no_employe) REFERENCES Employe(no_employe),
    FOREIGN KEY (nom_manege) REFERENCES Manege(nom),
    PRIMARY KEY (no_employe, date, nom_manege)
);
GO

-- Insertion des données
INSERT INTO Manege (nom, hauteur_minimale, niveau_membre)
VALUES 
    ('Montagnes Russes', 140, 1),
    ('Glissade Atlantique', 105, 2),
    ('Manège Volcanique', 150, 2),
    ('Manège de l''Espace', 110, 1),
    ('Baie des Pirates', 100, 0);

INSERT INTO Employe (no_employe, nom, salaire)
VALUES 
    (101, 'Lamine Labile', 2500),
    (102, 'Marcelle Lefebvre', 2800),
    (103, 'Andreas Alcaraz', 3000),
    (104, 'Sophie Côté', 2600),
    (105, 'Fatima Benjelloun', 2700);

INSERT INTO Visiteur (id, courriel, prenom, nom, hauteur, niveau_membre)
VALUES 
    (201, 'visiteur1@example.com', 'Salim', 'Bouchard', 110, 1),
    (202, 'visiteur2@example.com', 'Émilie', 'Gagnon', 120, 0),
    (203, 'visiteur3@example.com', 'Maxime', 'Fortin', 150, 2),
    (204, 'visiteur4@example.com', 'Mélissa', 'Lavoie', 130, 1),
    (205, 'visiteur5@example.com', 'Philippe', 'Bergeron', 140, 0);

INSERT INTO VisiteManege (nom_manege, id_visiteur, date)
VALUES 
    ('Montagnes Russes', 201, '2024-01-20'),
	('Glissade Atlantique', 201, '2024-02-10'),
	('Montagnes Russes', 201, '2024-02-10'),
	('Montagnes Russes', 201, '2024-02-15'),
    ('Glissade Atlantique', 202, '2024-01-05'),
	('Manège Volcanique', 202, '2024-01-05'),
	('Glissade Atlantique', 202, '2024-02-19'),
	('Glissade Atlantique', 202, '2024-02-25'),
    ('Manège Volcanique', 203, '2024-03-01'),
    ('Manège de l''Espace', 204, '2024-03-06'),
    ('Baie des Pirates', 205, '2024-02-25'),
	('Montagnes Russes', 205, '2024-02-25'),
	('Glissade Atlantique', 205, '2024-03-25');


INSERT INTO VisiteVisiteur (id_visiteur, date)
VALUES 
    (201, '2024-01-20'),
	(201, '2024-02-10'),
	(201, '2024-02-25'),
    (202, '2024-01-05'),
	(202, '2024-02-19'),
	(202, '2024-02-25'),
    (203, '2023-12-30'),
    (204, '2024-03-06'),
	(204, '2023-12-25'),
    (205, '2024-02-25');

INSERT INTO InspectionManege (no_employe, date, nom_manege)
VALUES 
	(101, CONVERT(DATE, GETDATE()), 'Montagnes Russes'),
	(101, '2024-02-10', 'Montagnes Russes'),
	(104, '2024-01-10', 'Montagnes Russes'),
    (103, '2024-02-10', 'Montagnes Russes'),
    (102, '2023-12-20', 'Glissade Atlantique'),
    (103, '2023-12-15', 'Manège Volcanique'),
    (104, '2023-12-10', 'Manège de l''Espace'),
    (105, CONVERT(DATE, GETDATE()), 'Baie des Pirates'),
	(105, '2023-12-12', 'Manège de l''Espace');


-- 1. Donner le nom de tous les manèges accessibles uniquement aux visiteurs Méga VIP.

SELECT nom 
FROM Manege 
WHERE niveau_membre = 2;

-- 2. Donner tous les manèges auxquels Salim a accès selon son niveau de membre et sa taille.
SELECT Manege.*
FROM Manege
INNER JOIN Visiteur
ON Visiteur.hauteur >= Manege.hauteur_minimale
AND Visiteur.niveau_membre >= Manege.niveau_membre
WHERE Visiteur.id=201;

-- 3. Donner la liste des visiteurs (leurs noms et prénoms) pouvant accéder aux "Montagnes Russes" selon leur taille et leur niveau de membre.
SELECT Visiteur.Nom, Visiteur.Prenom 
FROM Visiteur
INNER JOIN Manege 
ON Visiteur.hauteur >= Manege.hauteur_minimale
AND Visiteur.niveau_membre >= Manege.niveau_membre
WHERE Manege.nom='Montagnes Russes';


-- 4.Donner le nombre total de visites de visiteurs ayant eu lieu entre le 1er février 2024 et le 28 février 2024
SELECT COUNT (*) AS Nombre_total_visiteurs
FROM VisiteVisiteur v
WHERE v.date BETWEEN '2024-02-01' AND '2024-02-28';

--5 Donner un tableau contenant, pour chaque visiteur (leurs noms), le nombre de manèges différents qu’il a visités.
SELECT v.nom, COUNT(DISTINCT vm.nom_manege) AS nombre_manege_differents
FROM Visiteur v
LEFT JOIN VisiteManege vm
ON v.id = vm.id_visiteur
GROUP BY v.nom;

-- 6. Donner tous les manèges n’ayant pas été inspectés aujourd’hui (la date au moment de l’exécution).
SELECT nom_manege
FROM InspectionManege im
WHERE date < GETDATE()
GROUP BY nom_manege;

-- 7. Donner le nom de l’employé ayant effectué le plus grand nombre d’inspections.
SELECT TOP 1 nom 
FROM Employe e
LEFT JOIN InspectionManege im
ON e.no_employe = im.no_employe
GROUP BY e.nom
ORDER BY COUNT(*) DESC;

-- 8. Donner le nom, prénom et le nom du manège le plus fréquenté de chaque visiteur. 
--    Le visiteur doit avoir embarqué au moins 3 fois dans son attraction préférée pour qu’on affiche son manège préféré.
SELECT v.prenom, v.nom, vm.nom_manege AS manege_favori
FROM Visiteur v 
LEFT JOIN VisiteManege vm
ON v.id = vm.id_visiteur
GROUP BY v.id, v.prenom, v.nom, vm.nom_manege 
    HAVING COUNT(*) >= 3
    AND COUNT(*) = (SELECT TOP 1 COUNT(*)
    FROM VisiteManege vm2
    WHERE vm2.id_visiteur = v.id
    GROUP BY vm2.nom_manege
    ORDER BY COUNT(*) DESC
    );

-- 9. Donner la taille moyenne des visiteurs du parc le 25 février 2024.
SELECT AVG(v.hauteur) AS taille_moyenne
FROM Visiteur v 
LEFT JOIN VisiteVisiteur vv
ON v.id = vv.id_visiteur
WHERE vv.date = '2024-02-25';

-- 10. Créer une procédure stockée qui affiche la liste des visiteurs ayant utilisé un certain manège (en utilisant son nom). 
--     Appeler cette procédure 3 fois avec différents paramètres.

CREATE OR ALTER PROCEDURE visiteManegeParNom(
    @nomManege VARCHAR (50)
)
AS
BEGIN
  SELECT v.*
  FROM Visiteur v 
  LEFT JOIN VisiteManege vm
  ON v.id = vm.id_visiteur
  WHERE vm.nom_manege = @nomManege;  
END;
GO

EXECUTE visiteManegeParNom
@nomManege ='Glissade Atlantique';

EXECUTE visiteManegeParNom
@nomManege ='Montagnes Russes';

EXECUTE visiteManegeParNom
@nomManege ='Manège Volcanique';

-- 11. Créer une fonction prenant en argument le nom d’un manège et qui retourne le nombre total de visites de ce manège.
--     Appeler cette fonction 3 fois avec différents paramètres.

CREATE FUNCTION nbTotalVisiteurs(
    @nomManege VARCHAR(50)
)

RETURNS INT
AS
BEGIN
  DECLARE @total int;
  SELECT @total = COUNT(*)
  FROM VisiteManege
  WHERE nom_manege = @nomManege;
  RETURN @total;
END
GO

SELECT dbo.nbTotalVisiteurs('Glissade Atlantique') AS nb_total_visiteurs;
SELECT dbo.nbTotalVisiteurs('Montagnes Russes') AS nb_total_visiteurs;
SELECT dbo.nbTotalVisiteurs('Manège Volcanique') AS nb_total_visiteurs;

-- 12. Créer une procédure utilisant un curseur qui parcourt tous les manèges et affiche, pour chacun, le nombre total de visites enregistrées pour ce manège. 
--     Le curseur devra parcourir les manèges un par un et afficher leur nom ainsi que leur nombre de visites.
CREATE OR ALTER PROCEDURE visiteParManegeCurseur
AS
BEGIN
   DECLARE @nbVisiteurs INT;
   DECLARE @nomManege VARCHAR(50);

   DECLARE curseur_manege CURSOR FOR 
        SELECT nom FROM Manege

    OPEN curseur_manege;

    FETCH NEXT FROM curseur_manege INTO @nomManege;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @nbVisiteurs = COUNT(*)
        FROM VisiteManege
        WHERE nom_manege = @nomManege;

        PRINT @nomManege + ' : ' + CAST(@nbVisiteurs AS VARCHAR) + ' visite(s).';

        FETCH NEXT FROM curseur_manege INTO @nomManege;

    END
    CLOSE curseur_manege;
    DEALLOCATE curseur_manege;
END;
GO

EXECUTE visiteParManegeCurseur;

-- 13. Créer un déclencheur (trigger) qui empêche la suppression d’un manège s’il a déjà été visité au moins une fois. 
--     Tester ce déclencheur à l'aide d'une requête DELETE.

CREATE OR ALTER TRIGGER empeche_suppr_manege
ON Manege
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS(
        SELECT 1
        FROM VisiteManege vm
        INNER JOIN deleted d ON vm.nom_manege = d.nom
    )
    BEGIN
        PRINT 'Impossible de supprimer car le manege a été visité au moins 1 fois.';
        RETURN;
    END

    DELETE FROM Manege
    WHERE nom IN (SELECT nom FROM deleted);
END;
GO

DELETE FROM Manege WHERE nom ='Baie des Pirates';
