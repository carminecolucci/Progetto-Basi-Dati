-- Per un dato dispositivo, calcola la durata di ciascun tragitto.

SELECT C1.nome AS INGRESSO, C2.nome AS USCITA,
	TRUNC((to_timestamp(T.data_uscita) - to_timestamp(T.data_ingresso)) / 60, 0) AS DURATA_MINUTI
FROM (TRAGITTI T JOIN CASELLI C1 ON T.ingresso = C1.nome) JOIN CASELLI C2
ON T.uscita = C2.nome
WHERE T.dispositivo = 3
ORDER BY DURATA_MINUTI;
