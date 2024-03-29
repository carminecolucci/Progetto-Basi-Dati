-- Controlla che il cvv contenga 3 cifre.

CREATE OR REPLACE TRIGGER CHECK_CVV
BEFORE INSERT ON CARTE
FOR EACH ROW
DECLARE
	invalid_cvv EXCEPTION;
BEGIN
	IF LENGTH(:new.cvv) != 3 THEN
		RAISE invalid_cvv;
	END IF;

	EXCEPTION
		WHEN invalid_cvv THEN
			RAISE_APPLICATION_ERROR(-20001, 'CVV inserito non valido: 3 cifre richieste.');
END;
