-- Mostra i dispositivi associati a due automobili.

SELECT D.id, A.targa, A.modello
FROM DISPOSITIVI D JOIN AUTOMOBILI A
ON D.id = A.dispositivo
WHERE D.numero_veicoli = 2
ORDER BY D.id;