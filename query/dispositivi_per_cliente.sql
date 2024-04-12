-- Mostra il numero di dispositivi associati a ciascun cliente.

SELECT C.id, C.nome, C.cognome, COUNT(*) AS NUM_DISPOSITIVI
FROM CLIENTI C LEFT JOIN DISPOSITIVI D
ON C.id = D.proprietario
GROUP BY (C.id, C.nome, C.cognome)
ORDER BY NUM_DISPOSITIVI DESC;
