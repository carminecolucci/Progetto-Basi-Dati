-- Controlla che il cliente abbia inserito un metodo di pagamento prima di acquistare un dispositivo.

CREATE OR REPLACE TRIGGER CONTROLLA_ACQUISTO_DISPOSITIVO
BEFORE INSERT ON DISPOSITIVI
FOR EACH ROW
DECLARE
	carta CARTE.id%TYPE;
	conto CONTI.id%TYPE;
	nessun_metodo EXCEPTION;
BEGIN
	SELECT id INTO carta FROM CARTE
	WHERE cliente = :new.proprietario
	LIMIT 1;

	SELECT id INTO conto FROM CONTI
	WHERE cliente = :new.proprietario
	LIMIT 1;

	IF carta IS NULL AND conto IS NULL THEN
		RAISE nessun_metodo;
	END IF;

	EXCEPTION
		WHEN nessun_metodo THEN
			RAISE_APPLICATION_ERROR(-20006, 'Il cliente non ha nessun metodo di pagamento associato.');
END;
