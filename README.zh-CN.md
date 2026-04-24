# Low Context Memory

[English](./README.md) | [简体中文](./README.zh-CN.md)

一个轻量的 Codex skill。它把项目长期状态从聊天记录转移到结构化文件中，减少上下文窗口占用。

该 skill 会初始化紧凑的记忆结构（`conductor/` + 每日日志），提供简洁的进度记录模板，并通过会话检查点实现低成本跨会话续接。

## 解决的问题

- 长项目中聊天上下文很快被占满
- 关键决策淹没在历史对话里
- 会话交接慢且重复
- 团队缺少统一的“状态记录”格式

## 核心能力

- 幂等初始化脚本，一键生成记忆骨架
- 紧凑模板，记录进度、决策、下一步与风险
- 会话检查点格式，用于上下文压缩
- 最小读取工作流（只加载必要状态文件）

## 仓库结构

```text
.
├── SKILL.md
├── agents/
│   └── openai.yaml
├── scripts/
│   └── init_low_context_memory.ps1
└── references/
    └── checklist.md
```

## 安装

把本目录复制到 Codex skills 目录：

```powershell
# Windows
Copy-Item -Path .\low-context-memory -Destination "$HOME\.codex\skills\" -Recurse -Force
```

或直接克隆到 skills 目录：

```powershell
git clone https://github.com/sighworld/low-context-memory.git "$HOME\.codex\skills\low-context-memory"
```

## 使用

在 Codex 会话中触发 skill：

```text
使用$low-context-memory
```

然后初始化项目记忆结构：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init_low_context_memory.ps1 -Workspace <project-root>
```

生成文件：

- `conductor/product.md`
- `conductor/tech-stack.md`
- `conductor/workflow.md`
- `conductor/tracks.md`
- `memory/logs/YYYY-MM-DD.md`

## 推荐工作流

1. 会话开始时只读取 `conductor/tracks.md` 与当日日志 `memory/logs/`。
2. 工作过程中仅在里程碑节点追加短记录。
3. 会话结束前写一条紧凑 checkpoint。

## 许可

MIT（如需正式分发，建议补充 LICENSE 文件）。
