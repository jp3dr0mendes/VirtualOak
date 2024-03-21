import sys
import requests
import json

url = "https://pokeapi.co/api/v2/pokemon/"
response = requests.get(url+sys.argv[1])

data = {
    "response-staatus": response.status_code,
    "pokemon": {
        "especie": sys.argv[1],
        "tipo": response.json()["types"][0]["type"]["name"],
        "vida": 100,
        "ataques": [abilities["ability"]["name"] for abilities in response.json()["abilities"]],
    }
}

dados = "/Users/user/adversario.json"

with open(dados, 'w') as arquivo:
  json.dump(data, arquivo, indent=4)
