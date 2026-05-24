import urllib.request, json

resp = urllib.request.urlopen('http://localhost:5173/api/knowledge/tree')
data = json.loads(resp.read().decode('utf-8'))
print('code:', data.get('code'))
items = data.get('data', [])
print('top-level modules:', len(items))
for m in items:
    name = m['name']
    children = len(m.get('children', []))
    print(f'  {name}: {children} children')

resp2 = urllib.request.urlopen('http://localhost:5173/api/knowledge/7/contents')
data2 = json.loads(resp2.read().decode('utf-8'))
print('\nKnowledge 7 contents:', len(data2.get('data', [])))
for c in data2.get('data', []):
    print(f'  [{c["contentType"]}] {c["title"]}')

resp3 = urllib.request.urlopen('http://localhost:5173/api/exercise/list?page=1&pageSize=3')
data3 = json.loads(resp3.read().decode('utf-8'))
records = data3.get('data', {}).get('records', [])
print('\nExercise list (first 3):')
for r in records:
    print(f'  [{r["type"]}] {r["title"]}')
