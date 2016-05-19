--Creation des tables

CREATE TABLE UTILISATEUR (
	idPersonne SERIAL PRIMARY KEY,
	nom VARCHAR(20) NOT NULL,
	prenom VARCHAR(20) NOT NULL,
	age INTEGER NOT NULL,
	taille INTEGER NOT NULL,
	couleurCheveux VARCHAR(20) NOT NULL,
	couleurPreferee VARCHAR(20) NOT NULL,
	forme_u VARCHAR(5),
	CHECK (forme_u IN ('Huit', 'V', 'O', 'A', 'H', 'X')),
	CHECK (couleurCheveux IN ('Blond','Brun','Roux','Chatain')),
	CHECK (couleurPreferee IN ('Rouge', 'Vert', 'Jaune', 'Fushia', 'Bleu', 'Marron', 'Noir', 'Blanc'))
);

CREATE TABLE DRESSING (
       idDressing SERIAL PRIMARY KEY,
       idPersonne INTEGER REFERENCES UTILISATEUR
);


CREATE TABLE CONTENU (
       idContenu SERIAL PRIMARY KEY,
       idDressing INTEGER REFERENCES DRESSING ON DELETE CASCADE,
       couleur VARCHAR(20) NOT NULL,
       CHECK (couleur IN ('Rouge', 'Vert', 'Jaune', 'Fushia', 'Bleu', 'Marron', 'Noir', 'Blanc'))
);

CREATE TABLE SAC (
	typeS VARCHAR(20) NOT NULL,
	CHECK (typeS IN ('Sac à dos','Sac à main','Pochette', 'Sac de sport'))
	)INHERITS(CONTENU);

CREATE TABLE CHAUSSURE (
	typeC VARCHAR(20) NOT NULL,
	CHECK (typeC IN ('Escarpins','Ballerines','Baskets','Bottes'))
	)INHERITS(CONTENU);


CREATE TABLE MATIERE_SAISON (
	matiere VARCHAR(30),
	saison VARCHAR(30),
	PRIMARY KEY (matiere, saison),
	CHECK (matiere IN ('Laine','Coton','Jean','Lin','Velours','Cuir','Dentelle','Daim', 'Satin','Paillete')),
	CHECK (saison IN ('Toutes','Automne/Hiver','Printemps/Ete'))
);


CREATE TABLE VETEMENT (
	matiere VARCHAR(30),
	lavage BOOLEAN NOT NULL, --false ssi il est propre
	CHECK (matiere IN ('Laine','Coton','Jean','Lin','Velours','Cuir','Dentelle','Daim', 'Satin','Paillete'))
	)INHERITS(CONTENU);

CREATE TABLE HAUT (
	typeH VARCHAR(20) NOT NULL,
	coupeH VARCHAR(20) NOT NULL,
	niveau INTEGER NOT NULL,
	CHECK (niveau>0 AND niveau<3),
	CHECK (typeH IN ('Tee-shirt','Chemise','Pull','Veste','Manteau')),
	CHECK (coupeH IN ('Cintree','Droite','Large'))
	) INHERITS(VETEMENT);


CREATE TABLE BAS (
	typeB VARCHAR(20) NOT NULL,
	coupeB VARCHAR(20) NOT NULL,
	CHECK (typeB IN ('Pantalon','Pantacourt','Jogging', 'Short')),
	CHECK (coupeB IN ('Slim','Droite','Evasee','Baggy'))
	)INHERITS(VETEMENT);


CREATE TABLE AUTRE (
	typeA VARCHAR(20) NOT NULL,
	coupeA VARCHAR(20) NOT NULL,
	CHECK (typeA IN ('Robe','Salopette')),
	CHECK (coupeA IN ('Longue','Court'))
	)INHERITS(VETEMENT);

CREATE TABLE FORME_VETEMENT (
      idContenu INTEGER,
      forme_v VARCHAR(5),
      CHECK (forme_v IN ('8', 'V', 'O', 'A', 'H', 'X')), 
      PRIMARY KEY (idContenu,forme_v)
);
