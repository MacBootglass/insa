CREATE TYPE POSITIONGPS as (
  latitude REAL,
  longitude REAL
);

CREATE TABLE ENTREPRISE_BAT(
nom VARCHAR (20) primary key,
annee_creation NUMERIC(4) not null,
adresse VARCHAR(40) not null);

CREATE TABLE EMPLOYE(
num_INSEE SERIAL primary key,
nom VARCHAR (20) not null,
prenom VARCHAR(20) not null,
date_naiss DATE not null,
statut VARCHAR(10) not null,
check (statut in ('CDI', 'CDD', 'vacataire')));

CREATE TABLE EMPLOIE(
nomEntreprise  VARCHAR(20) references ENTREPRISE_BAT on delete cascade,
idEmploye INTEGER references EMPLOYE on delete cascade,
dateEmbauche DATE not null,
primary key(nomEntreprise, idEmploye));

CREATE TABLE CHANTIER(
id SERIAL primary key,
description VARCHAR(30),
localisation POSITIONGPS,
dateDeb DATE not null,
dateFinPrevue DATE,
salaireParJour NUMERIC (10,2) not null,
check (dateDeb < dateFinPrevue));

CREATE TABLE GERE(
nomEntreprise VARCHAR(20) references ENTREPRISE_BAT on delete cascade,
idChantier INTEGER references CHANTIER on delete cascade,
primary key(nomEntreprise, idChantier));

CREATE TABLE REALISE(
idEmploye INTEGER references EMPLOYE on delete cascade,
idChantier INTEGER references CHANTIER on delete cascade,
primary key(idEmploye, idChantier));
