/*
  TABLE_ANIMAL(animal, nom, annee_naissance, espece, emplacement)
  TABLE_ESPECE(espece, origine, classe)
  TABLE_GARDIEN(gardien, prenom, salaire)
  TABLE_EMPLACEMENT(emplacement, surface, type_empl, gardien)
  TABLE_TYPE_EMPLACEMENT(type_empl, libelle_empl)
*/

select animal, nom
from zoo
where espece like 'Ours';

select animal, nom
from table_animal
where espece like 'Ours';



select distinct espece
from zoo
where nom like 'Josiane';

select espece
from table_animal
where nom like 'Josiane';



select animal, nom
from zoo
where libelle_empl like 'Forêt'
order by animal;

select animal, nom
from table_animal, table_emplacement, table_type_emplacement
where libelle_empl like 'Forêt'
and table_animal.emplacement = table_emplacement.emplacement
and table_type_emplacement.type_empl = table_emplacement.type_empl
order by animal;



select animal, nom , espece
from zoo
where gardien like 'Gamotte' ;

select animal, nom , espece
from table_animal, table_gardien, table_emplacement
where table_animal.emplacement = table_emplacement.emplacement
and table_emplacement.gardien = table_gardien.gardien
and table_gardien.gardien like 'Gamotte' ;



select classe, emplacement, surface, libelle_empl, type_empl
from zoo
group by classe, emplacement, surface, libelle_empl, type_empl
having count(distinct classe) > 1;

select classe, emplacement, surface, libelle_empl, type_empl
from table_animal, table_emplacement, table_type_emplacement
where table_animal.emplacement = table_emplacement.emplacement
and table_type_emplacement.type_empl = table_type_emplacement.type_empl
group by classe, table_emplacement, surface, table_type_emplacement.libelle_empl, table_type_emplacement.ype_empl
having count(distinct classe)>1;
