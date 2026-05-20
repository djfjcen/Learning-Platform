// ===================== 跨模块关联关系 =====================
// 此文件存放涉及多个知识模块的关联关系
// 必须在所有模块文件之后执行

// 查找与树的关联
MATCH (a:KnowledgePoint {neo4j_id: 'KP_SEARCH_005'}),
      (b:KnowledgePoint {neo4j_id: 'KP_TREE_004'})
CREATE (a)-[:RELATED_TO {reason: '树表查找基于二叉排序树'}]->(b);

MATCH (a2:KnowledgePoint {neo4j_id: 'KP_SEARCH_005'}),
      (b2:KnowledgePoint {neo4j_id: 'KP_TREE_007'})
CREATE (a2)-[:RELATED_TO {reason: 'B树用于数据库索引查找'}]->(b2);

// 排序与堆的关联
MATCH (a3:KnowledgePoint {neo4j_id: 'KP_SORT_008'}),
      (b3:KnowledgePoint {neo4j_id: 'KP_TREE_001'})
CREATE (a3)-[:RELATED_TO {reason: '堆排序基于完全二叉树结构'}]->(b3);

// 栈与递归
MATCH (a4:KnowledgePoint {neo4j_id: 'KP_LL_002'}),
      (b4:KnowledgePoint {neo4j_id: 'KP_TREE_003'})
CREATE (a4)-[:RELATED_TO {reason: '递归遍历本质是栈的应用'}]->(b4);

// BFS与队列
MATCH (a5:KnowledgePoint {neo4j_id: 'KP_GRAPH_004'}),
      (b5:KnowledgePoint {neo4j_id: 'KP_LL_004'})
CREATE (a5)-[:RELATED_TO {reason: 'BFS实现需要队列辅助'}]->(b5);

// 二分查找与排序
MATCH (a6:KnowledgePoint {neo4j_id: 'KP_SEARCH_003'}),
      (b6:KnowledgePoint {neo4j_id: 'KP_SORT_001'})
CREATE (a6)-[:RELATED_TO {reason: '二分查找要求数据有序，排序是前提'}]->(b6);

// 顺序查找与链表
MATCH (a7:KnowledgePoint {neo4j_id: 'KP_SEARCH_002'}),
      (b7:KnowledgePoint {neo4j_id: 'KP_LL_003'})
CREATE (a7)-[:RELATED_TO {reason: '链表不支持随机访问，顺序扫描是最自然的查找方式'}]->(b7);

// 哈希查找与集合哈希存储
MATCH (a8:KnowledgePoint {neo4j_id: 'KP_SEARCH_004'}),
      (b8:KnowledgePoint {neo4j_id: 'KP_SET_010'})
CREATE (a8)-[:RELATED_TO {reason: '哈希查找与哈希集合实现共用哈希函数与冲突处理思想'}]->(b8);

// 树表查找与 AVL 平衡树
MATCH (a9:KnowledgePoint {neo4j_id: 'KP_SEARCH_005'}),
      (b9:KnowledgePoint {neo4j_id: 'KP_TREE_005'})
CREATE (a9)-[:RELATED_TO {reason: '平衡二叉树查找依赖 AVL 旋转维持树高，保证查找稳定 O(logn)'}]->(b9);

// 哈希集合与查找总论
MATCH (a10:KnowledgePoint {neo4j_id: 'KP_SET_010'}),
      (b10:KnowledgePoint {neo4j_id: 'KP_SEARCH_001'})
CREATE (a10)-[:RELATED_TO {reason: '哈希集合的快速成员查询是查找问题在集合场景下的典型实现'}]->(b10);
