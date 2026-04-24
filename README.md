# Low Context Memory

A lightweight Codex skill that reduces context-window pressure by storing durable project state in files instead of long chat history.

This skill scaffolds a compact memory structure (`conductor/` + daily logs), provides concise update templates, and encourages checkpoint-based handoff so work can continue smoothly across sessions.

## What it solves

- Chat context fills up during long projects
- Important decisions get buried in conversation history
- Session handoff is slow and repetitive
- Teams need a consistent "state log" format

## Key features

- Idempotent setup script for memory scaffold
- Compact templates for progress, decisions, next actions, and risks
- Session checkpoint format for context compression
- Minimal-read workflow (only load essential state files)

## Repository structure

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

## Install

Copy this folder into your Codex skills directory:

```powershell
# Windows
Copy-Item -Path .\low-context-memory -Destination "$HOME\.codex\skills\" -Recurse -Force
```

Or clone directly into the skills directory:

```powershell
git clone https://github.com/sighworld/low-context-memory.git "$HOME\.codex\skills\low-context-memory"
```

## Usage

In a Codex session, ask to use the skill:

```text
使用$low-context-memory
```

Then initialize the project scaffold:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init_low_context_memory.ps1 -Workspace <project-root>
```

Generated files:

- `conductor/product.md`
- `conductor/tech-stack.md`
- `conductor/workflow.md`
- `conductor/tracks.md`
- `memory/logs/YYYY-MM-DD.md`

## Recommended workflow

1. At session start, read only:
   - `conductor/tracks.md`
   - today's log in `memory/logs/`
2. During work, append short milestone entries.
3. Before ending session, write one compact checkpoint.

## License

MIT (add a LICENSE file if you want to formalize distribution terms).
