drop view vetementSaisonEnCours;

create view vetementSaisonEnCours(idContenu) as
  select idContenu from HAUT, MATIERE_SAISON
  where (MATIERE_SAISON.SAISON = getSaisonCourante()
  or MATIERE_SAISON.SAISON = 'Toutes')
  and HAUT.matiere = MATIERE_SAISON.matiere;
