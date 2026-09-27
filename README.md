# Agentic Vibe Framework

**Structured workflow for building real software with AI coding agents — without the spaghetti.**

Vibe coding (telling an AI what you want and letting it build) is fast. It is also
how most people end up with a codebase nobody understands, decisions nobody can
trace, and an AI that forgets everything the moment you open a new session.

This framework is the fix. It is a small set of **documents, templates, and habits**
that turn "chat with an AI" into a repeatable engineering process — one that survives
a new chat, a new model, a new machine, or a new teammate.

It is **not** a library, a CLI, or a magic prompt. It is a **method**, plus the files
that make the method stick.

---

## The problem this solves

Every one of these actually happened while building a real, live product with an AI agent:

| Problem | What it cost | The fix in this framework |
|---|---|---|
| The AI forgets everything between sessions | Re-discovering the codebase from zero, every time | [`HANDOFF.md`](docs/05-handoff.md) |
| Plans live in chat and vanish | Decisions can't be reviewed or revisited | [`plans/`](docs/02-planning.md) |
| Docs silently rot | A new agent is actively misled (a README said "Windows" on a Linux server) | Doc-rot rules, handoff discipline |
| Switching models means starting over | All accumulated context is lost | [`AGENTS.md`](docs/09-model-agnostic.md) |
| The AI claims "done" when it isn't | Bugs ship | Verify every claim yourself |
| No audit trail | Nobody knows *why* the code looks like this | [`logs/`](docs/04-logging.md) |
| Scope creep | The project becomes chaos | [Backlog with reasons & triggers](docs/03-roadmap-and-backlog.md) |

---

## The core idea

> **The model is fast but has no memory. The structure is the memory.**

You don't get good results by finding a smarter model. You get them by giving any
model a **place to read from** and a **place to write to** — so that context lives
in the repo, not in a chat window that will be gone tomorrow.

```
Plan → Approve → Implement → Test → Log → Commit
```

Six steps. One hard gate (the **plan gate**: the AI stops and waits for your explicit
approval before writing code — silence is *not* approval). The artifact trail is
committed to the repo, so the reasoning is inspectable without the chat history.

---

## Start here (5 minutes)

1. **Read the philosophy** — [docs/00-philosophy.md](docs/00-philosophy.md).
   It's short and it's the whole point.
2. **Skim the workflow** — [docs/01-the-workflow.md](docs/01-the-workflow.md).
3. **Copy the templates** into your project (templates carry a `.template` suffix so
   the framework repo's own tooling never mistakes them for active files — rename
   them on copy):
   ```bash
   # manual copy
   cp templates/AGENTS.md.template   /path/to/your-project/AGENTS.md
   cp templates/CLAUDE.md.template   /path/to/your-project/CLAUDE.md
   cp templates/HANDOFF.md.template  /path/to/your-project/HANDOFF.md
   cp templates/README.md.template   /path/to/your-project/README.md
   mkdir -p /path/to/your-project/plans /path/to/your-project/logs
   cp templates/plan.md.template     /path/to/your-project/plans/0000-template.md
   cp templates/log.md.template      /path/to/your-project/logs/0000-00-00_template.md
   cp templates/ROADMAP.md.template  /path/to/your-project/plans/ROADMAP.md
   cp templates/BACKLOG.md.template  /path/to/your-project/plans/BACKLOG.md
   ```
   Or run the optional helper (does the same thing, safely — never overwrites):
   ```bash
   bash bootstrap.sh /path/to/your-project
   ```
4. **Fill in `HANDOFF.md`** — this is the file every future session (and every
   new model) reads first.
5. **Work.** Plan before code. Log after. Commit the trail.

---

## What's in here

| Path | What it is |
|---|---|
| [`docs/`](docs/) | The methodology — 11 short chapters, from philosophy to anti-patterns |
| [`templates/`](templates/) | Copy-paste files (stored as `*.template`, renamed on copy): `AGENTS.md`, `CLAUDE.md`, `HANDOFF.md`, `README.md`, `plan.md`, `log.md`, `ROADMAP.md`, `BACKLOG.md`, `SKILL.md` |
| [`examples/stock-agent/`](examples/stock-agent/) | A **real** case study — the actual plan/log/roadmap/handoff from a live product, sanitized |

### The chapters

| # | Chapter | Why it matters |
|---|---|---|
| 00 | [Philosophy](docs/00-philosophy.md) | The principles everything else follows from |
| 01 | [The Workflow](docs/01-the-workflow.md) | Plan → Approve → Implement → Test → Log → Commit |
| 02 | [Planning](docs/02-planning.md) | How to write a plan that actually prevents chaos |
| 03 | [Roadmap & Backlog](docs/03-roadmap-and-backlog.md) | One source of truth; deferred ideas with reasons |
| 04 | [Logging](docs/04-logging.md) | The audit trail that makes decisions reviewable |
| 05 | [Handoff](docs/05-handoff.md) | Change model or machine without losing context |
| 06 | [Context & Memory](docs/06-context-and-memory.md) | `AGENTS.md` + skills as procedural memory |
| 07 | [Security Baseline](docs/07-security-baseline.md) | The checklist that keeps you from shipping a hole |
| 08 | [Working with Agents](docs/08-working-with-agents.md) | Parallel delegation — and why you verify every claim |
| 09 | [Model-Agnostic](docs/09-model-agnostic.md) | Stay portable across Codex, Cursor, Claude, OpenCode… |
| 10 | [Anti-Patterns](docs/10-anti-patterns.md) | The mistakes, collected so you don't repeat them |

---

## Works with the tools you already use

This framework is **tool-agnostic**. It leans on `AGENTS.md`, a convention read by
Codex, Cursor, OpenCode, Claude Code (via `CLAUDE.md`), Gemini CLI, and others.
The same repo works whether you drive it from a terminal agent, an IDE plugin, or a
chat model. Change tools; keep the context.

---

## Who this is for

- **Solo builders** shipping a real product with an AI agent.
- **Small teams** where the AI is a collaborator and the reasoning needs to be shared.
- **Anyone** who has felt the pain of "the AI forgot again" or "I don't know why this
  code is like this."

You do **not** need this for a throwaway script. You need it the moment the project
has to survive more than one session.

---

## Contributing

Ideas, fixes, and war stories are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md).
The best contributions are **lessons from real projects**, not theory.

---

## License

[MIT](LICENSE) © 2026 invesbotid
