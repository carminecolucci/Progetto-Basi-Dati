import csv
import random
import string

from codicefiscale import codicefiscale
from io import TextIOWrapper
from utils import *

NUM_CLIENTI = 1000
NUM_DISPOSITIVI = 500
NUM_AUTOMOBILI = 600
NUM_CASELLI = 8
NUM_TRAGITTI = 200
NUM_CARTE = 50
NUM_CONTI = 50

inizio_nascite = datetime.strptime('1-1-1940', '%d-%m-%Y')
fine_nascite = datetime.strptime('31-12-2005', '%d-%m-%Y')

inizio_tragitti = datetime.strptime('1-1-2020', '%d-%m-%Y')
fine_tragitti = datetime.strptime('31-12-2023', '%d-%m-%Y')

inizio_scadenze = datetime.strptime('1-1-2025', '%d-%m-%Y')
fine_scadenze = datetime.strptime('31-12-2030', '%d-%m-%Y')

fmt_clienti = "INSERT INTO CLIENTI (nome, cognome, email, password, codice_fiscale, data_nascita, luogo_nascita) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s');"
fmt_dispositivi = "INSERT INTO DISPOSITIVI (proprietario) VALUES (%s);"
fmt_auto = "INSERT INTO AUTOMOBILI (targa, modello, proprietario, dispositivo) VALUES ('%s', '%s', %s, %s);"
fmt_tragitti = "INSERT INTO TRAGITTI (dispositivo, ingresso, data_ingresso, uscita, data_uscita) VALUES (%s, %s, '%s', %s, '%s');"
fmt_carte = "INSERT INTO CARTE (numero, cvv, data_scadenza, cliente) VALUES (%s, %s, '%s', %s);"
fmt_conti = "INSERT INTO CONTI (iban, numero_conto, cliente) VALUES ('%s', '%s', %s);"

def create_client(fp: TextIOWrapper, clienti):
	for cliente in clienti:
		nome = cliente[0].title().replace("'", "''")
		cognome = cliente[1].replace("'", "''")
		luogo_nascita = cliente[2]
		email = nome.replace("'", "").replace(" ", "") + cognome.replace("'", "").replace(" ", "") + "@gmail.com"
		password = nome.replace("'", "").replace(" ", "") + "!"
		data_nascita = random_date(inizio_nascite, fine_nascite)
		try:
			cf = codicefiscale.encode(cognome, nome, random.choice(['f', 'm']), data_nascita, luogo_nascita)
		except ValueError:
			continue
		print(fmt_clienti % (nome, cognome, email, password, cf, data_nascita, luogo_nascita.replace("'", "''")), file=fp)

def genera_clienti():
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

def genera_dispositivi():
	with open("dispositivi.sql", "w") as fp:
		for i in range(1, NUM_DISPOSITIVI + 1):
			print(fmt_dispositivi % (i), file=fp)

def genera_targa():
	lettere = ''.join(random.choices(string.ascii_uppercase, k=2))
	numeri = ''.join(random.choices(string.digits, k=3))
	targa = f'{lettere}{numeri}{lettere}'
	return targa

def genera_auto():
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

	auto_per_disp = [0 for _ in range(NUM_DISPOSITIVI)]

	with open("automobili.sql", "w") as fp:
		for targa in targhe:
			disp = random.randint(1, NUM_DISPOSITIVI)
			if auto_per_disp[disp - 1] == 2:

				disp = random.randint(1, NUM_DISPOSITIVI)
				while auto_per_disp[disp - 1] == 2:
					disp = random.randint(1, NUM_DISPOSITIVI)

			auto_per_disp[disp - 1] += 1
			print(fmt_auto % (targa, random.choice(modelli), random.randint(1, 100), disp), file=fp)

def genera_tragitti():
	with open("tragitti.sql", "w") as fp:
		for _ in range(NUM_TRAGITTI):
			disp = random.randint(1, NUM_DISPOSITIVI)
			ingresso = random.randint(1, NUM_CASELLI)
			uscita = random.randint(1, NUM_CASELLI)
			while uscita == ingresso:
				uscita = random.randint(1, NUM_CASELLI)

			data_ora_ingresso = random_datetime(inizio_tragitti, fine_tragitti)
			data_ora_uscita = data_ora_ingresso + timedelta(hours=1)

			print(fmt_tragitti % (disp, ingresso, datetime_to_str(data_ora_ingresso), uscita, datetime_to_str(data_ora_uscita)), file=fp)

def genera_carte():
	with open("carte.sql", mode="w") as fp:
		for i in range(NUM_CARTE):
			numero = "".join(["{}".format(random.randint(0, 9)) for _ in range(16)])
			cvv = random.randint(100, 999)
			data_scadenza = random_date_str(inizio_scadenze, fine_scadenze)
			cliente = i + 1 # così assegnamo le carte ai primi i clienti
			print(fmt_carte % (numero, cvv, data_scadenza, cliente), file=fp)

def genera_conti():
	with open("conti.sql", "w") as fp:
		for i in range(NUM_CONTI):
			iban = "IT" + "".join(["{}".format(random.randint(0, 9)) for _ in range(32)])
			numero_conto = iban[2:14]
			cliente = NUM_CARTE + 1 + i
			print(fmt_conti % (iban, numero_conto, cliente), file=fp)

if __name__ == "__main__":
	# genera_clienti()
	# genera_dispositivi()
	# genera_auto()
	# genera_tragitti()
	# genera_carte()
	genera_conti()
