# 06 — Context & Memory

An agent has no memory between sessions. This chapter is about giving it one — two
layers of it: **`AGENTS.md`** (how we work) and **skills** (procedural memory that
loads only when relevant).

---

## Layer 1: `AGENTS.md` — the always-loaded contract

`AGENTS.md` is read by the agent at the start of every session. It is the
**constitution**: the rules, the conventions, the commands, the things that must
never happen.

Keep it **short and high-signal**. It's injected into every session, so every line
costs attention. It is not the place for detail — that's what `docs/` and skills are for.

What belongs in `AGENTS.md`:

- **The workflow** (plan gate, commit rules) — the non-negotiables.
- **Key commands** — build, test, run, deploy. The ones an agent needs constantly.
- **Conventions** — naming, style, commit identity, language.
- **Hard rules** — "never run `docker compose down -v`", "never commit `.env`".
- **Pointers** — "read `HANDOFF.md` first", "load skill X before touching Y".

What does **not** belong: long explanations, history, anything task-specific. Those
live in `docs/` or logs.

> **Portability note:** `AGENTS.md` is a cross-tool convention (Codex, Cursor,
> OpenCode, and others read it). Some tools also read a tool-specific file
> (`CLAUDE.md`, `.cursorrules`, etc.). Keep the tool-specific file as a thin pointer
> to `AGENTS.md`, or keep them in sync — never let them disagree.

See [`templates/AGENTS.md.template`](../templates/AGENTS.md.template).

---

## Layer 2: Skills — procedural memory, loaded on demand

`AGENTS.md` is always loaded, so it must stay small. But some knowledge is large and
only relevant sometimes — how to do a database backfill, how to deploy the frontend,
how to handle a specific tricky API. That's a **skill**.

A skill is a document the agent loads **only when the task matches**. It holds:

- **Trigger** — when this skill applies (its description starts with "Use when…").
- **Procedure** — the steps, in order.
- **Pitfalls** — the traps, learned the hard way.
- **References** — deeper files, loaded only if needed.

This is the difference between an agent that re-derives the same hard-won knowledge
every session and one that *remembers* it.

### Writing a skill that's actually useful

- **Write lessons, not logs.** "Cron's PATH is only `/usr/bin:/bin`, so a tool in
  `~/.local/bin` is invisible — put it on PATH in the script" — not "on Tuesday we
  hit a bug."
- **One rule per lesson.** Imperative, with the *why*.
- **Name the trigger in the first line.** The agent needs to know when to load it.
- **Update it when you learn something.** A skill that never changes is dead weight.

See [`templates/SKILL.md.template`](../templates/SKILL.md.template).

---

## The memory hierarchy

```
AGENTS.md          always loaded    → how we work (short, high-signal)
HANDOFF.md         read first       → where we are now
skills/            loaded on match  → how to do specific things (procedural)
docs/              read as needed   → deep explanation
logs/ + plans/     read for detail  → the history and reasoning
```

Each layer has a job. Don't put a skill's content in `AGENTS.md` (it'd bloat every
session); don't put always-needed rules in a skill (they might not load).

---

## Why this beats "just use a bigger context window"

A bigger window helps within a session. It does nothing across sessions. The moment
the session ends, everything in that window is gone — no matter how big it was.

Persistent files are the only memory that survives a session boundary. That's why
`AGENTS.md`, `HANDOFF.md`, skills, plans, and logs matter more than context size.

> The model is the CPU. The repo is the disk. Don't expect the CPU to remember what
> only the disk can store.

---

## Practical rules

- **Keep `AGENTS.md` under a page or two.** If it grows, move detail to a skill.
- **Every session, the agent reads `AGENTS.md` + `HANDOFF.md` first.** Make that the
  documented start.
- **When you learn a lesson, write it to a skill immediately.** Knowledge not written
  down is knowledge you'll pay for again.
- **Prune.** Skills and memory entries that are stale or redundant are worse than
  absent — they mislead. Delete or update.

---

**Next:** [07 — Security Baseline](07-security-baseline.md)
