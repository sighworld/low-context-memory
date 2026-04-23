---
name: low-context-memory
description: Scaffold and maintain low-context project memory (conductor + daily logs) to reduce chat context bloat and preserve session continuity. Use when users ask for memory optimization, context compression, project handoff, or progress tracking.
---

# Low Context Memory

## Overview

Use this skill to keep durable project state in files instead of chat history.
It reduces context-window pressure by storing decisions, status, and next actions in a compact structure.

## When To Use

- User says context window is filling too quickly.
- User wants "remember what we did" across sessions.
- User needs a repeatable project handoff or daily progress log.
- Work is multi-step and likely to continue in future sessions.

## One-Time Setup

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init_low_context_memory.ps1 -Workspace <project-root>
```

This creates:

- `conductor/product.md`
- `conductor/tech-stack.md`
- `conductor/workflow.md`
- `conductor/tracks.md`
- `memory/logs/YYYY-MM-DD.md` (today)

## Working Rules (Low-Context Mode)

1. Keep canonical state in files, not in chat.
2. Write short entries only; avoid long narrative logs.
3. Update at milestones only (task done, decision made, blocker found).
4. Read minimally at session start:
  - `conductor/tracks.md`
  - today's `memory/logs/YYYY-MM-DD.md`
  - only the single track file you will work on next

## Entry Templates

Use this daily log block:

```markdown
## HH:MM - <topic>
- Done: <one line>
- Decision: <one line>
- Next: <one line>
- Risk: <optional one line>
```

Use this track line format in `conductor/tracks.md`:

```markdown
- [ ] <track-id> | scope:<short> | owner:<name> | next:<one action>
```

When completed:

```markdown
- [x] <track-id> | completed:YYYY-MM-DD | outcome:<one line>
```

## Session Checkpoint (Context Compression)

At natural pauses or before ending a session, append a compact checkpoint:

```markdown
## Checkpoint
- Current objective: <one line>
- Current state: <one line>
- Next action: <one line>
- Open risks: <one line or "none">
```

Then keep chat recap short and point to updated files.

## Resources (optional)

### scripts/
Use `scripts/init_low_context_memory.ps1` to scaffold the memory structure idempotently.

### references/
Use `references/checklist.md` for a short operating checklist.
