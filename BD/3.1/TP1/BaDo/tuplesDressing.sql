-- tuples de la base dressing

--Insertion UTILISATEUR (via l'appli java ensuite)
INSERT INTO UTILISATEUR(nom, prenom, age, taille, couleurCheveux, couleurPreferee, forme_u) VALUES ('Malandain', 'Nicolas', 43, 180, 'Chatain', 'Rouge', 'A');
INSERT INTO UTILISATEUR(nom, prenom, age, taille, couleurCheveux, couleurPreferee, forme_u) VALUES ('Del Mondo', 'Géraldine', 35, 166, 'Chatain', 'Vert', 'H');

-- Insertion DRESSING (via l'appli java ensuite)
INSERT INTO DRESSING VALUES (1,1);
INSERT INTO DRESSING VALUES (2,2);


--Insertion sac
 
INSERT INTO SAC (iddressing, couleur, typeS) VALUES (1,'Bleu','Sac de sport');
INSERT INTO SAC (iddressing, couleur, typeS) VALUES (1,'Rouge','Sac à dos');
INSERT INTO SAC (iddressing, couleur, typeS) VALUES (1,'Rouge','Pochette');
INSERT INTO SAC (iddressing, couleur, typeS) VALUES (2,'Vert','Sac de sport');
INSERT INTO SAC (iddressing, couleur, typeS) VALUES (2,'Bleu','Sac à main');

--Insertion chaussure

INSERT INTO CHAUSSURE (iddressing,couleur,typeC) VALUES (1,'Marron','Bottes');

INSERT INTO CHAUSSURE (iddressing,couleur,typeC) VALUES (1,'Bleu','Baskets');

INSERT INTO CHAUSSURE (iddressing,couleur,typeC) VALUES (2,'Vert','Baskets');

INSERT INTO CHAUSSURE (iddressing,couleur,typeC) VALUES (2,'Blanc','Ballerines');

INSERT INTO CHAUSSURE (iddressing,couleur,typeC) VALUES (2,'Noir','Escarpins');

--Insertion MATIERE_SAISON

INSERT INTO MATIERE_SAISON VALUES ('Coton', 'Toutes');

INSERT INTO MATIERE_SAISON VALUES ('Jean', 'Toutes');

INSERT INTO MATIERE_SAISON VALUES ('Cuir', 'Automne/Hiver');

INSERT INTO MATIERE_SAISON VALUES ('Dentelle', 'Toutes' );

INSERT INTO MATIERE_SAISON VALUES ('Paillete', 'Toutes');

INSERT INTO MATIERE_SAISON VALUES ('Satin', 'Toutes');

INSERT INTO MATIERE_SAISON VALUES ('Laine', 'Automne/Hiver');

INSERT INTO MATIERE_SAISON VALUES ('Velours', 'Automne/Hiver');

INSERT INTO MATIERE_SAISON VALUES ('Lin', 'Printemps/Ete');


--Insertion haut (le niveau ne sera plus à renseigner quand le trigger aura été mis en place)

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (1, 1, 'Rouge','Laine',false,'Pull','Large');

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (1,1,'Vert','Laine',false,'Pull','Cintree');

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (2, 1, 'Noir','Laine',false,'Pull','Droite');

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (2, 2, 'Blanc','Coton',false,'Manteau','Cintree');

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (1, 2, 'Marron','Laine',false,'Manteau','Large');

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (1, 2, 'Bleu','Coton',false,'Veste','Cintree');

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (2, 2, 'Bleu','Jean',false,'Veste','Cintree');

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (2, 1, 'Blanc','Coton',false,'Chemise','Cintree');

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (1,1,'Noir','Coton',false,'Chemise','Cintree');

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (1,1,'Rouge','Coton',false,'Tee-shirt','Droite');

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (2,1,'Jaune','Coton',false,'Tee-shirt','Cintree');

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (1,1,'Vert','Coton',false,'Tee-shirt','Large');

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (1,1,'Noir','Coton',false,'Tee-shirt','Droite');

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (2,1,'Fushia','Coton',false,'Tee-shirt','Droite');

INSERT INTO HAUT (iddressing, niveau, couleur, matiere,lavage,typeh, coupeh) VALUES (1,1,'Blanc','Coton',false,'Tee-shirt','Cintree');

--Insertion pantalon

INSERT INTO BAS (iddressing, niveau, couleur, matiere,lavage,typeb, coupeb) VALUES (1,1, 'Bleu','Jean',false,'Pantalon','Slim');

INSERT INTO BAS (iddressing, niveau, couleur, matiere,lavage,typeb, coupeb) VALUES (1,1, 'Vert', 'Jean',false,'Pantalon','Droite');

INSERT INTO BAS (iddressing, niveau, couleur, matiere,lavage,typeb, coupeb) VALUES (2,1, 'Noir', 'Jean',false,'Pantalon','Slim');

INSERT INTO BAS (iddressing, niveau, couleur, matiere,lavage,typeb, coupeb) VALUES (1,1, 'Rouge', 'Coton',false,'Jogging','Droite');

INSERT INTO BAS (iddressing, niveau, couleur, matiere,lavage,typeb, coupeb) VALUES (2,1, 'Jaune', 'Coton',false,'Jogging','Droite');

INSERT INTO BAS (iddressing, niveau, couleur, matiere,lavage, typeb, coupeb) VALUES (1,1, 'Blanc','Lin',false,'Short','Droite');

INSERT INTO BAS (iddressing, niveau, couleur, matiere,lavage, typeb, coupeb) VALUES (2,1, 'Marron','Lin',false,'Pantalon','Evasee');

--Insertion Autre (le niveau ne sera plus à renseigner quand le trigger aura été mis en place)

INSERT INTO AUTRE (iddressing, niveau, couleur, matiere, lavage,typea, coupea) VALUES (2, 1, 'Blanc','Coton',false,'Robe','Court');

INSERT INTO AUTRE (iddressing, niveau, couleur, matiere,lavage, typea, coupea) VALUES (2, 1, 'Noir','Laine',false,'Robe','Court');

INSERT INTO AUTRE (iddressing, niveau, couleur, matiere, lavage,typea, coupea) VALUES (2,1, 'Vert','Satin',false,'Robe','Longue');

INSERT INTO AUTRE (iddressing, niveau, couleur, matiere,lavage,typea, coupea) VALUES (2,1, 'Jaune','Coton',false,'Salopette','Longue');

INSERT INTO AUTRE (iddressing, niveau, couleur, matiere,lavage,typea, coupea) VALUES (1,1, 'Bleu','Coton',false,'Salopette','Longue');

INSERT INTO AUTRE (iddressing, niveau, couleur, matiere,lavage,typea, coupea) VALUES (1,1, 'Marron','Velours',false,'Salopette','Longue');

--Insertion FORME_VETEMENT (sera remplie automatiquement avec un trigger dans le TP 2)






