-- AUTOMOBILI(targa*, modello, cliente: CLIENTI, dispositivo: DISPOSITIVI);
-- CLIENTI(id*, nome, cognome, email, password, cf, data_nascita, luogo_nascita, carta: CARTE, conto: CONTI);
-- DISPOSITIVI(id*, num_veicoli, proprietario: CLIENTI);

-- TRAGITTI(id*, dispositivo*: DISPOSITIVI, ingresso: CASELLI, data_ingresso, uscita: CASELLI, data_uscita):
-- CASELLI(id*, nome, numero);

-- CARTE(numero*, cvv, data_scadenza);
-- CONTI(iban*, numero_conto);

-- FATTURE(id*, data, importo, paese, via, civico, cap, citta, provincia);

CREATE SEQUENCE caselli_id_sequence START WITH 1;

CREATE TABLE CASELLI (
    id INTEGER DEFAULT caselli_id_sequence.nextval,
    nome VARCHAR2(60) NOT NULL,
    numero INTEGER NOT NULL,

    CONSTRAINT PK_CASELLI PRIMARY KEY (id)
);

CREATE TABLE CARTE (
    numero INTEGER,
    cvv INTEGER NOT NULL,
	data_scadenza DATE NOT NULL,

    CONSTRAINT PK_CARTE PRIMARY KEY (numero)
);

CREATE TABLE CONTI (
    iban VARCHAR2(34),
    CONSTRAINT PK_CONTI PRIMARY KEY (iban)
);

CREATE TABLE FATTURE (
	id INTEGER,
	data_generazione DATE NOT NULL,
	importo FLOAT NOT NULL,
	paese VARCHAR2(30) NOT NULL,
    via VARCHAR2(60) NOT NULL,
    civico INTEGER NOT NULL,
    cap INTEGER NOT NULL,
    citta VARCHAR2(30) NOT NULL,
    provincia VARCHAR2(30) NOT NULL,

    CONSTRAINT PK_FATTURE PRIMARY KEY (id)
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
    carta INTEGER,
    conto VARCHAR2(34),

    CONSTRAINT PK_CLIENTI PRIMARY KEY (id),
    CONSTRAINT FK_CLIENTI_CARTE FOREIGN KEY (carta) REFERENCES CARTE (numero),
    CONSTRAINT FK_CLIENTI_CONTI FOREIGN KEY (conto) REFERENCES CONTI (iban)
);

CREATE SEQUENCE dispositivi_id_sequence START WITH 1;

CREATE TABLE DISPOSITIVI (
    id INTEGER DEFAULT dispositivi_id_sequence.nextval,
    numero_veicoli INTEGER DEFAULT 0,
    proprietario INTEGER,

    CONSTRAINT PK_DISPOSITIVI PRIMARY KEY (id),
    CONSTRAINT FK_DISPOSITIVI FOREIGN KEY (proprietario) REFERENCES CLIENTI (id)
);

CREATE TABLE AUTOMOBILI (
    targa VARCHAR2(7),
    modello VARCHAR2(40) NOT NULL,
    cliente INTEGER NOT NULL,
    dispositivo INTEGER,

    CONSTRAINT PK_AUTOMOBILI PRIMARY KEY (targa),
    CONSTRAINT FK_AUTOMOBILI_CLIENTI FOREIGN KEY (cliente) REFERENCES CLIENTI (id),
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
