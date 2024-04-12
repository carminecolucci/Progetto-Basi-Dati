-- Mostra il numero totale di tragitti percorsi da ciascun dispositivo.

SELECT D.id AS DISPOSITIVO, COUNT(*) AS NUMERO_TRAGITTI
FROM DISPOSITIVI D LEFT JOIN TRAGITTI T
ON D.id = T.dispositivo
GROUP BY D.id
ORDER BY NUMERO_TRAGITTI DESC;
