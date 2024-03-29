-- All'atto della registrazione di un cliente (o della modifica dell'anagrafica), 
-- controlla che abbia raggiunto la maggiore età necessaria per
-- poter usufruire del servizio offerto

CREATE OR REPLACE TRIGGER CHECK_MAGGIORENNE
BEFORE INSERT OR UPDATE ON CLIENTI
FOR EACH ROW
DECLARE
	minorenne EXCEPTION;
BEGIN
	IF MONTHS_BETWEEN(SYSDATE, :new.data_nascita) / 12 < 18 THEN
		RAISE minorenne;
	END IF;

	EXCEPTION
		WHEN minorenne THEN
			RAISE_APPLICATION_ERROR(-20004, 'Occorre essere maggiorenni per effettuare la registrazione.');
END;
