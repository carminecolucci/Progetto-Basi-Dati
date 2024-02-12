from io import TextIOWrapper
import random
from random import randrange
from codicefiscale import codicefiscale
from datetime import timedelta, datetime
import string
import csv

NUM_CLIENTI = 1000
NUM_DISPOSITIVI = 50
NUM_AUTOMOBILI = 40

d1 = datetime.strptime('1-1-1940', '%d-%m-%Y')
d2 = datetime.strptime('31-12-2005', '%d-%m-%Y')

fmt_clienti = "INSERT INTO CLIENTI (nome, cognome, email, password, codice_fiscale, data_nascita, luogo_nascita) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s');"
fmt_dispositivi = "INSERT INTO DISPOSITIVI (proprietario) VALUES (%s);"
fmt_auto = "INSERT INTO AUTOMOBILI (targa, modello, cliente, dispositivo) VALUES ('%s', '%s', %s, %s);"

def create_client(fp: TextIOWrapper, clienti):
	for cliente in clienti:
		nome = cliente[0].title().replace("'", "''")
		cognome = cliente[1].replace("'", "''")
		luogo_nascita = cliente[2]
		email = nome.replace("'", "").replace(" ", "") + cognome.replace("'", "").replace(" ", "") + "@gmail.com"
		password = nome.replace("'", "").replace(" ", "") + "!"
		data_nascita = random_date(d1, d2)
		try:
			cf = codicefiscale.encode(cognome, nome, random.choice(['f', 'm']), data_nascita, luogo_nascita)
		except:
			continue
		print(fmt_clienti % (nome, cognome, email, password, cf, data_nascita, luogo_nascita.replace("'", "''")), file=fp)

def random_date(start, end):
	delta = end - start
	int_delta = delta.days
	random_day = randrange(int_delta)
	date = start + timedelta(days=random_day)
	return date.strftime("%d-%m-%Y")

def genera_clienti():
	# CLIENTI(DEFAULT, nome, cognome, email, password, cf, data_nascita, luogo_nascita, carta: CARTE, conto: CONTI);

	nomi = []
	with open("wordlists/nomi.txt") as nomi_fp:
		nomi = [nome.strip() for nome in nomi_fp.readlines()]

	cognomi = []
	with open("wordlists/cognomi.txt", encoding="utf8") as cognomi_fp:
		cognomi = [cognome.strip() for cognome in cognomi_fp.readlines()]

	comuni = []
	with open("wordlists/comuni.txt") as comuni_fp:
		comuni = [comune.strip() for comune in comuni_fp.readlines()]

	clienti = []
	for _ in range(NUM_CLIENTI):
		clienti.append((random.choice(nomi), random.choice(cognomi), random.choice(comuni)))

	with open("clienti.sql", "w") as fp:
		create_client(fp, clienti)

def genera_targa():
	lettere = ''.join(random.choices(string.ascii_uppercase, k=2))
	numeri = ''.join(random.choices(string.digits, k=3))
	targa = f'{lettere}{numeri}{lettere}'
	return targa

def genera_dispositivi():
	# DISPOSITIVI(id*, num_veicoli, proprietario: CLIENTI);
	with open("dispositivi.sql", "w") as fp:
		for i in range(1, NUM_DISPOSITIVI + 1):
			print(fmt_dispositivi % (i), file=fp)

def genera_auto():
	# AUTOMOBILI(targa*, modello, cliente: CLIENTI, dispositivo: DISPOSITIVI);

	with open("auto.csv") as file_csv:
		reader = csv.reader(file_csv)
		dati_letti = list(reader)

	modelli = []
	for riga in dati_letti:
		modelli.append(f"{riga[1]} {riga[2].title()}")

	targhe = set()
	for _ in range(NUM_AUTOMOBILI):
		targa_auto = genera_targa()
		targhe.add(targa_auto)

	auto_per_disp = []
	for _ in range(NUM_DISPOSITIVI):
		auto_per_disp.append(0)

	with open("automobili.sql", "w") as fp:
		for targa in targhe:
			disp = random.randint(1, NUM_DISPOSITIVI)
			if auto_per_disp[disp - 1] == 2:

				disp = random.randint(1, NUM_DISPOSITIVI)
				while auto_per_disp[disp - 1] == 2:
					disp = random.randint(1, NUM_DISPOSITIVI)

			auto_per_disp[disp - 1] += 1
			print(fmt_auto % (targa, random.choice(modelli), random.randint(1, 100), disp), file=fp)

if __name__ == "__main__":
	genera_clienti()
	genera_dispositivi()
	genera_auto()
