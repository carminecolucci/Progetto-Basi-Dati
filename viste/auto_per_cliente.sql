-- Vista per mostrare le auto di ciascun cliente.

CREATE MATERIALIZED VIEW AUTO_PER_CLIENTI
AS
SELECT C.id AS id_cliente, C.nome, C.cognome, C.email, C.codice_fiscale, A.targa, A.modello
FROM CLIENTI C JOIN AUTOMOBILI A
ON C.id = A.proprietario;
