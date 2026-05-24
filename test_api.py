import urllib.request, json

data = json.dumps({'exerciseId': 118, 'userAnswer': 'C'}).encode()
req = urllib.request.Request('http://localhost:8088/api/exercise/submit', data=data, headers={'Content-Type': 'application/json'})
r = urllib.request.urlopen(req)
result = json.loads(r.read())
print(json.dumps(result, ensure_ascii=False, indent=2))
