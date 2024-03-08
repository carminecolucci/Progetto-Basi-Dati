-- Mostra i clienti che hanno una carta di credito scaduta.

SELECT C.id, C.nome, C.cognome
FROM CLIENTI C JOIN CARTE
ON C.id = CARTE.cliente
WHERE CARTE.data_scadenza < SYSDATE;