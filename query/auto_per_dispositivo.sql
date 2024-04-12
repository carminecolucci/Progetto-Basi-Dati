-- Per ciascun dispositivo, mostra le automobili ad esso associate.

SELECT D.id, A.targa, A.modello
FROM DISPOSITIVI D JOIN AUTOMOBILI A
ON D.id = A.dispositivo
ORDER BY (D.id, A.targa);
