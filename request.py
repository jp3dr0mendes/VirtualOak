import sys
import requests

url = "https://pokeapi.co/api/v2/pokemon/"

response = requests.get(url+sys.argv[1])

if response.status_code != 200:
  pass
else:
  print(response.text)
