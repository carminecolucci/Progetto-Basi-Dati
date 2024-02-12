import json

data = {}
with open("comuni.json") as fp:
	data = json.load(fp)

comuni = set()
for comune in data:
	comuni.add(comune["name_trans"])

comuni = list(comuni)
comuni.sort()

with open("comuni.txt", "w") as fp:
	for comune in comuni:
		print(comune, file=fp)
