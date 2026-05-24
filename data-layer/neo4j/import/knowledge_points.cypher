// ============================================
// 知识点数据 - 与 MySQL knowledge_point 表同步
// 生成日期: 2026-05-24
// ============================================

// --- 根节点 (parent_id IS NULL) ---

// 集合
CREATE (:KnowledgePoint {
  neo4j_id: 'KP_SET', name: '集合', code: 'SET',
  module: 'SET', level: 1, difficulty: 'EASY',
  description: '集合是由确定元素构成的整体，是数据结构中的基础抽象',
  core_points: '定义域、元素、隶属关系、去重语义'
});

// 线性表
CREATE (:KnowledgePoint {
  neo4j_id: 'KP_LINEAR_LIST', name: '线性表', code: 'LINEAR_LIST',
  module: 'LINEAR_LIST', level: 1, difficulty: 'MEDIUM',
  description: '线性表是n个数据元素的有限序列，包括顺序表和链表',
  core_points: '顺序存储、链式存储、插入删除操作'
});

// 树
CREATE (:KnowledgePoint {
  neo4j_id: 'KP_TREE', name: '树', code: 'TREE',
  module: 'TREE', level: 1, difficulty: 'HARD',
  description: '树是n个节点的有限集，有且仅有一个根节点',
  core_points: '二叉树、遍历、平衡树、哈夫曼树'
});

// 图
CREATE (:KnowledgePoint {
  neo4j_id: 'KP_GRAPH', name: '图', code: 'GRAPH',
  module: 'GRAPH', level: 1, difficulty: 'HARD',
  description: '图由顶点和边组成，表示多对多的关系',
  core_points: '邻接矩阵、邻接表、DFS、BFS、最短路径'
});

// 查找
CREATE (:KnowledgePoint {
  neo4j_id: 'KP_SEARCH', name: '查找', code: 'SEARCH',
  module: 'SEARCH', level: 1, difficulty: 'MEDIUM',
  description: '查找是根据关键字在数据集中寻找特定元素',
  core_points: '顺序查找、二分查找、哈希表、BST'
});

// 排序
CREATE (:KnowledgePoint {
  neo4j_id: 'KP_SORT', name: '排序', code: 'SORT',
  module: 'SORT', level: 1, difficulty: 'MEDIUM',
  description: '排序是将数据元素按关键字递增或递减排列',
  core_points: '插入排序、交换排序、选择排序、归并排序'
});

// --- 集合子节点 (parent_id = 1) ---

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_SET_REPRESENTATION', name: '集合表示法', code: 'SET_REPRESENTATION',
  module: 'SET', level: 2, difficulty: 'EASY',
  description: '常见表示方式包括列举法和描述法',
  core_points: '列举法、描述法、等价表达'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_ELEMENT_MEMBERSHIP', name: '元素隶属关系', code: 'ELEMENT_MEMBERSHIP',
  module: 'SET', level: 2, difficulty: 'EASY',
  description: '用属于与不属于描述元素和集合关系',
  core_points: '符号属于不属于、判定条件'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_SET_OPERATIONS', name: '集合运算', code: 'SET_OPERATIONS',
  module: 'SET', level: 2, difficulty: 'MEDIUM',
  description: '并集、交集、差集等集合基本运算',
  core_points: '并交差、补集、笛卡尔积'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_SET_STORAGE', name: '集合存储实现', code: 'SET_STORAGE',
  module: 'SET', level: 2, difficulty: 'HARD',
  description: '集合的顺序、链式、哈希存储实现',
  core_points: '哈希表、位图、去重策略'
});

// --- 线性表子节点 (parent_id = 2) ---

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_SEQUENTIAL_LIST', name: '顺序表', code: 'SEQUENTIAL_LIST',
  module: 'LINEAR_LIST', level: 2, difficulty: 'EASY',
  description: '用连续存储空间存储线性表元素',
  core_points: '数组实现、随机访问、插入删除O(n)'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_LINKED_LIST', name: '链表', code: 'LINKED_LIST',
  module: 'LINEAR_LIST', level: 2, difficulty: 'MEDIUM',
  description: '用指针链接存储线性表元素',
  core_points: '单链表、双向链表、循环链表'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_STACK', name: '栈', code: 'STACK',
  module: 'LINEAR_LIST', level: 2, difficulty: 'MEDIUM',
  description: '后进先出的线性表',
  core_points: '入栈出栈、表达式求值、递归'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_QUEUE', name: '队列', code: 'QUEUE',
  module: 'LINEAR_LIST', level: 2, difficulty: 'MEDIUM',
  description: '先进先出的线性表',
  core_points: '循环队列、优先队列、双端队列'
});

// --- 树子节点 (parent_id = 3) ---

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_BINARY_TREE', name: '二叉树', code: 'BINARY_TREE',
  module: 'TREE', level: 2, difficulty: 'MEDIUM',
  description: '每个节点最多有两个子节点的树',
  core_points: '满二叉树、完全二叉树、遍历'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_BST', name: '二叉搜索树', code: 'BST',
  module: 'TREE', level: 2, difficulty: 'MEDIUM',
  description: '左小右大的有序二叉树',
  core_points: '查找、插入、删除、中序遍历'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_AVL_TREE', name: '平衡二叉树', code: 'AVL_TREE',
  module: 'TREE', level: 2, difficulty: 'HARD',
  description: '左右子树高度差不超过1的BST',
  core_points: 'LL/RR/LR/RL旋转、平衡因子'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_HUFFMAN_TREE', name: '哈夫曼树', code: 'HUFFMAN_TREE',
  module: 'TREE', level: 2, difficulty: 'HARD',
  description: '带权路径长度最短的二叉树',
  core_points: '哈夫曼编码、贪心构造'
});

// --- 图子节点 (parent_id = 4) ---

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_GRAPH_REPRESENTATION', name: '图的表示', code: 'GRAPH_REPRESENTATION',
  module: 'GRAPH', level: 2, difficulty: 'MEDIUM',
  description: '邻接矩阵和邻接表两种存储方式',
  core_points: '邻接矩阵、邻接表、空间复杂度'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_GRAPH_TRAVERSAL', name: '图的遍历', code: 'GRAPH_TRAVERSAL',
  module: 'GRAPH', level: 2, difficulty: 'MEDIUM',
  description: '深度优先搜索和广度优先搜索',
  core_points: 'DFS、BFS、连通性判断'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_SHORTEST_PATH', name: '最短路径', code: 'SHORTEST_PATH',
  module: 'GRAPH', level: 2, difficulty: 'HARD',
  description: 'Dijkstra和Floyd最短路径算法',
  core_points: 'Dijkstra、Floyd、负权边'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_MST', name: '最小生成树', code: 'MST',
  module: 'GRAPH', level: 2, difficulty: 'HARD',
  description: 'Prim和Kruskal最小生成树算法',
  core_points: 'Prim、Kruskal、并查集'
});

// --- 查找子节点 (parent_id = 5) ---

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_SEQUENTIAL_SEARCH', name: '顺序查找', code: 'SEQUENTIAL_SEARCH',
  module: 'SEARCH', level: 2, difficulty: 'EASY',
  description: '从头到尾逐个比较的查找方法',
  core_points: '无序表、哨兵、O(n)'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_BINARY_SEARCH', name: '二分查找', code: 'BINARY_SEARCH',
  module: 'SEARCH', level: 2, difficulty: 'MEDIUM',
  description: '对有序表折半查找',
  core_points: '前提有序、O(logn)、变体'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_HASH_TABLE', name: '哈希表', code: 'HASH_TABLE',
  module: 'SEARCH', level: 2, difficulty: 'HARD',
  description: '基于哈希函数的快速查找结构',
  core_points: '哈希函数、冲突处理、装填因子'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_B_TREE', name: 'B树和B+树', code: 'B_TREE',
  module: 'SEARCH', level: 2, difficulty: 'HARD',
  description: '多路平衡查找树，用于磁盘索引',
  core_points: 'B树、B+树、数据库索引'
});

// --- 排序子节点 (parent_id = 6) ---

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_INSERTION_SORT', name: '插入排序', code: 'INSERTION_SORT',
  module: 'SORT', level: 2, difficulty: 'EASY',
  description: '将元素逐个插入已排序序列',
  core_points: '直接插入、折半插入、希尔排序'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_EXCHANGE_SORT', name: '交换排序', code: 'EXCHANGE_SORT',
  module: 'SORT', level: 2, difficulty: 'MEDIUM',
  description: '通过交换逆序对实现排序',
  core_points: '冒泡排序、快速排序、分区'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_SELECTION_SORT', name: '选择排序', code: 'SELECTION_SORT',
  module: 'SORT', level: 2, difficulty: 'MEDIUM',
  description: '每轮选择最小元素放到正确位置',
  core_points: '简单选择、堆排序、建堆'
});

CREATE (:KnowledgePoint {
  neo4j_id: 'KP_MERGE_SORT', name: '归并排序', code: 'MERGE_SORT',
  module: 'SORT', level: 2, difficulty: 'HARD',
  description: '分治法将序列分成子序列再合并',
  core_points: '分治、合并、稳定排序O(nlogn)'
});

// ============================================
// 关系: PARENT_OF (父节点 → 子节点)
// ============================================

// 集合 → 子节点
MATCH (a:KnowledgePoint {neo4j_id: 'KP_SET'}), (b:KnowledgePoint {neo4j_id: 'KP_SET_REPRESENTATION'}) CREATE (a)-[:PARENT_OF {order: 1}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_SET'}), (b:KnowledgePoint {neo4j_id: 'KP_ELEMENT_MEMBERSHIP'}) CREATE (a)-[:PARENT_OF {order: 2}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_SET'}), (b:KnowledgePoint {neo4j_id: 'KP_SET_OPERATIONS'}) CREATE (a)-[:PARENT_OF {order: 3}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_SET'}), (b:KnowledgePoint {neo4j_id: 'KP_SET_STORAGE'}) CREATE (a)-[:PARENT_OF {order: 4}]->(b);

// 线性表 → 子节点
MATCH (a:KnowledgePoint {neo4j_id: 'KP_LINEAR_LIST'}), (b:KnowledgePoint {neo4j_id: 'KP_SEQUENTIAL_LIST'}) CREATE (a)-[:PARENT_OF {order: 1}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_LINEAR_LIST'}), (b:KnowledgePoint {neo4j_id: 'KP_LINKED_LIST'}) CREATE (a)-[:PARENT_OF {order: 2}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_LINEAR_LIST'}), (b:KnowledgePoint {neo4j_id: 'KP_STACK'}) CREATE (a)-[:PARENT_OF {order: 3}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_LINEAR_LIST'}), (b:KnowledgePoint {neo4j_id: 'KP_QUEUE'}) CREATE (a)-[:PARENT_OF {order: 4}]->(b);

// 树 → 子节点
MATCH (a:KnowledgePoint {neo4j_id: 'KP_TREE'}), (b:KnowledgePoint {neo4j_id: 'KP_BINARY_TREE'}) CREATE (a)-[:PARENT_OF {order: 1}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_TREE'}), (b:KnowledgePoint {neo4j_id: 'KP_BST'}) CREATE (a)-[:PARENT_OF {order: 2}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_TREE'}), (b:KnowledgePoint {neo4j_id: 'KP_AVL_TREE'}) CREATE (a)-[:PARENT_OF {order: 3}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_TREE'}), (b:KnowledgePoint {neo4j_id: 'KP_HUFFMAN_TREE'}) CREATE (a)-[:PARENT_OF {order: 4}]->(b);

// 图 → 子节点
MATCH (a:KnowledgePoint {neo4j_id: 'KP_GRAPH'}), (b:KnowledgePoint {neo4j_id: 'KP_GRAPH_REPRESENTATION'}) CREATE (a)-[:PARENT_OF {order: 1}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_GRAPH'}), (b:KnowledgePoint {neo4j_id: 'KP_GRAPH_TRAVERSAL'}) CREATE (a)-[:PARENT_OF {order: 2}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_GRAPH'}), (b:KnowledgePoint {neo4j_id: 'KP_SHORTEST_PATH'}) CREATE (a)-[:PARENT_OF {order: 3}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_GRAPH'}), (b:KnowledgePoint {neo4j_id: 'KP_MST'}) CREATE (a)-[:PARENT_OF {order: 4}]->(b);

// 查找 → 子节点
MATCH (a:KnowledgePoint {neo4j_id: 'KP_SEARCH'}), (b:KnowledgePoint {neo4j_id: 'KP_SEQUENTIAL_SEARCH'}) CREATE (a)-[:PARENT_OF {order: 1}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_SEARCH'}), (b:KnowledgePoint {neo4j_id: 'KP_BINARY_SEARCH'}) CREATE (a)-[:PARENT_OF {order: 2}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_SEARCH'}), (b:KnowledgePoint {neo4j_id: 'KP_HASH_TABLE'}) CREATE (a)-[:PARENT_OF {order: 3}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_SEARCH'}), (b:KnowledgePoint {neo4j_id: 'KP_B_TREE'}) CREATE (a)-[:PARENT_OF {order: 4}]->(b);

// 排序 → 子节点
MATCH (a:KnowledgePoint {neo4j_id: 'KP_SORT'}), (b:KnowledgePoint {neo4j_id: 'KP_INSERTION_SORT'}) CREATE (a)-[:PARENT_OF {order: 1}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_SORT'}), (b:KnowledgePoint {neo4j_id: 'KP_EXCHANGE_SORT'}) CREATE (a)-[:PARENT_OF {order: 2}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_SORT'}), (b:KnowledgePoint {neo4j_id: 'KP_SELECTION_SORT'}) CREATE (a)-[:PARENT_OF {order: 3}]->(b);
MATCH (a:KnowledgePoint {neo4j_id: 'KP_SORT'}), (b:KnowledgePoint {neo4j_id: 'KP_MERGE_SORT'}) CREATE (a)-[:PARENT_OF {order: 4}]->(b);

// ============================================
// 跨模块关联 (RELATED_TO)
// ============================================

// 栈与二叉树 (递归遍历本质是栈的应用)
MATCH (a:KnowledgePoint {neo4j_id: 'KP_STACK'}), (b:KnowledgePoint {neo4j_id: 'KP_BINARY_TREE'}) CREATE (a)-[:RELATED_TO {reason: '递归遍历本质是栈的应用'}]->(b);

// BFS与队列
MATCH (a:KnowledgePoint {neo4j_id: 'KP_GRAPH_TRAVERSAL'}), (b:KnowledgePoint {neo4j_id: 'KP_QUEUE'}) CREATE (a)-[:RELATED_TO {reason: 'BFS实现需要队列'}]->(b);

// 二分查找与排序 (二分查找要求数据有序)
MATCH (a:KnowledgePoint {neo4j_id: 'KP_BINARY_SEARCH'}), (b:KnowledgePoint {neo4j_id: 'KP_SORT'}) CREATE (a)-[:RELATED_TO {reason: '二分查找要求数据有序'}]->(b);

// B树与查找
MATCH (a:KnowledgePoint {neo4j_id: 'KP_B_TREE'}), (b:KnowledgePoint {neo4j_id: 'KP_BST'}) CREATE (a)-[:RELATED_TO {reason: '同为树形查找结构'}]->(b);

// 哈希表与集合
MATCH (a:KnowledgePoint {neo4j_id: 'KP_HASH_TABLE'}), (b:KnowledgePoint {neo4j_id: 'KP_SET_STORAGE'}) CREATE (a)-[:RELATED_TO {reason: '哈希表是集合的常见实现'}]->(b);
