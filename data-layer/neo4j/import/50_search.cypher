// ===================== 查找模块 =====================
// 负责人: 马之涵
// 日期: 2026-05-08

CREATE (kp_search:KnowledgePoint {
  neo4j_id: 'KP_SEARCH_001',
  name: '查找',
  code: 'SEARCH',
  module: 'SEARCH',
  level: 1,
  difficulty: 'EASY',
  description: '查找是在数据集合中寻找满足条件的数据元素的过程',
  core_points: '查找定义、平均查找长度ASL、查找分类'
});

CREATE (kp_seq_search:KnowledgePoint {
  neo4j_id: 'KP_SEARCH_002',
  name: '顺序查找',
  code: 'SEQ_SEARCH',
  module: 'SEARCH',
  level: 2,
  difficulty: 'EASY',
  description: '顺序查找从表的一端开始，逐个比较关键字，适用于顺序表和链表',
  core_points: '基本思想、时间复杂度O(n)、哨兵优化'
});

CREATE (kp_bin_search:KnowledgePoint {
  neo4j_id: 'KP_SEARCH_003',
  name: '二分查找',
  code: 'BIN_SEARCH',
  module: 'SEARCH',
  level: 2,
  difficulty: 'MEDIUM',
  description: '二分查找在有序表中通过折半缩小查找范围，效率高',
  core_points: '前提条件有序、时间复杂度O(logn)、判定树'
});

CREATE (kp_hash_search:KnowledgePoint {
  neo4j_id: 'KP_SEARCH_004',
  name: '哈希查找',
  code: 'HASH_SEARCH',
  module: 'SEARCH',
  level: 3,
  difficulty: 'HARD',
  description: '哈希查找通过哈希函数将关键字映射到存储地址，实现O(1)查找',
  core_points: '哈希函数、冲突处理(开放定址/链地址法)、装填因子'
});

CREATE (kp_tree_search:KnowledgePoint {
  neo4j_id: 'KP_SEARCH_005',
  name: '树表查找',
  code: 'TREE_SEARCH',
  module: 'SEARCH',
  level: 2,
  difficulty: 'MEDIUM',
  description: '树表查找利用树形结构组织数据，包括二叉排序树查找、平衡树查找等',
  core_points: 'BST查找、AVL查找、B树查找'
});

// 查找关系
MATCH (p:KnowledgePoint {neo4j_id: 'KP_SEARCH_001'}),
      (c:KnowledgePoint {neo4j_id: 'KP_SEARCH_002'})
CREATE (p)-[:PARENT_OF {order: 1}]->(c);

MATCH (p2:KnowledgePoint {neo4j_id: 'KP_SEARCH_001'}),
      (c2:KnowledgePoint {neo4j_id: 'KP_SEARCH_003'})
CREATE (p2)-[:PARENT_OF {order: 2}]->(c2);

MATCH (p3:KnowledgePoint {neo4j_id: 'KP_SEARCH_001'}),
      (c3:KnowledgePoint {neo4j_id: 'KP_SEARCH_004'})
CREATE (p3)-[:PARENT_OF {order: 3}]->(c3);

MATCH (p4:KnowledgePoint {neo4j_id: 'KP_SEARCH_001'}),
      (c4:KnowledgePoint {neo4j_id: 'KP_SEARCH_005'})
CREATE (p4)-[:PARENT_OF {order: 4}]->(c4);

// 查找模块内关联关系
MATCH (a:KnowledgePoint {neo4j_id: 'KP_SEARCH_002'}),
      (b:KnowledgePoint {neo4j_id: 'KP_SEARCH_003'})
CREATE (a)-[:RELATED_TO {reason: '对比学习：无序或小规模用顺序查找；有序静态数据优先二分查找'}]->(b);

MATCH (a2:KnowledgePoint {neo4j_id: 'KP_SEARCH_003'}),
      (b2:KnowledgePoint {neo4j_id: 'KP_SEARCH_002'})
CREATE (a2)-[:RELATED_TO {reason: '二分查找要求有序；顺序查找无有序前提，实现更简单'}]->(b2);

MATCH (a3:KnowledgePoint {neo4j_id: 'KP_SEARCH_002'}),
      (b3:KnowledgePoint {neo4j_id: 'KP_SEARCH_004'})
CREATE (a3)-[:RELATED_TO {reason: '对比学习：顺序查找O(n)；哈希查找平均O(1)但需哈希函数与冲突处理'}]->(b3);

MATCH (a4:KnowledgePoint {neo4j_id: 'KP_SEARCH_004'}),
      (b4:KnowledgePoint {neo4j_id: 'KP_SEARCH_002'})
CREATE (a4)-[:RELATED_TO {reason: '哈希查找空间换时间；顺序查找空间开销小但时间线性增长'}]->(b4);

MATCH (a5:KnowledgePoint {neo4j_id: 'KP_SEARCH_003'}),
      (b5:KnowledgePoint {neo4j_id: 'KP_SEARCH_004'})
CREATE (a5)-[:RELATED_TO {reason: '二分依赖有序比较；哈希通过键映射定位，适用键值精确检索'}]->(b5);

MATCH (a6:KnowledgePoint {neo4j_id: 'KP_SEARCH_004'}),
      (b6:KnowledgePoint {neo4j_id: 'KP_SEARCH_005'})
CREATE (a6)-[:RELATED_TO {reason: '哈希适合高频精确查找；树表查找支持有序遍历与范围查询'}]->(b6);

MATCH (a7:KnowledgePoint {neo4j_id: 'KP_SEARCH_005'}),
      (b7:KnowledgePoint {neo4j_id: 'KP_SEARCH_004'})
CREATE (a7)-[:RELATED_TO {reason: '树表查找保持有序性；哈希查找不保证键有序'}]->(b7);

MATCH (a8:KnowledgePoint {neo4j_id: 'KP_SEARCH_005'}),
      (b8:KnowledgePoint {neo4j_id: 'KP_SEARCH_003'})
CREATE (a8)-[:RELATED_TO {reason: 'BST/AVL查找与二分查找平均均为O(logn)量级，但树结构便于动态维护'}]->(b8);
