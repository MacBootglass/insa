create or replace rule updateListeDesChantiersEnCours as on update to listeDesChantiersEnCours
do instead
update chantier set description = new.descriptionChantier, dateFinPrevue = CURRENT_DATE + new.nbJoursRestants where id = new.numeroChantier;


create or replace rule deleteListeDesChantiersEnCours as on delete to listeDesChantiersEnCours
do instead
delete from chantier where id = old.numeroChantier;


create or replace rule updateSalaireChantierSupDouze as on update to salaireChantierSupDouze
do instead
update chantier set salaireParJour = new.salaireJour where new.numeroChantier = id;


create or replace rule insertSalaireChantierSupDouze as on insert to salaireChantierSupDouze
do instead
insert into chantier values (new.numeroChantier, NULL, NULL, CURRENT_DATE, NULL, new.salaireJour);
