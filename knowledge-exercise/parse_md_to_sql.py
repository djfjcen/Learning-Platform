import os
import re
import json
import sys

BASE_DIR = r"d:\desktop\大三下\知识工程\code\knowledge-exercise"

def escape_sql(s):
    if s is None:
        return 'NULL'
    s = s.replace("\\", "\\\\").replace("'", "\\'").replace("\n", "\\n").replace("\r", "")
    return f"'{s}'"

def normalize_colons(text):
    return text.replace('：', ':')

def parse_knowledge_file(filepath):
    results = {'contents': [], 'codes': []}
    with open(filepath, 'r', encoding='utf-8') as f:
        text = normalize_colons(f.read())

    blocks = re.split(r'===\s*知识点\s*ID:\s*(\d+)', text)
    for i in range(1, len(blocks), 2):
        kp_id = int(blocks[i])
        body = blocks[i+1] if i+1 < len(blocks) else ''

        sections = re.split(r'##\s*(OPERATION|COMPLEXITY|CODE)', body)
        for j in range(1, len(sections), 2):
            sec_type = sections[j].strip()
            sec_body = sections[j+1] if j+1 < len(sections) else ''

            if sec_type in ('OPERATION', 'COMPLEXITY'):
                entries = re.split(r'标题:', sec_body)
                sort = 0
                for entry in entries[1:]:
                    title_match = re.match(r'\s*(.+?)(?:\n|内容:)', entry, re.DOTALL)
                    title = title_match.group(1).strip() if title_match else ''
                    content_match = re.search(r'内容:\s*(.+?)(?=\n标题:|\Z)', entry, re.DOTALL)
                    content = content_match.group(1).strip() if content_match else entry.strip()
                    if title and content:
                        results['contents'].append({
                            'knowledge_point_id': kp_id,
                            'content_type': sec_type,
                            'title': title,
                            'content': content,
                            'sort_order': sort
                        })
                        sort += 1

            elif sec_type == 'CODE':
                code_blocks = re.split(r'标题:', sec_body)
                sort = 0
                for cb in code_blocks[1:]:
                    title_match = re.match(r'\s*(.+?)(?:\n|$)', cb)
                    title = title_match.group(1).strip() if title_match else ''

                    desc_match = re.search(r'描述:\s*(.+?)(?:\n语言:)', cb, re.DOTALL)
                    desc = desc_match.group(1).strip() if desc_match else ''

                    lang_match = re.search(r'语言:\s*(.+?)(?:\n|代码:)', cb)
                    lang = lang_match.group(1).strip() if lang_match else 'C++'

                    code_match = re.search(r'代码:\s*(.+?)$', cb, re.DOTALL)
                    code = code_match.group(1).strip() if code_match else ''

                    if title and code:
                        results['codes'].append({
                            'knowledge_point_id': kp_id,
                            'title': title,
                            'description': desc if desc else None,
                            'code': code,
                            'language': lang,
                            'sort_order': sort
                        })
                        sort += 1

    return results

def parse_exercise_file(filepath):
    results = []
    with open(filepath, 'r', encoding='utf-8') as f:
        text = normalize_colons(f.read())

    blocks = re.split(r'===\s*知识点\s*ID:\s*(\d+)', text)
    for i in range(1, len(blocks), 2):
        kp_id = int(blocks[i])
        body = blocks[i+1] if i+1 < len(blocks) else ''

        exercises = re.split(r'##\s*EXERCISE', body)
        for ex_body in exercises[1:]:
            ex = {'knowledge_point_id': kp_id}

            type_m = re.search(r'题型:\s*(\S+)', ex_body)
            ex['type'] = type_m.group(1).strip() if type_m else ''

            diff_m = re.search(r'难度:\s*(\S+)', ex_body)
            ex['difficulty'] = diff_m.group(1).strip() if diff_m else ''

            cat_m = re.search(r'类别:\s*(\S+)', ex_body)
            ex['category'] = cat_m.group(1).strip() if cat_m else ''

            title_m = re.search(r'题目:\s*(.+?)(?:\n|$)', ex_body)
            ex['title'] = title_m.group(1).strip() if title_m else ''

            opts_m = re.search(r'选项:\s*(\[.+?\])', ex_body, re.DOTALL)
            ex['options'] = opts_m.group(1).strip() if opts_m else None

            ans_m = re.search(r'答案:\s*(.+?)(?:\n|$)', ex_body)
            ex['answer'] = ans_m.group(1).strip() if ans_m else ''

            analysis_m = re.search(r'解析:\s*(.+?)(?:\n##|\n---|\Z)', ex_body, re.DOTALL)
            ex['analysis'] = analysis_m.group(1).strip() if analysis_m else ''

            if ex['title'] and ex['type']:
                results.append(ex)

    return results

def parse_programming_file(filepath):
    results = []
    with open(filepath, 'r', encoding='utf-8') as f:
        text = normalize_colons(f.read())

    blocks = re.split(r'===\s*知识点\s*ID:\s*(\d+)', text)
    for i in range(1, len(blocks), 2):
        kp_id = int(blocks[i])
        body = blocks[i+1] if i+1 < len(blocks) else ''

        exercises = re.split(r'##\s*PROGRAMMING', body)
        for ex_body in exercises[1:]:
            ex = {'knowledge_point_id': kp_id, 'type': 'PROGRAMMING'}

            diff_m = re.search(r'难度:\s*(\S+)', ex_body)
            ex['difficulty'] = diff_m.group(1).strip() if diff_m else 'MEDIUM'

            cat_m = re.search(r'类别:\s*(\S+)', ex_body)
            ex['category'] = cat_m.group(1).strip() if cat_m else 'BASIC'

            title_m = re.search(r'题目:\s*(.+?)(?:\n|$)', ex_body)
            ex['title'] = title_m.group(1).strip() if title_m else ''

            desc_m = re.search(r'描述:\s*(.+?)(?=\n答案:)', ex_body, re.DOTALL)
            ex['description'] = desc_m.group(1).strip() if desc_m else ''

            ans_m = re.search(r'答案:\s*(.+?)(?=\n解析:)', ex_body, re.DOTALL)
            ex['answer'] = ans_m.group(1).strip() if ans_m else ''

            analysis_m = re.search(r'解析:\s*(.+?)(?=\n时间限制:|\n排序:|\n测试用例:|\Z)', ex_body, re.DOTALL)
            ex['analysis'] = analysis_m.group(1).strip() if analysis_m else ''

            time_m = re.search(r'时间限制:\s*(\d+)', ex_body)
            ex['time_limit'] = int(time_m.group(1)) if time_m else 60

            sort_m = re.search(r'排序:\s*(\d+)', ex_body)
            ex['sort_order'] = int(sort_m.group(1)) if sort_m else 0

            tc_m = re.search(r'测试用例:\s*(\[.+?\])\s*$', ex_body, re.DOTALL)
            if tc_m:
                raw = tc_m.group(1).strip()
                raw = re.sub(r'\n\s*', ' ', raw)
                try:
                    parsed = json.loads(raw)
                    ex['test_cases'] = json.dumps(parsed, ensure_ascii=False, separators=(',', ':'))
                except:
                    ex['test_cases'] = raw
            else:
                ex['test_cases'] = None

            if ex['title']:
                results.append(ex)

    return results

def generate_sql():
    all_contents = []
    all_codes = []
    all_exercises = []

    for fname in sorted(os.listdir(BASE_DIR)):
        if not fname.endswith('.md'):
            continue
        fpath = os.path.join(BASE_DIR, fname)
        print(f"Processing: {fname}", file=sys.stderr)

        if '知识点' in fname:
            parsed = parse_knowledge_file(fpath)
            all_contents.extend(parsed['contents'])
            all_codes.extend(parsed['codes'])
        elif '编程' in fname:
            parsed = parse_programming_file(fpath)
            all_exercises.extend(parsed)
        elif '习题' in fname or '选填' in fname:
            parsed = parse_exercise_file(fpath)
            all_exercises.extend(parsed)

    lines = []
    lines.append("SET NAMES utf8mb4;")
    lines.append("SET CHARACTER SET utf8mb4;")
    lines.append("")
    lines.append("-- 清空旧数据")
    lines.append("DELETE FROM knowledge_content WHERE id > 0;")
    lines.append("DELETE FROM code_example WHERE id > 0;")
    lines.append("DELETE FROM exercise WHERE id > 0;")
    lines.append("ALTER TABLE knowledge_content AUTO_INCREMENT = 1;")
    lines.append("ALTER TABLE code_example AUTO_INCREMENT = 1;")
    lines.append("ALTER TABLE exercise AUTO_INCREMENT = 1;")
    lines.append("")

    lines.append("-- ============================================")
    lines.append("-- knowledge_content")
    lines.append("-- ============================================")
    for c in all_contents:
        lines.append(
            f"INSERT INTO knowledge_content (knowledge_point_id, content_type, title, content, sort_order) VALUES "
            f"({c['knowledge_point_id']}, {escape_sql(c['content_type'])}, {escape_sql(c['title'])}, {escape_sql(c['content'])}, {c['sort_order']});"
        )

    lines.append("")
    lines.append("-- ============================================")
    lines.append("-- code_example")
    lines.append("-- ============================================")
    for c in all_codes:
        desc_val = escape_sql(c['description']) if c['description'] else 'NULL'
        lines.append(
            f"INSERT INTO code_example (knowledge_point_id, title, description, code, language, sort_order) VALUES "
            f"({c['knowledge_point_id']}, {escape_sql(c['title'])}, {desc_val}, {escape_sql(c['code'])}, {escape_sql(c['language'])}, {c['sort_order']});"
        )

    lines.append("")
    lines.append("-- ============================================")
    lines.append("-- exercise")
    lines.append("-- ============================================")
    for e in all_exercises:
        opts_val = escape_sql(e.get('options')) if e.get('options') else 'NULL'
        desc_val = escape_sql(e.get('description')) if e.get('description') else 'NULL'
        tc_val = escape_sql(e.get('test_cases')) if e.get('test_cases') else 'NULL'
        tl = e.get('time_limit', 60)
        so = e.get('sort_order', 0)
        lines.append(
            f"INSERT INTO exercise (knowledge_point_id, title, type, difficulty, category, options, answer, analysis, time_limit, sort_order, description, test_cases) VALUES "
            f"({e['knowledge_point_id']}, {escape_sql(e['title'])}, {escape_sql(e['type'])}, {escape_sql(e['difficulty'])}, {escape_sql(e['category'])}, {opts_val}, {escape_sql(e['answer'])}, {escape_sql(e['analysis'])}, {tl}, {so}, {desc_val}, {tc_val});"
        )

    return "\n".join(lines)

if __name__ == '__main__':
    sql = generate_sql()
    outpath = os.path.join(BASE_DIR, '..', 'data-layer', 'scripts', 'mysql', 'init_all_content.sql')
    with open(outpath, 'w', encoding='utf-8') as f:
        f.write(sql)
    print(f"SQL written to: {outpath}", file=sys.stderr)
    print(f"Contents: {len(sql)} chars", file=sys.stderr)
