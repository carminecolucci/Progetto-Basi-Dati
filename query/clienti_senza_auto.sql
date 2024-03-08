-- Mostra id, nome e cognome dei clienti senza automobili.

SELECT C.id, C.nome, C.cognome
FROM CLIENTI C LEFT JOIN AUTOMOBILI A
ON A.cliente = C.id
WHERE A.cliente IS NULL;