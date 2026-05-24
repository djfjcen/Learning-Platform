import urllib.request, json

base = 'http://localhost:5173/api'

print('1. 测试知识点树 API (通过前端代理)...')
try:
    r = urllib.request.urlopen(base + '/knowledge/tree')
    tree = json.loads(r.read())['data']
    print(f'   知识点树: {len(tree)} 个模块')
except Exception as e:
    print(f'   失败: {e}')

print('2. 测试习题列表 API (通过前端代理)...')
try:
    r = urllib.request.urlopen(base + '/exercise/list?page=1&pageSize=1')
    ex = json.loads(r.read())['data']
    total = ex['total']
    print(f'   习题总数: {total}')
except Exception as e:
    print(f'   失败: {e}')

print('3. 测试知识点详情 API...')
try:
    r = urllib.request.urlopen(base + '/knowledge/7')
    detail = json.loads(r.read())['data']
    name = detail['name']
    print(f'   知识点7: {name}')
except Exception as e:
    print(f'   失败: {e}')

print()
print('=== 前端代理 API 验证完成 ===')
