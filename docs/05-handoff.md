# 05 — Handoff

`HANDOFF.md` is the single most important file for surviving a context reset — a new
session, a new model, a new machine, or a teammate joining. It answers, in one
document: **what is this, where does it run, what's the current state, and where
should I start?**

If a fresh agent reads nothing else, it reads this. Write it for that agent.

---

## Why it exists

Every time a session ends, the agent's memory of the project dies with it. The next
session starts blank. Without a handoff file, it re-discovers everything from zero:
re-reads the codebase, re-asks what's done, re-finds the pitfalls you already hit.

That re-discovery is pure waste — and worse, it's *unreliable*, because the agent
will guess where it doesn't know.

`HANDOFF.md` converts "start from zero" into "start from here."

---

## What goes in it

A good handoff is written for a competent stranger who knows nothing about your
project. Include:

1. **60-second overview** — what the product is, who it's for, is it live.
2. **Infrastructure map** — where it runs, what the pieces are, ports, how it's exposed.
   (This is where newcomers get lost: "which port is the frontend again?")
3. **How we work** — the workflow, the rules, the conventions (or a link to `AGENTS.md`).
4. **Current status** — roadmap state, key numbers, what's deployed.
5. **Open risks / blockers** — what's broken, what needs a human, what's waiting.
6. **File map** — "where do I find X."
7. **First steps** — a concrete checklist for the new session.
8. **Known pitfalls** — the traps that already bit you.

See [`templates/HANDOFF.md.template`](../templates/HANDOFF.md.template).

---

## The doc-rot rule

**A handoff that's stale is worse than no handoff, because it actively misleads.**

This is not hypothetical. In the case study, the README and working-agreement files
had drifted so far that a new agent would be told the project ran on **Windows**, with
a **local virtualenv**, and a **portable Postgres** — while it actually ran on a
**Linux server in Docker**. Every one of those "facts" would send the agent down the
wrong path.

The rule: **when reality changes, the handoff changes in the same session.** Make it
part of the definition of done. A task isn't finished if it made the handoff wrong.

> Practical check: at the end of a session, ask "did anything I just did make
> `HANDOFF.md` inaccurate?" If yes, fix it before you stop.

---

## The "first steps" checklist

The most valuable section for a new session is a concrete, ordered checklist — not
"understand the codebase," but actual commands:

```markdown
## First steps for a new session
1. Read this file, then AGENTS.md, then plans/ROADMAP.md.
2. Check it's alive:
   docker compose ps
   curl -s http://localhost:8000/api/v1/health
   git log --oneline -5 && git status
3. Load relevant skills.
4. Read the newest file in logs/.
5. Check open blockers (above).
6. DO NOT start coding. Ask what to work on, write a plan, wait for approval.
```

That last line matters: a new agent's instinct is to be helpful by starting
immediately. The handoff should explicitly tell it to **plan first**.

---

## Handoff vs README

They overlap, but serve different readers:

- **README** — for a human deciding whether to use/contribute. Marketing-adjacent:
  what it is, how to run it.
- **HANDOFF** — for an agent (or you) continuing the work. Operational: where it is
  *right now*, what's next.

Keep the README stable; update the HANDOFF constantly.

---

## Handoff vs the logs

- **logs/** — the full history, one file per task. Read for detail.
- **HANDOFF.md** — the *current* state, distilled. Read first.

The handoff is the index; the logs are the archive.

---

## Portability bonus: moving machines

Because `HANDOFF.md` captures the infrastructure map, it doubles as a migration
aid. If you move the project to a new server, the handoff tells you exactly what
needs to exist: the services, the ports, the ingress, the secrets (by name, never
value). Pair it with a runbook (see the case study's `docs/ops/migrasi-vps.md`) and
a migration is mechanical instead of terrifying.

---

**Next:** [06 — Context & Memory](06-context-and-memory.md)
