-- Calcola la fattura per un cliente per i tragitti effettuati in un dato intervallo di tempo.

CREATE OR REPLACE PROCEDURE CALCOLO_FATTURA(
	Cliente IN CLIENTI.id%TYPE,
	Inizio IN DATE,
	Fine IN DATE
) AS
BEGIN
	DECLARE
		Totale FLOAT;
		NumeroTragitti INTEGER;
	BEGIN
		SELECT COUNT(*) INTO NumeroTragitti
		FROM (CLIENTI C JOIN DISPOSITIVI D ON D.proprietario = C.id)
			JOIN TRAGITTI T ON T.dispositivo = D.id
		WHERE C.id = Cliente AND  T.data_ingresso >= Inizio AND T.data_uscita <= Fine;

		Totale := NumeroTragitti * 1.50;

		INSERT INTO FATTURE (cliente, data_generazione, importo) VALUES (Cliente, SYSDATE, Totale);
		COMMIT;
	END;
END CALCOLO_FATTURA;
