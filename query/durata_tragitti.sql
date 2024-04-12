-- Per un dato dispositivo, calcola la durata di ciascun tragitto.

SELECT INGRESSI.nome AS INGRESSO, USCITE.nome AS USCITA,
	TRUNC((to_timestamp(T.data_uscita) - to_timestamp(T.data_ingresso)) / 60, 0) AS DURATA_MINUTI
FROM (TRAGITTI T JOIN CASELLI INGRESSI ON T.ingresso = INGRESSI.id) JOIN CASELLI USCITE
ON T.uscita = USCITE.id
WHERE T.dispositivo = 3
ORDER BY DURATA_MINUTI;
