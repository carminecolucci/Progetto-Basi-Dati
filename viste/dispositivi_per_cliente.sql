-- Vista per mostrare i dispositivi di ciascun cliente.

CREATE MATERIALIZED VIEW DISPOSITIVI_PER_CLIENTE
AS
SELECT C.id AS id_cliente, C.nome, C.cognome, C.email, C.codice_fiscale, D.id AS id_dispositivo, D.numero_veicoli
FROM CLIENTI C JOIN DISPOSITIVI D
ON C.id = D.proprietario;
