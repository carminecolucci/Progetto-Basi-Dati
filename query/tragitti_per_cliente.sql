-- Mostra il numero di tragitti percorsi da ciascun cliente.

SELECT C.nome, C.cognome, COUNT(*) AS NUMERO_TRAGITTI
FROM (CLIENTI C JOIN DISPOSITIVI D ON C.id = D.proprietario)
JOIN TRAGITTI T ON T.dispositivo = D.id
GROUP BY (C.nome, C.cognome)
ORDER BY NUMERO_TRAGITTI DESC;
