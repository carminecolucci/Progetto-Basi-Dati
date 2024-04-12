-- Mostra i dispositivi associati a due automobili.

SELECT D.id, A.targa
FROM DISPOSITIVI D JOIN AUTOMOBILI A
ON D.id = A.dispositivo
WHERE D.num_veicoli = 2;
