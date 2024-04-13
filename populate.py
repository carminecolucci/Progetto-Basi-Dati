from codicefiscale import codicefiscale
import csv
from datetime import timedelta, datetime
from io import TextIOWrapper
import random
import string

NUM_CLIENTI = 1000
NUM_DISPOSITIVI = 50
NUM_AUTOMOBILI = 40
NUM_CASELLI = 8
NUM_TRAGITTI = 200

inizio_nascite = datetime.strptime('1-1-1940', '%d-%m-%Y')
fine_nascite = datetime.strptime('31-12-2005', '%d-%m-%Y')

inizio_tragitti = datetime.strptime('1-1-2020', '%d-%m-%Y')
fine_tragitti = datetime.strptime('31-12-2023', '%d-%m-%Y')

fmt_clienti = "INSERT INTO CLIENTI (nome, cognome, email, password, cf, data_nascita, luogo_nascita) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s');"
fmt_dispositivi = "INSERT INTO DISPOSITIVI (proprietario) VALUES (%s);"
fmt_auto = "INSERT INTO AUTOMOBILI (targa, modello, proprietario, dispositivo) VALUES ('%s', '%s', %s, %s);"
fmt_tragitti = "INSERT INTO TRAGITTI (dispositivo, ingresso, data_ingresso, uscita, data_uscita) VALUES (%s, %s, '%s', %s, '%s');"

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

def random_date(start: datetime, end: datetime) -> datetime:
	""" Returns a random date "%d-%m-%Y" between start and end. """
	delta = end - start
	int_delta = delta.days
	random_day = random.randrange(int_delta)
	date = start + timedelta(days=random_day)
	return date

def random_date_str(start: datetime, end: datetime) -> str:
	return random_date(start, end).strftime("%d-%m-%Y")

def date_to_str(date: datetime) -> str:
	return date.strftime("%d-%m-%Y")

def random_datetime(start: datetime, end: datetime) -> datetime:
	""" Returns a random date "%d-%m-%Y %H:%M:%S" between start and end. """
	delta = end - start
	int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
	random_second = random.randrange(int_delta)
	date = start + timedelta(seconds=random_second)
	return date

def random_datetime_str(start: datetime, end: datetime) -> str:
	return random_datetime(start, end).strftime("%d-%m-%Y %H:%M:%S")

def datetime_to_str(time: datetime) -> str:
	return time.strftime("%d-%m-%Y %H:%M:%S")

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

def genera_targa():
	lettere = ''.join(random.choices(string.ascii_uppercase, k=2))
	numeri = ''.join(random.choices(string.digits, k=3))
	targa = f'{lettere}{numeri}{lettere}'
	return targa

def genera_dispositivi():
	with open("dispositivi.sql", "w") as fp:
		for i in range(1, NUM_DISPOSITIVI + 1):
			print(fmt_dispositivi % (i), file=fp)

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

if __name__ == "__main__":
	genera_clienti()
	genera_dispositivi()
	genera_auto()
	genera_tragitti()
