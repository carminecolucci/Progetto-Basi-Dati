-- Mostra per ogni casello il numero di volte in cui è stato attraversato.

SELECT C.nome AS CASELLO, C.numero AS NUMERO_CASELLO, COUNT(*) AS PERCORRENZE
FROM CASELLI C JOIN TRAGITTI T ON C.id = T.ingresso
GROUP BY (C.nome, C.numero)
ORDER BY PERCORRENZE DESC;

SELECT C.nome AS CASELLO, C.numero AS NUMERO_CASELLO, COUNT(*) AS PERCORRENZE
FROM CASELLI C JOIN TRAGITTI T ON C.id = T.uscita
GROUP BY (C.nome, C.numero)
ORDER BY PERCORRENZE DESC;
