# CLAUDE.md

本文档为 Claude Code (claude.ai/code) 提供本仓库的工作指导。

## 项目概述

基于 Spring Boot 的《数据结构》课程智慧学习平台后端。采用双数据库架构：MySQL 存储结构化数据，Neo4j 存储知识图谱。

## 构建与运行

- **构建**: `mvn clean package`
- **运行**: `mvn spring-boot:run` 或直接运行 `LearningPlatformApplication`
- **运行测试**: `mvn test`
- **运行单个测试**: `mvn test -Dtest=ClassName`
- **API 基础地址**: `http://localhost:8080/api`

## 开发环境

- JDK 17+
- Maven 3.6+
- MySQL 8.0+（运行 `data-layer/scripts/mysql/init.sql` 初始化）
- Neo4j 5.0+（bolt://localhost:17687）

数据库凭据硬编码在 `application.yml` 中（MySQL root/123456，Neo4j neo4j/neo4j123）。

## 架构

### 双数据库
- **MySQL**: 存储用户、习题、学习进度、内容、视频、AI 对话记录等结构化数据。通过 **MyBatis Plus** 访问。
- **Neo4j**: 存储知识图谱节点和关系。通过 **`Neo4jClient`** 直接执行 Cypher 查询（见 `service/GraphService.java`），非 Spring Data Neo4j Repository 模式。

### 代码约定
- **Controllers** 统一返回 `Result<T>`（`common/Result.java`），包装 `code`、`message`、`data`。全局异常由 `common/GlobalExceptionHandler.java` 处理，业务异常使用 `common/BusinessException.java`。
- **Entities** 继承 `BaseEntity`，自动提供 `createTime`、`updateTime`。逻辑删除在 `BaseEntity` 中通过 `@TableLogic` 统一标注 `deleted` 字段。
- **MyBatis Plus 自动填充**: `config/MyMetaObjectHandler` 在插入时自动设置 `createTime`，在插入/更新时自动设置 `updateTime`。
- **Mapper 扫描**: 无全局 `@MapperScan`，每个 Mapper 接口独立标注 `@Mapper`。
- **参数校验**: 使用 `spring-boot-starter-validation`，Controller 层配合 `@Validated` + `@Valid` 使用。
- **JSON 处理**: 使用 Fastjson2。
- **Lombok**: 广泛用于实体类和 DTO 简化样板代码。

### 包结构
- `controller/` — REST 控制器，基础路径 `/api`
- `service/` — 业务逻辑
- `repository/` — MyBatis Plus Mapper 接口
- `entity/` — 实体类
- `dto/` — 请求/响应数据传输对象
- `config/` — Spring 配置类
- `common/` — 公共类（`Result<T>`、`BusinessException`、`GlobalExceptionHandler`）

### 独立 Python AI 服务
`src/python/AIchat/` 提供独立的 AI 对话后端（FastAPI + Uvicorn）：
- 默认监听 `0.0.0.0:9000`
- 已接入通义千问 / DeepSeek（OpenAI 兼容 API）
- 支持 AI 问答、代码分析、代码生成
- 依赖 `ai_chat` 表存储多轮对话上下文
- 配置方式：复制 `config/apikeys.example.json` 为 `config/apikeys.local.json` 并填写 Key

### 已实现模块

后端已实现 7 个 Controller：
- **UserController** — 用户管理
- **KnowledgePointController** — 知识点管理、树形结构、内容与代码示例
- **ExerciseController** — 习题 CRUD、答题提交、错题记录
- **CodeController** — 代码执行与提交（通过 Piston API 运行 C/C++/Python）
- **VideoController** — 视频列表、详情、观看记录
- **StatisticsController** — 学习统计与分析（进度、掌握度、趋势、薄弱点）
- **GraphController** — 知识图谱可视化（Neo4j）

前端（`frontend/`）基于 Vue 3 + Vite + Element Plus + Pinia，已包含：首页、知识图谱、学习目录、知识点详情、习题模块、统计页面、AI 对话、视频播放、代码操场等视图。

## 协作规范

本项目为多人协作项目，请遵守以下规则以保持代码库一致性。

### 开工前必读
- 阅读 `docs/项目架构.md` 了解当前架构和 TODO 清单。
- 阅读 `docs/分工.md` 了解各模块负责人。
- 阅读 `docs/要求.md` 了解完整功能需求。

### 代码改动
- **改动最小化**：只改需要的部分，不重构无关代码。
- **Fail fast**：让异常自然冒泡，不要 catch 后静默忽略。
- 不写假设性防御代码（"万一将来需要" 的 guard clause）。在系统边界（用户输入、外部 API）做验证，内部代码信任调用方。
- 遵循现有包结构和命名规范。

### 文档同步
- **新增或修改表结构时**，同步更新 `data-layer/scripts/mysql/init.sql`。
- **做出架构决策或解决 TODO 项时**，同步更新 `docs/项目架构.md`。
- **模块负责人变更时**，同步更新 `docs/分工.md`。
- **API 契约变更时**，在 PR 描述中说明，以便前端负责人调整。
- **所有文档使用中文编写**（代码和注释除外）。

### Git 工作流
- 在自己的 `feature/<模块>-<描述>` 分支上开发。
- 完成后向 `main` 分支发起 Pull Request；PR 需要至少一次 review 才能合并。
- 禁止向 `main` 分支 force-push。

### 测试
- 提交 PR 前运行 `mvn test`。
- 新增接口后，用 `curl` 或本地请求手动验证。

## 文档索引

项目文档位于 `docs/` 目录下，均为中文。核心文档：
- `docs/要求.md` — 需求文档
- `docs/分工.md` — 团队分工
- `docs/项目架构.md` — 架构说明（含待确定 TODO 清单）
- `docs/API接口规范.md` — API 接口规范
- `docs/数据库交互契约.md` — 数据库交互约定
- `docs/数据层协同规范.md` — 数据层协作规范
- `docs/待补充能力清单.md` — 关键能力缺口
- `docs/可参考项目.md` — 参考项目分析

各模块说明文档：`习题模块说明.md`、`代码实现与在线运行模块.md`、`学习统计模块说明.md`、`知识图谱可视化.md`、`学习目录功能总结.md`、`视频讲解联调清单.md`、`前端框架使用指南.md` 等。
