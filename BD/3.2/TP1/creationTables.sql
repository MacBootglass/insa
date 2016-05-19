create table parcnat (
  idzone varchar(10) primary key,
  type varchar(15),
  description varchar(50),
  superficie real,
  pays varchar(20),
  ouvertD date not null,
  ouvertF date not null,
  coutInter integer not null,
  check (ouvertD > ouvertF and  coutInter > 50 and coutInter < 500)
);

create table animaux (
  noeAnim varchar(10) primary key,
  espece varchar(15) not null,
  idZone varchar(10) references parcnat on delete cascade,
  dateNais date,
  check (espece in ('AL-PAGA', 'AYE-AYE', 'LION','CHINCHILLA', 'MACAO', 'PANDA', 'TORTUE', 'ELEPHANT', 'BLOB-FISH'))
);

create table veto (
  noVeto varchar(10) primary key,
  nom varchar(15),
  prenom varchar(15),
  etablissement varchar(20),
  compEspece varchar(15) not null,
  dateDispoD date not null,
  dateDispoF date not null,
  check (dateDispoD > dateDispoF and compEspece in ('AL-PAGA', 'AYE-AYE', 'LION','CHINCHILLA', 'MACAO', 'PANDA', 'TORTUE', 'ELEPHANT', 'BLOB-FISH'))
);

create table planning (
  noInter varchar(10) primary key,
  noVeto varchar(10) references veto on delete cascade,
  idZone varchar(10),
  dateInterD date not null,
  dateInterF date not null,
  check (dateInterF > dateInterD)
);
