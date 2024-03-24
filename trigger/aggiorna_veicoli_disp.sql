-- Incrementa il numero di veicoli associati ad un dispositivo,
-- ogni dispositivo può essere associato al più a due automobili.

CREATE OR REPLACE TRIGGER AGGIORNA_VEICOLI_DISPOSITIVO 
BEFORE INSERT ON AUTOMOBILI
FOR EACH ROW
DECLARE
	current INTEGER;
BEGIN
	SELECT NUMERO_VEICOLI INTO current FROM DISPOSITIVI
	WHERE id = :new.dispositivo;

	IF current >= 2 THEN
		RAISE_APPLICATION_ERROR(-20002, 'Massimo due automobili per dispositivo.');
	END IF;

	UPDATE DISPOSITIVI SET NUMERO_VEICOLI = current + 1
	WHERE id = :new.dispositivo;
END;