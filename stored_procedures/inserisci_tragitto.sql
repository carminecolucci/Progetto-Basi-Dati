-- Registra un tragitto.

CREATE OR REPLACE PROCEDURE INSERISCI_TRAGITTO(
	dispositivo IN TRAGITTI.dispositivo%TYPE,
	ingresso IN TRAGITTI.ingresso%TYPE,
	data_ingresso IN TRAGITTI.data_ingresso%TYPE,
	uscita IN TRAGITTI.uscita%TYPE,
	data_uscita IN TRAGITTI.data_uscita%TYPE
) AS
BEGIN
	DECLARE
		id TRAGITTI.id%TYPE := tragitti_id_sequence.nextval;
	BEGIN
		INSERT INTO TRAGITTI VALUES (id, dispositivo, ingresso, data_ingresso, uscita, data_uscita);
		COMMIT;
	END;
END INSERISCI_TRAGITTO;
