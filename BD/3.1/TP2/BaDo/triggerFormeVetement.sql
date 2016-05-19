DROP TRIGGER triggerGestionCIFormeVetement on Forme_Vetement;

DROP TRIGGER triggerGestionDeleteInFormeVetement on haut;

DROP TRIGGER triggerGestionInsertInFormeVetement on haut;

DROP TRIGGER triggerGestionNiveauHaut on haut;



CREATE OR REPLACE FUNCTION gestionCIFormeVetement() RETURNS TRIGGER AS $$
DECLARE
	idDansTable INTEGER;
BEGIN
	select count(*) into idDansTable from contenu	where contenu.idContenu = new.idContenu;
	if ( idDansTable != 1 ) then
			RAISE EXCEPTION 'Id % absent de la table contenu', new.idContenu;
	end if;
	RETURN NEW;
END $$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION gestionDeleteInFormeVetement() RETURNS TRIGGER AS $$
BEGIN
	delete from Forme_Vetement where old.idContenu = Forme_Vetement.idContenu;
	return old;
END $$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION gestionInsertInFormeVetement() RETURNS TRIGGER AS $$
DECLARE
	idDansTable INTEGER;
BEGIN
	if (new.coupeH = 'Cintree') then
		insert into Forme_Vetement values (new.idContenu, 'H');
		insert into Forme_Vetement values (new.idContenu, '8');
		insert into Forme_Vetement values (new.idContenu, 'V');
		insert into Forme_Vetement values (new.idContenu, 'X');
		insert into Forme_Vetement values (new.idContenu, 'A');
	elsif (new.coupeH = 'Large') then
		insert into Forme_Vetement values (new.idContenu, 'H');
		insert into Forme_Vetement values (new.idContenu, 'O');
	elsif (new.coupeH = 'Droite') then
		insert into Forme_Vetement values (new.idContenu, 'H');
		insert into Forme_Vetement values (new.idContenu, 'O');
		insert into Forme_Vetement values (new.idContenu, 'A');
	elsif (new.coupeH = 'Autre') then
		insert into Forme_Vetement values (new.idContenu, 'O');
		insert into Forme_Vetement values (new.idContenu, '8');
		insert into Forme_Vetement values (new.idContenu, 'V');
		insert into Forme_Vetement values (new.idContenu, 'X');
	end if;
	RETURN NEW;
END $$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION gestionNiveauHaut() RETURNS TRIGGER AS $$
BEGIN
	if (new.typeH = 'Veste' OR new.typeH = 'Manteau') then
		new.Niveau = 2;
	else
		new.Niveau = 1;
	end if;
	RETURN NEW;
END $$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION getSaisonCourante() RETURNS VARCHAR(20) AS $$
DECLARE
	jour INTEGER;
	mois INTEGER;
	SAISON VARCHAR(20);
BEGIN
	select extract (day from current_date) into jour;
	select extract (month from current_date) into mois;

	if (mois = 3) then
		if (jour >= 21) then
			SAISON := 'Printemps/Ete';
		else
			SAISON := 'Automne/Hiver';
		end if;
	elsif (mois = 9) then
		if (jour >= 21) then
			SAISON := 'Automne/Hiver';
		else
			SAISON := 'Printemps/Ete';
		end if;
	elsif (mois > 3 AND mois < 9) then
		SAISON := 'Printemps/Ete';
	else
		SAISON := 'Automne/Hiver';
	end if;
	return SAISON;
END $$ LANGUAGE 'plpgsql';



CREATE TRIGGER triggerGestionCIFormeVetement
BEFORE INSERT ON Forme_Vetement
FOR EACH ROW EXECUTE PROCEDURE gestionCIFormeVetement();

CREATE TRIGGER triggerGestionDeleteInFormeVetement
BEFORE DELETE ON Haut
FOR EACH ROW EXECUTE PROCEDURE gestionDeleteInFormeVetement();

CREATE TRIGGER triggerGestionInsertInFormeVetement
AFTER INSERT ON Haut
FOR EACH ROW EXECUTE PROCEDURE gestionInsertInFormeVetement();

CREATE TRIGGER triggerGestionNiveauHaut
BEFORE INSERT ON Haut
FOR EACH ROW EXECUTE PROCEDURE gestionNiveauHaut();
