import urllib.request, json

urls = [
    ('知识树', 'http://localhost:8088/api/knowledge/tree'),
    ('集合内容', 'http://localhost:8088/api/knowledge/7/contents'),
    ('集合代码', 'http://localhost:8088/api/knowledge/7/codes'),
    ('集合习题', 'http://localhost:8088/api/exercise/knowledge/7'),
    ('图内容', 'http://localhost:8088/api/knowledge/19/contents'),
    ('排序习题', 'http://localhost:8088/api/exercise/knowledge/27'),
    ('习题列表', 'http://localhost:8088/api/exercise/list?page=1&pageSize=5'),
]

for name, url in urls:
    try:
        resp = urllib.request.urlopen(url)
        data = json.loads(resp.read().decode('utf-8'))
        items = data.get('data', [])
        if isinstance(items, dict) and 'records' in items:
            total = items.get('total', 0)
            rec_count = len(items.get('records', []))
            print(f'{name}: OK, {rec_count} records (total: {total})')
        elif isinstance(items, list):
            print(f'{name}: OK, {len(items)} items')
        else:
            print(f'{name}: OK, type={type(items).__name__}')
    except Exception as e:
        print(f'{name}: ERROR - {e}')
