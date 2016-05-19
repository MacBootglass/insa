create view listeDesChantiersEnCours(numeroChantier, descriptionChantier, nbJoursRestants) as
  select id, description, (dateFinPrevue - CURRENT_DATE)
  from CHANTIER
  where dateDeb < CURRENT_DATE;

create view salaireChantierSupDouze(numeroChantier, salaireJour) as
  select id, salaireParJour
  from CHANTIER;
