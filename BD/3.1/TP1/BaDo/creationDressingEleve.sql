--Creation des tables


CREATE TABLE UTILISATEUR (
	idPersonne SERIAL PRIMARY KEY,
	nom VARCHAR(20) NOT NULL,
	prenom VARCHAR(20) NOT NULL,
	age INTEGER,
	taille INTEGER NOT NULL,
	couleurCheveux VARCHAR(20) NOT NULL,
	couleurPreferee VARCHAR(20) NOT NULL,
	forme_u VARCHAR(5),
	check (forme_u in ('8', 'V', 'O', 'A', 'H', 'X'))
);

CREATE TABLE DRESSING (
   idDressing SERIAL PRIMARY KEY,
   idPersonne INTEGER references UTILISATEUR on delete cascade
);


CREATE TABLE CONTENU (
   idContenu SERIAL PRIMARY KEY,
   idDressing INTEGER references DRESSING on delete cascade,
   couleur VARCHAR(20) NOT NULL
);

CREATE TABLE SAC (
	typeS VARCHAR(20),
	check (typeS in ('Sac à dos', 'Sac à main', 'Sac de sport', 'Pochette'))
)inherits(CONTENU);

CREATE TABLE CHAUSSURE (
	typeC VARCHAR(20),
	check (typeC in ('Escarpins', 'Ballerines', 'Baskets', 'Bottes'))
)inherits(CONTENU);


CREATE TABLE MATIERE_SAISON (
	matiere VARCHAR(30),
	saison VARCHAR(30) NOT NULL,
	check (matiere in ('Laine', 'Coton', 'Jean', 'Lin', 'Velours', 'Cuir', 'Dentelle', 'Dain', 'Satin', 'Paillete')),
	primary key(matiere, saison)
);

CREATE TABLE VETEMENT (
	matiere VARCHAR(30),
	niveau INTEGER,
	lavage BOOLEAN, --false ssi il est propre
	check (niveau >= 1 and niveau <= 2)
)inherits(CONTENU);

CREATE TABLE HAUT (
	typeH VARCHAR(20),
	coupeH VARCHAR(20),
	check (typeH in ('Tee-shirt', 'Chemise', 'Pull', 'Veste', 'Manteau')),
	check (coupeH in ('Cintree', 'Droite', 'Large'))
)inherits(VETEMENT);


CREATE TABLE BAS (
	typeB VARCHAR(20),
	coupeB VARCHAR(20),
	check (typeB in ('Pantalon', 'Pantacourt', 'Jogging', 'Short')),
	check (coupeB in ('Slim', 'Droite', 'Evasee', 'Baggy'))
)inherits(VETEMENT);


CREATE TABLE AUTRE (
	typeA VARCHAR(20),
	coupeA VARCHAR(20),
	check (typeA in ('Robe', 'Salopette')),
	check (coupeA in ('Longue', 'Court'))
)inherits(VETEMENT);

CREATE TABLE FORME_VETEMENT (
  idContenu INTEGER references CONTENU on delete cascade,
  forme_v VARCHAR(5),
	check (forme_v in ('8', 'V', 'O', 'A', 'H', 'X')),
	primary key(idContenu, forme_v)
);
