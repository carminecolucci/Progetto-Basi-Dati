-- Controlla che un tragitto sia valido, ovvero abbia data di ingresso precedente a quella di uscita.

CREATE OR REPLACE TRIGGER CONTROLLA_TRAGITTO
BEFORE INSERT ON TRAGITTI
FOR EACH ROW
BEGIN
	IF :new.data_ingresso > :new.data_uscita THEN
		RAISE_APPLICATION_ERROR(-20003, 'Tragitto non valido.')
	END IF;
END;
