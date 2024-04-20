-- Mostra id, nome e cognome dei clienti senza automobili.

SELECT C.id, C.nome, C.cognome
FROM CLIENTI C LEFT JOIN AUTOMOBILI A
ON A.proprietario = C.id
WHERE A.proprietario IS NULL;
