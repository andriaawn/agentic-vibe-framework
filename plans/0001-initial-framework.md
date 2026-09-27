# Plan 0001 — Agentic Vibe Framework (initial build)

**Date:** 2026-09-27
**Status:** ✅ approved & built
**Owner:** invesbotid

---

## Goal

Build one public repo containing a **playbook + templates + real examples** for
"structured vibe coding" — how to work with AI coding agents (Codex, Cursor, Claude
Code, OpenCode, Hermes, …) so the result is **not spaghetti**, and so **switching
model or machine doesn't lose the context**.

Not theory. The content is **patterns already proven** on a live product
(`stock-agent`): the plan gate, roadmap, audit logs, handoff, skills, a security
baseline, and parallel delegation.

**Not building:**
- ❌ Not a code framework (nothing to `npm install`).
- ❌ Not a CLI / scaffolding tool (user's decision: docs + templates + examples only).
- ❌ Not a collection of "magic prompts".

**Building:** documents + templates anyone can copy into their own project.

---

## Decisions

| Topic | Decision |
|---|---|
| Content | Methodology docs + ready-to-use templates + real examples from stock-agent |
| Language | **English** (core docs) |
| Tools | **Tool-agnostic** (leans on the cross-tool `AGENTS.md` convention) |
| Name | `agentic-vibe-framework` |
| License | **MIT** |
| Attribution | `invesbotid` |
| Helper | Optional `bootstrap.sh` (copies files only — no install, no exec) |

**Rejected:** a full CLI (`npx create-...`) — adds maintenance surface for little gain;
a copy script plus good templates covers the need.

---

## File breakdown (final, as built)

```
agentic-vibe-framework/
├── README.md              front door (problem → fix → start in 5 min)
├── LICENSE                MIT
├── CONTRIBUTING.md        how to contribute (lessons, not volume)
├── bootstrap.sh           optional copy helper
├── .gitignore
├── docs/                  00-philosophy … 10-anti-patterns  (11 chapters)
├── templates/             AGENTS/CLAUDE/README/HANDOFF/plan/log/ROADMAP/BACKLOG/SKILL
│                          (stored with a .template suffix; renamed on copy)
├── examples/stock-agent/  real artifacts, sanitized (plan, log, roadmap, handoff, finding)
├── plans/                 this plan + ROADMAP/BACKLOG placeholders
└── logs/                  the build log
```

---

## Acceptance criteria

- [x] Public repo, branch `main`, MIT detected by GitHub.
- [x] A stranger can read the README, understand in ~5 min, copy `templates/`, start.
- [x] All internal links valid.
- [x] **Zero secrets / sensitive info** (examples sanitized: domains, IDs, IPs, tokens).
- [x] Tool-agnostic: ships `AGENTS.md` template; docs mention 4+ tools.
- [x] Examples are genuinely from stock-agent (not invented), anonymized.
- [x] `CONTRIBUTING.md` present.
- [x] `bootstrap.sh` tested in a throwaway directory.

---

## Deviation from the plan (recorded, per our own rules)

1. **Templates use a `.template` suffix.** The build environment's tooling guards
   files literally named `AGENTS.md` / `CLAUDE.md` (it treats them as active
   agent-instruction files and blocks automated writes). Storing them as
   `*.template` is cleaner anyway — it makes explicit that they're meant to be copied
   and renamed — and `bootstrap.sh` renames them on copy.
2. **Root `AGENTS.md` / `CLAUDE.md`** — added after the initial push (with the user's
   explicit approval). They were initially omitted because the build environment's
   tooling guards files with those exact names; with approval, they're now in place so
   the repo fully dogfoods its own convention.
3. **Repo location** — `/opt` is root-owned, so the working copy lives at
   `~/projects/agentic-vibe-framework`.

---

## Open questions

None. (Resolved: account `andriaawn`, sanitize aggressively, credit `invesbotid`,
include the optional `bootstrap.sh`.)
