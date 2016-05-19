CREATE OR REPLACE FUNCTION proportionVetementPropre () RETURNS FLOAT AS $$
DECLARE
propre FLOAT;
total FLOAT;

BEGIN
SELECT count(lavage) INTO propre FROM vetement WHERE lavage = false;
SELECT count(lavage) INTO total FROM vetement;
RETURN (propre/total)*100;
END $$ LANGUAGE 'plpgsql';
