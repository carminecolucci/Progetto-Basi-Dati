CREATE OR REPLACE TRIGGER check_CVV
BEFORE INSERT ON CARTE
FOR EACH ROW
DECLARE
    wrong_CVV EXCEPTION;
BEGIN
    IF LENGTH(:new.CVV) != 3 THEN
        RAISE wrong_CVV;
    END IF;

	EXCEPTION
		WHEN wrong_CVV THEN
       		RAISE_APPLICATION_ERROR(-20001, 'CVV inserito non valido: 3 cifre richieste.');
END;