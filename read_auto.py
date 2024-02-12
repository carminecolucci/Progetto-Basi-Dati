import csv

auto = "auto.csv"

with open(auto, mode='r') as file_csv:
    reader = csv.reader(file_csv)

    dati_letti = list(reader)

modelli = []
for riga in dati_letti:
    modelli.append(f"{riga[1]} {riga[2]}")

print(modelli)
