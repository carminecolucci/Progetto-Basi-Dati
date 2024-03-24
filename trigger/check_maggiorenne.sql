-- All'atto della registrazione di un cliente (o della modifica dell'anagrafica), 
-- controlla che abbia raggiunto la maggiore età necessaria per
-- poter usufruire del servizio offerto

CREATE OR REPLACE TRIGGER CHECK_MAGGIORENNE
BEFORE INSERT OR UPDATE ON CLIENTI
FOR EACH ROW
BEGIN
	IF MONTHS_BETWEEN(SYSDATE, :new.DATA_NASCITA) / 12 < 18 THEN
		RAISE_APPLICATION_ERROR(-20002, 'Occorre essere maggiorenni per effettuare la registrazione.');
    END IF;
END;
    