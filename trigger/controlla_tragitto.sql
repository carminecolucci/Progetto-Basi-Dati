-- Controlla che un tragitto sia valido, ovvero abbia data di ingresso precedente a quella di uscita.

CREATE OR REPLACE TRIGGER CONTROLLA_TRAGITTO
BEFORE INSERT ON TRAGITTI
FOR EACH ROW
DECLARE
	tragitto_invalido EXCEPTION;
BEGIN
	IF :new.data_ingresso > :new.data_uscita THEN
		RAISE tragitto_invalido;
	END IF;

	EXCEPTION
		WHEN tragitto_invalido THEN
			RAISE_APPLICATION_ERROR(-20005, 'Tragitto non valido.')
END;
