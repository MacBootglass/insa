select animal, count(distinct nom) nom, count(distinct annee_naissance) annee_naissance, count(distinct espece) espece, count (distinct emplacement) emplacement from zoo group by animal;

select nom, espece, count(distinct animal) animal from zoo group by nom, espece;

select espece, count(distinct origine) origine, count(distinct classe) classe from zoo group by espece;

select gardien, count(distinct prenom) prenom, count(distinct salaire) salaire from zoo group by gardien;

select emplacement, count(distinct surface) surface, count(distinct type_empl) type_empl, count(distinct gardien) gardien from zoo group by emplacement;

select type_empl, count(distinct libelle_empl) libelle_empl from zoo group by type_empl;



select animal, count(distinct nom) count_nom, count(distinct annee_naissance) count_annee_naissance, count(distinct espece) count_espece, count(distinct emplacement) count_emplacement
from zoo
group by animal
having count(distinct nom) > 1 or count(distinct annee_naissance) > 1 or count(distinct espece) > 1 or count(distinct emplacement) > 1;

select nom, espece, count(distinct animal) count_animal
from zoo
group by nom, espece
having count(distinct animal) > 1;

select espece, count(distinct origine) count_origine, count(distinct classe) count_classe
from zoo
group by espece
having count(distinct origine) > 1 or count(distinct classe) > 1;

select gardien, count(distinct prenom) count_prenom, count(distinct salaire) count_salaire
from zoo
group by gardien
having count(distinct prenom) > 1 or count(distinct salaire) > 1;

select emplacement, count(distinct surface) count_surface, count(distinct type_empl) count_type_empl, count(distinct gardien) count_gardien
from zoo
group by emplacement
having count(distinct surface) > 1 or count(distinct type_empl) > 1 or count(distinct gardien) > 1;

select type_empl, count(distinct libelle_empl) count_libelle_empl
from zoo
group by type_empl
having count(distinct libelle_empl) > 1;



UPDATE zoo
SET classe = 'mamifère', origine = 'Afrique'
WHERE animal = 4;

UPDATE zoo
SET surface = 500
WHERE animal = 1;
