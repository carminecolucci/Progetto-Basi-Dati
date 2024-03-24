-- Controlla che la carta di credito inserita non sia scaduta.

CREATE OR REPLACE TRIGGER CONTROLLA_SCADENZA_CARTA
BEFORE INSERT ON CARTE
FOR EACH ROW
BEGIN
	IF :new.data_scadenza < SYSDATE THEN
		RAISE_APPLICATION_ERROR(-20003, 'Carta di credito scaduta.')
	END IF;
END;
