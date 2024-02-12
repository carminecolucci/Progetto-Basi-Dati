import random
import string

def genera_targa():
	lettere = ''.join(random.choices(string.ascii_uppercase, k=2))
	numeri = ''.join(random.choices(string.digits, k=3))
	targa = f'{lettere}{numeri}{lettere}'
	return targa

targhe = set()

for i in range(10):
	targa_auto = genera_targa()
	targhe.add(targa_auto)

print(targhe)
