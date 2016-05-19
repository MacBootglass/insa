/*
  TABLE_ANIMAL(animal, nom, annee_naissance, espece)
  TABLE_ESPECE(epece, origine, classe)
  TABLE_GARDIEN(gardien, prenom, salaire)
  TABLE_EMPLACEMENT(emplacement, surface, type_empl, gardien)
  TABLE_TYPE_EMPLACEMENT(type_empl, libelle_empl)
*/

drop table table_espece cascade;
drop table table_gardien cascade;
drop table table_type_emplacement cascade;
drop table table_animal cascade;
drop table table_emplacement cascade;



create table table_espece (
  espece varchar(10) primary key,
  classe varchar(10),
  origine varchar(10)
);

create table table_gardien(
  gardien varchar(20) primary key,
  prenom varchar(10),
  salaire numeric(10,2)
);

create table table_type_emplacement(
  type_empl numeric(2) primary key,
  libelle_empl varchar(20)
);

create table table_emplacement(
  emplacement numeric(4) primary key,
  surface numeric(4),
  type_empl numeric(2) not null references table_type_emplacement on delete cascade,
  gardien varchar(20) not null references table_gardien on delete cascade
);

create table table_animal (
  animal numeric(4) primary key,
  nom varchar(20),
  annee_naissance numeric(4),
  espece varchar(10) not null references table_espece on delete cascade,
  emplacement numeric(4) not null references table_emplacement on delete cascade
);



insert into table_espece (espece, classe, origine)
select distinct espece, classe, origine
from zoo;

insert into table_gardien (gardien, prenom, salaire)
select distinct gardien, prenom, salaire
from zoo;

insert into table_type_emplacement (type_empl, libelle_empl)
select distinct type_empl, libelle_empl
from zoo;

insert into table_emplacement (emplacement, surface, type_empl, gardien)
select distinct emplacement, surface, type_empl, gardien
from zoo;

insert into table_animal (animal, nom, annee_naissance, espece, emplacement)
select distinct animal, nom, annee_naissance, espece, emplacement
from zoo;
