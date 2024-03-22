import sys
import requests
import json

url = "https://pokeapi.co/api/v2/pokemon/"
response = requests.get(url+sys.argv[1])
print(response.status_code)
data = {
    "xp": 10,
    "especie": sys.argv[1],
    "tipo": response.json()["types"][0]["type"]["name"],
    "saude": 100,
    "ataques": [abilities["ability"]["name"] for abilities in response.json()["abilities"]],
}

buddy = sys.argv[2]
dados = ""
if buddy == "adv":
    dados = "/Users/user/adversario.json"
dados = "/Users/user/pokeData.json"
with open(dados, 'w') as arquivo:
  json.dump(data, arquivo, indent=4)
