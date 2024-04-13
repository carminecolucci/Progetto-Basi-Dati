-- Controlla che la carta di credito inserita non sia scaduta.

CREATE OR REPLACE TRIGGER CONTROLLA_SCADENZA_CARTA
BEFORE INSERT ON CARTE
FOR EACH ROW
DECLARE
	carta_scaduta EXCEPTION;
BEGIN
	IF :new.data_scadenza < SYSDATE THEN
		RAISE carta_scaduta;
	END IF;

	EXCEPTION
		WHEN carta_scaduta THEN
			RAISE_APPLICATION_ERROR(-20003, 'Carta di credito scaduta.');
END;
