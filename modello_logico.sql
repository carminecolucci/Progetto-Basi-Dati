-- AUTOMOBILI(targa*, modello, cliente: CLIENTI, dispositivo: DISPOSITIVI);
-- CLIENTI(id*, nome, cognome, email, password, cf, data_nascita, luogo_nascita);
-- DISPOSITIVI(id*, num_veicoli, proprietario: CLIENTI);

-- TRAGITTI(id*, dispositivo*: DISPOSITIVI, ingresso: CASELLI, data_ingresso, uscita: CASELLI, data_uscita):
-- CASELLI(id*, nome, numero);

-- CARTE(id*, numero, cvv, data_scadenza, cliente: CLIENTI);
-- CONTI(id*, iban, numero_conto, cliente: CLIENTI);

-- FATTURE(id*, cliente: CLIENTI, data_generazione, importo, paese, via, civico, cap, citta, provincia);

ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YYYY HH24:MI:SS'

CREATE SEQUENCE caselli_id_sequence START WITH 1;
CREATE TABLE CASELLI (
	id INTEGER DEFAULT caselli_id_sequence.nextval,
	nome VARCHAR2(60) NOT NULL,
	numero INTEGER NOT NULL,

	CONSTRAINT PK_CASELLI PRIMARY KEY (id)
);

CREATE SEQUENCE carte_id_sequence START WITH 1;
CREATE TABLE CARTE (
	id INTEGER DEFAULT carte_id_sequence.nextval,
	numero INTEGER NOT NULL,
	cvv INTEGER NOT NULL,
	data_scadenza DATE NOT NULL,
	cliente INTEGER NOT NULL,

	CONSTRAINT PK_CARTE PRIMARY KEY (id),
	CONSTRAINT FK_CARTE FOREIGN KEY (cliente) REFERENCES CLIENTI (id)
);

CREATE SEQUENCE conti_id_sequence START WITH 1;
CREATE TABLE CONTI (
	id INTEGER DEFAULT conti_id_sequence.nextval,
	iban VARCHAR2(34) NOT NULL,
	numero_conto VARCHAR2(12) NOT NULL,
	cliente INTEGER NOT NULL,

	CONSTRAINT PK_CONTI PRIMARY KEY (id),
	CONSTRAINT FK_CONTI FOREIGN KEY (cliente) REFERENCES CLIENTI (id)
);

CREATE SEQUENCE fatture_id_sequence START WITH 1;
CREATE TABLE FATTURE (
	id INTEGER DEFAULT fatture_id_sequence.nextval,
	cliente INTEGER NOT NULL,
	data_generazione DATE NOT NULL,
	importo FLOAT NOT NULL,
	paese VARCHAR2(30) NOT NULL,
	via VARCHAR2(60) NOT NULL,
	civico INTEGER NOT NULL,
	cap INTEGER NOT NULL,
	citta VARCHAR2(30) NOT NULL,
	provincia VARCHAR2(30) NOT NULL,

	CONSTRAINT PK_FATTURE PRIMARY KEY (id),
	CONSTRAINT FK_FATTURE FOREIGN KEY (cliente) REFERENCES CLIENTI (id)
);

CREATE SEQUENCE clienti_id_sequence START WITH 1;
CREATE TABLE CLIENTI (
	id INTEGER DEFAULT clienti_id_sequence.nextval,
	nome VARCHAR2(60) NOT NULL,
	cognome VARCHAR2(60) NOT NULL,
	email VARCHAR2(319) NOT NULL,
	password VARCHAR2(32) NOT NULL,
	codice_fiscale VARCHAR2(16) NOT NULL,
	data_nascita DATE NOT NULL,
	luogo_nascita VARCHAR2(60) NOT NULL,

	CONSTRAINT PK_CLIENTI PRIMARY KEY (id)
);

CREATE SEQUENCE dispositivi_id_sequence START WITH 1;
CREATE TABLE DISPOSITIVI (
	id INTEGER DEFAULT dispositivi_id_sequence.nextval,
	numero_veicoli INTEGER DEFAULT 0,
	proprietario INTEGER NOT NULL,

	CONSTRAINT PK_DISPOSITIVI PRIMARY KEY (id),
	CONSTRAINT FK_DISPOSITIVI FOREIGN KEY (proprietario) REFERENCES CLIENTI (id)
);

CREATE TABLE AUTOMOBILI (
	targa VARCHAR2(7),
	modello VARCHAR2(40) NOT NULL,
	proprietario INTEGER NOT NULL,
	dispositivo INTEGER,

	CONSTRAINT PK_AUTOMOBILI PRIMARY KEY (targa),
	CONSTRAINT FK_AUTOMOBILI_CLIENTI FOREIGN KEY (proprietario) REFERENCES CLIENTI (id),
	CONSTRAINT FK_AUTOMOBILI_DISPOSITIVI FOREIGN KEY (dispositivo) REFERENCES DISPOSITIVI (id)
);

CREATE SEQUENCE tragitti_id_sequence START WITH 1;
CREATE TABLE TRAGITTI (
	id INTEGER DEFAULT tragitti_id_sequence.nextval,
	dispositivo INTEGER,
	ingresso INTEGER NOT NULL,
	data_ingresso DATE NOT NULL,
	uscita INTEGER NOT NULL,
	data_uscita DATE NOT NULL,

	CONSTRAINT PK_TRAGITTI PRIMARY KEY (id, dispositivo),
	CONSTRAINT FK_TRAGITTI_DISPOSITIVI FOREIGN KEY (dispositivo) REFERENCES DISPOSITIVI (id),
	CONSTRAINT FK_CASELLI_INGRESSI FOREIGN KEY (ingresso) REFERENCES CASELLI (id),
	CONSTRAINT FK_CASELLI_USCITE FOREIGN KEY (uscita) REFERENCES CASELLI (id)
);
