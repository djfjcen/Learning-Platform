SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

INSERT INTO knowledge_point (neo4j_id, name, code, parent_id, module, level, difficulty, description, core_points) VALUES
(NULL, '集合', 'SET', NULL, '集合', 1, 'EASY', '集合是由确定元素构成的整体，是数据结构中的基础抽象', '定义域、元素、隶属关系、去重语义'),
(NULL, '线性表', 'LINEAR_LIST', NULL, '线性表', 1, 'MEDIUM', '线性表是n个数据元素的有限序列，包括顺序表和链表', '顺序存储、链式存储、插入删除操作'),
(NULL, '树', 'TREE', NULL, '树', 1, 'HARD', '树是n个节点的有限集，有且仅有一个根节点', '二叉树、遍历、平衡树、哈夫曼树'),
(NULL, '图', 'GRAPH', NULL, '图', 1, 'HARD', '图由顶点和边组成，表示多对多的关系', '邻接矩阵、邻接表、DFS、BFS、最短路径'),
(NULL, '查找', 'SEARCH', NULL, '查找', 1, 'MEDIUM', '查找是根据关键字在数据集中寻找特定元素', '顺序查找、二分查找、哈希表、BST'),
(NULL, '排序', 'SORT', NULL, '排序', 1, 'MEDIUM', '排序是将数据元素按关键字递增或递减排列', '插入排序、交换排序、选择排序、归并排序');

INSERT INTO knowledge_point (neo4j_id, name, code, parent_id, module, level, difficulty, description, core_points) VALUES
(NULL, '集合表示法', 'SET_REPRESENTATION', 1, '集合', 2, 'EASY', '常见表示方式包括列举法和描述法', '列举法、描述法、等价表达'),
(NULL, '元素隶属关系', 'ELEMENT_MEMBERSHIP', 1, '集合', 2, 'EASY', '用属于与不属于描述元素和集合关系', '符号属于不属于、判定条件'),
(NULL, '集合运算', 'SET_OPERATIONS', 1, '集合', 2, 'MEDIUM', '并集、交集、差集等集合基本运算', '并交差、补集、笛卡尔积'),
(NULL, '集合存储实现', 'SET_STORAGE', 1, '集合', 2, 'HARD', '集合的顺序、链式、哈希存储实现', '哈希表、位图、去重策略'),
(NULL, '顺序表', 'SEQUENTIAL_LIST', 2, '线性表', 2, 'EASY', '用连续存储空间存储线性表元素', '数组实现、随机访问、插入删除O(n)'),
(NULL, '链表', 'LINKED_LIST', 2, '线性表', 2, 'MEDIUM', '用指针链接存储线性表元素', '单链表、双向链表、循环链表'),
(NULL, '栈', 'STACK', 2, '线性表', 2, 'MEDIUM', '后进先出的线性表', '入栈出栈、表达式求值、递归'),
(NULL, '队列', 'QUEUE', 2, '线性表', 2, 'MEDIUM', '先进先出的线性表', '循环队列、优先队列、双端队列'),
(NULL, '二叉树', 'BINARY_TREE', 3, '树', 2, 'MEDIUM', '每个节点最多有两个子节点的树', '满二叉树、完全二叉树、遍历'),
(NULL, '二叉搜索树', 'BST', 3, '树', 2, 'MEDIUM', '左小右大的有序二叉树', '查找、插入、删除、中序遍历'),
(NULL, '平衡二叉树', 'AVL_TREE', 3, '树', 2, 'HARD', '左右子树高度差不超过1的BST', 'LL/RR/LR/RL旋转、平衡因子'),
(NULL, '哈夫曼树', 'HUFFMAN_TREE', 3, '树', 2, 'HARD', '带权路径长度最短的二叉树', '哈夫曼编码、贪心构造'),
(NULL, '图的表示', 'GRAPH_REPRESENTATION', 4, '图', 2, 'MEDIUM', '邻接矩阵和邻接表两种存储方式', '邻接矩阵、邻接表、空间复杂度'),
(NULL, '图的遍历', 'GRAPH_TRAVERSAL', 4, '图', 2, 'MEDIUM', '深度优先搜索和广度优先搜索', 'DFS、BFS、连通性判断'),
(NULL, '最短路径', 'SHORTEST_PATH', 4, '图', 2, 'HARD', 'Dijkstra和Floyd最短路径算法', 'Dijkstra、Floyd、负权边'),
(NULL, '最小生成树', 'MST', 4, '图', 2, 'HARD', 'Prim和Kruskal最小生成树算法', 'Prim、Kruskal、并查集'),
(NULL, '顺序查找', 'SEQUENTIAL_SEARCH', 5, '查找', 2, 'EASY', '从头到尾逐个比较的查找方法', '无序表、哨兵、O(n)'),
(NULL, '二分查找', 'BINARY_SEARCH', 5, '查找', 2, 'MEDIUM', '对有序表折半查找', '前提有序、O(logn)、变体'),
(NULL, '哈希表', 'HASH_TABLE', 5, '查找', 2, 'HARD', '基于哈希函数的快速查找结构', '哈希函数、冲突处理、装填因子'),
(NULL, 'B树和B+树', 'B_TREE', 5, '查找', 2, 'HARD', '多路平衡查找树，用于磁盘索引', 'B树、B+树、数据库索引'),
(NULL, '插入排序', 'INSERTION_SORT', 6, '排序', 2, 'EASY', '将元素逐个插入已排序序列', '直接插入、折半插入、希尔排序'),
(NULL, '交换排序', 'EXCHANGE_SORT', 6, '排序', 2, 'MEDIUM', '通过交换逆序对实现排序', '冒泡排序、快速排序、分区'),
(NULL, '选择排序', 'SELECTION_SORT', 6, '排序', 2, 'MEDIUM', '每轮选择最小元素放到正确位置', '简单选择、堆排序、建堆'),
(NULL, '归并排序', 'MERGE_SORT', 6, '排序', 2, 'HARD', '分治法将序列分成子序列再合并', '分治、合并、稳定排序O(nlogn)');
