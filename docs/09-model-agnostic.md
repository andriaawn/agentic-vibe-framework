# 09 — Model-Agnostic

Models change fast. You'll switch providers, try a new release, hit a rate limit, or
hand the project to a teammate with a different tool. If your project's memory lives
inside one tool's format, switching costs you everything.

This chapter is about making the project **portable across models and tools**.

---

## The core idea

The project's knowledge lives in **plain markdown files in the repo**, not in a
tool's proprietary memory. Any agent that can read files can pick up the project.

```
AGENTS.md     → read by most agents (Codex, Cursor, OpenCode, others)
CLAUDE.md     → Claude Code's convention (keep as a pointer to AGENTS.md)
HANDOFF.md    → human/agent-readable state
plans/ logs/  → plain markdown
docs/         → plain markdown
```

No tool-specific database. No format only one product understands. Just files.

---

## The `AGENTS.md` convention

`AGENTS.md` has emerged as a **cross-tool** convention — several agents read it
automatically. Make it your **primary** working agreement, and keep tool-specific
files as thin pointers:

```markdown
<!-- CLAUDE.md -->
See AGENTS.md for the working agreement and conventions.
Project state: HANDOFF.md. Read both before starting.
```

This way there's **one source of truth** and no drift between a dozen tool configs.

> If a tool requires its own file, keep it minimal and point at `AGENTS.md`. Never
> duplicate the content — duplicated docs drift, and then the agent gets conflicting rules.

---

## What to write down for a new model

When a new model (or teammate) picks up the project, it needs, in order:

1. **What this is** — `README.md` (the product, the stack, how to run it).
2. **How we work** — `AGENTS.md` (workflow, rules, commands).
3. **Where we are** — `HANDOFF.md` (state, infra, blockers, first steps).
4. **What's next** — `plans/ROADMAP.md`.
5. **The detail** — `plans/`, `logs/`, `docs/`.

If those five exist and are current, any capable model can continue the work. That's
the test of a portable project.

---

## The "don't start coding" rule

A fresh agent's instinct is to be helpful immediately: read a little, then start
changing files. That's how it breaks things it didn't understand.

The handoff should tell it, explicitly, to:

1. **Check the live state first** — is it running? what's the git status? what's the
   latest log?
2. **Load the relevant skills.**
3. **Then ask** what to work on — and **write a plan and wait for approval.**

Never let a new session start editing before it has read `HANDOFF.md` and confirmed
the current state. The first action of a new model is *orientation*, not *mutation*.

---

## Portable secrets

Secrets are the one thing that *doesn't* live in the repo. Document them by **name and
location**, never value:

```markdown
## Secrets (values live outside the repo)
- DATABASE_URL      → .env, mode 600, on the server
- ADMIN_API_KEY     → .env, rotated quarterly
- BACKUP_ENCRYPTION → password manager (NOT on the server)
```

A new operator knows exactly what to set up, and the repo stays safe to share. (And
if the project moves machines, this list is the checklist for what to re-create.)

---

## Switching tools: a checklist

When you hand the project to a different agent/tool:

- [ ] `AGENTS.md` is current and tool-neutral.
- [ ] `HANDOFF.md` reflects reality (infra, state, blockers).
- [ ] `ROADMAP.md` says what's next.
- [ ] The latest `logs/` entry says what just happened.
- [ ] Skills are in a shared location (or documented).
- [ ] Secrets are documented by name, set up in the new environment.
- [ ] The new agent is told: **orient first, plan, then wait for approval.**

If all that's true, the switch is boring — which is exactly the goal.

---

## Why not just "use the best model"?

Because "the best model" changes every few months, and your project outlives it.
Optimizing your *memory* for one model is optimizing for a moving target. Optimizing
it for **plain files** is optimizing for permanence.

The model is a replaceable component. The repo's documents are the durable asset.
Invest accordingly.

---

**Next:** [10 — Anti-Patterns](10-anti-patterns.md)
