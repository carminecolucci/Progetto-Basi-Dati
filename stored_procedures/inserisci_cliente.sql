-- Registra un cliente.

CREATE OR REPLACE PROCEDURE INSERISCI_CLIENTE(
	nome IN CLIENTI.nome%TYPE,
	cognome IN CLIENTI.cognome%TYPE,
	email IN CLIENTI.email%TYPE,
	password IN CLIENTI.password%TYPE,
	codice_fiscale IN CLIENTI.codice_fiscale%TYPE,
	data_nascita IN CLIENTI.data_nascita%TYPE,
	luogo_nascita IN CLIENTI.luogo_nascita%TYPE
) AS
BEGIN
	DECLARE
		id CLIENTI.id%TYPE := clienti_id_sequence.nextval;
	BEGIN
		INSERT INTO CLIENTI VALUES (id, nome, cognome, email, password, codice_fiscale, data_nascita, luogo_nascita);
		COMMIT;
	END;
END INSERISCI_CLIENTE;
