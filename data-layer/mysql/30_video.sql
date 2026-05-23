-- 模块: 视频
-- 说明: 教学视频种子数据。全部使用外部 MP4 直链，便于 <video> 直接播放。

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

DELETE FROM video
WHERE video_url LIKE 'https://cdn.cs50.net/%'
   OR title IN (
     '链表头插法动画讲解',
     '二叉树递归遍历动画讲解',
     '图的邻接矩阵与邻接表对比',
     '折半查找动画演示与代码',
     '选择排序复杂度与稳定性分析',
     'B站：折半查找动画演示'
   );

INSERT INTO video (knowledge_point_id, title, description, video_url, duration, thumbnail_url, sort_order)
SELECT
  COALESCE((SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_LL_001' OR code = 'LINKED_LIST' ORDER BY CASE WHEN neo4j_id = 'KP_LL_001' THEN 0 ELSE 1 END LIMIT 1), 2),
  'CS50 Singly-Linked Lists',
  '外部直链 MP4：CS50 短视频，讲解单链表结构与基本操作。',
  'https://cdn.cs50.net/2017/fall/shorts/singly_linked_lists/singly_linked_lists-360p.mp4.download',
  NULL,
  NULL,
  1
WHERE NOT EXISTS (SELECT 1 FROM video WHERE title = 'CS50 Singly-Linked Lists' LIMIT 1);

INSERT INTO video (knowledge_point_id, title, description, video_url, duration, thumbnail_url, sort_order)
SELECT
  COALESCE((SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_TREE_002' OR code = 'BINARY_TREE' ORDER BY CASE WHEN neo4j_id = 'KP_TREE_002' THEN 0 ELSE 1 END LIMIT 1), (SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_TREE_001' OR code = 'TREE' ORDER BY CASE WHEN neo4j_id = 'KP_TREE_001' THEN 0 ELSE 1 END LIMIT 1), 5),
  'CS50 Data Structures',
  '外部直链 MP4：CS50 数据结构总览，覆盖链表、树、哈希表、栈、队列等概念。',
  'https://cdn.cs50.net/2017/fall/shorts/data_structures/data_structures-360p.mp4.download',
  NULL,
  NULL,
  2
WHERE NOT EXISTS (SELECT 1 FROM video WHERE title = 'CS50 Data Structures' LIMIT 1);

INSERT INTO video (knowledge_point_id, title, description, video_url, duration, thumbnail_url, sort_order)
SELECT
  COALESCE((SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_GRAPH_002' OR code IN ('GRAPH_REPRESENTATION', 'GRAPH_STORAGE') ORDER BY CASE WHEN neo4j_id = 'KP_GRAPH_002' THEN 0 ELSE 1 END LIMIT 1), (SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_GRAPH_001' OR code = 'GRAPH' ORDER BY CASE WHEN neo4j_id = 'KP_GRAPH_001' THEN 0 ELSE 1 END LIMIT 1), 6),
  'CS50 Data Structures: Graph Adjacent Concepts',
  '外部直链 MP4：CS50 数据结构总览，可用于图存储结构相关概念的演示入口。',
  'https://cdn.cs50.net/2017/fall/shorts/data_structures/data_structures-360p.mp4.download',
  NULL,
  NULL,
  3
WHERE NOT EXISTS (SELECT 1 FROM video WHERE title = 'CS50 Data Structures: Graph Adjacent Concepts' LIMIT 1);

INSERT INTO video (knowledge_point_id, title, description, video_url, duration, thumbnail_url, sort_order)
SELECT
  COALESCE((SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_SEARCH_003' OR code = 'BINARY_SEARCH' ORDER BY CASE WHEN code = 'BINARY_SEARCH' THEN 0 WHEN neo4j_id = 'KP_SEARCH_003' THEN 1 ELSE 2 END LIMIT 1), (SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_SEARCH_001' OR code = 'SEARCH' ORDER BY CASE WHEN code = 'SEARCH' THEN 0 WHEN neo4j_id = 'KP_SEARCH_001' THEN 1 ELSE 2 END LIMIT 1), 1),
  'CS50 Binary Search',
  '外部直链 MP4：CS50 短视频，讲解二分查找的基本思想和查找过程。',
  'https://cdn.cs50.net/2017/fall/shorts/binary_search/binary_search-360p.mp4.download',
  NULL,
  NULL,
  4
WHERE NOT EXISTS (SELECT 1 FROM video WHERE title = 'CS50 Binary Search' LIMIT 1);

INSERT INTO video (knowledge_point_id, title, description, video_url, duration, thumbnail_url, sort_order)
SELECT
  COALESCE((SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_SORT_003' OR code = 'SELECTION_SORT' ORDER BY CASE WHEN neo4j_id = 'KP_SORT_003' THEN 0 ELSE 1 END LIMIT 1), (SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_SORT_001' OR code IN ('SORT', 'SORTING') ORDER BY CASE WHEN neo4j_id = 'KP_SORT_001' THEN 0 ELSE 1 END LIMIT 1), 1),
  'CS50 Selection Sort',
  '外部直链 MP4：CS50 短视频，讲解选择排序过程和复杂度特点。',
  'https://cdn.cs50.net/2017/fall/shorts/selection_sort/selection_sort-360p.mp4.download',
  NULL,
  NULL,
  5
WHERE NOT EXISTS (SELECT 1 FROM video WHERE title = 'CS50 Selection Sort' LIMIT 1);

INSERT INTO video (knowledge_point_id, title, description, video_url, duration, thumbnail_url, sort_order)
SELECT
  COALESCE((SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_SEARCH_004' OR code = 'HASH_TABLE' ORDER BY CASE WHEN code = 'HASH_TABLE' THEN 0 WHEN neo4j_id = 'KP_SEARCH_004' THEN 1 ELSE 2 END LIMIT 1), (SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_SEARCH_001' OR code = 'SEARCH' ORDER BY CASE WHEN code = 'SEARCH' THEN 0 WHEN neo4j_id = 'KP_SEARCH_001' THEN 1 ELSE 2 END LIMIT 1), 1),
  'CS50 Hash Tables',
  '外部直链 MP4：CS50 短视频，讲解哈希表、桶和冲突处理。',
  'https://cdn.cs50.net/2017/fall/shorts/hash_tables/hash_tables-360p.mp4.download',
  NULL,
  NULL,
  6
WHERE NOT EXISTS (SELECT 1 FROM video WHERE title = 'CS50 Hash Tables' LIMIT 1);

INSERT INTO video (knowledge_point_id, title, description, video_url, duration, thumbnail_url, sort_order)
SELECT
  COALESCE((SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_LL_001' OR code = 'LINKED_LIST' ORDER BY CASE WHEN neo4j_id = 'KP_LL_001' THEN 0 ELSE 1 END LIMIT 1), 2),
  'CS50 Pointers',
  '外部直链 MP4：CS50 短视频，讲解指针基础，可辅助理解链表节点连接。',
  'https://cdn.cs50.net/2017/fall/shorts/pointers/pointers-360p.mp4.download',
  NULL,
  NULL,
  7
WHERE NOT EXISTS (SELECT 1 FROM video WHERE title = 'CS50 Pointers' LIMIT 1);

INSERT INTO video (knowledge_point_id, title, description, video_url, duration, thumbnail_url, sort_order)
SELECT
  COALESCE((SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_LL_004' OR code = 'QUEUE' ORDER BY CASE WHEN neo4j_id = 'KP_LL_004' THEN 0 ELSE 1 END LIMIT 1), 4),
  'CS50 Queues',
  '外部直链 MP4：CS50 短视频，讲解队列这种先进先出结构。',
  'https://cdn.cs50.net/2017/fall/shorts/queues/queues-360p.mp4.download',
  NULL,
  NULL,
  8
WHERE NOT EXISTS (SELECT 1 FROM video WHERE title = 'CS50 Queues' LIMIT 1);

INSERT INTO video (knowledge_point_id, title, description, video_url, duration, thumbnail_url, sort_order)
SELECT
  COALESCE((SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_LL_002' OR code = 'STACK' ORDER BY CASE WHEN neo4j_id = 'KP_LL_002' THEN 0 ELSE 1 END LIMIT 1), 3),
  'CS50 Stacks',
  '外部直链 MP4：CS50 短视频，讲解栈这种后进先出结构。',
  'https://cdn.cs50.net/2017/fall/shorts/stacks/stacks-360p.mp4.download',
  NULL,
  NULL,
  9
WHERE NOT EXISTS (SELECT 1 FROM video WHERE title = 'CS50 Stacks' LIMIT 1);

INSERT INTO video (knowledge_point_id, title, description, video_url, duration, thumbnail_url, sort_order)
SELECT
  COALESCE((SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_TREE_001' OR code = 'TREE' ORDER BY CASE WHEN neo4j_id = 'KP_TREE_001' THEN 0 ELSE 1 END LIMIT 1), 5),
  'CS50 Tries',
  '外部直链 MP4：CS50 短视频，讲解 Trie 树结构和字符串集合检索。',
  'https://cdn.cs50.net/2017/fall/shorts/tries/tries-360p.mp4.download',
  NULL,
  NULL,
  10
WHERE NOT EXISTS (SELECT 1 FROM video WHERE title = 'CS50 Tries' LIMIT 1);

INSERT INTO video (knowledge_point_id, title, description, video_url, duration, thumbnail_url, sort_order)
SELECT
  COALESCE((SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_SEARCH_003' OR code = 'BINARY_SEARCH' ORDER BY CASE WHEN code = 'BINARY_SEARCH' THEN 0 WHEN neo4j_id = 'KP_SEARCH_003' THEN 1 ELSE 2 END LIMIT 1), (SELECT id FROM knowledge_point WHERE neo4j_id = 'KP_SEARCH_001' OR code = 'SEARCH' ORDER BY CASE WHEN code = 'SEARCH' THEN 0 WHEN neo4j_id = 'KP_SEARCH_001' THEN 1 ELSE 2 END LIMIT 1), 1),
  'CS50 Linear Search',
  '外部直链 MP4：CS50 短视频，讲解线性查找，可与二分查找进行对比。',
  'https://cdn.cs50.net/2017/fall/shorts/linear_search/linear_search-360p.mp4.download',
  NULL,
  NULL,
  11
WHERE NOT EXISTS (SELECT 1 FROM video WHERE title = 'CS50 Linear Search' LIMIT 1);
