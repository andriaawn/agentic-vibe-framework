# Build — Agentic Vibe Framework (initial)

**Date:** 2026-09-27
**Plan:** [`plans/0001-initial-framework.md`](../plans/0001-initial-framework.md)
**Goal (user's words):** "bikin satu framework untuk gw kedepan bikin project lain …
bisa kita buat 1 repo publik baru … bukan hanya gua yg pake tapi bisa orang lain."

---

## ROOT CAUSE (why this exists)

Working with an AI coding agent across many sessions kept failing in the same ways:
the agent forgot everything between sessions, plans lived in chat and vanished, docs
silently rotted (a README claimed Windows on a Linux server), switching models meant
starting from zero, and the agent would report "done" when it wasn't. None of these
were model problems — they were **memory and process** problems. The fix wasn't a
smarter model; it was putting the memory **in the repo**, in files that outlive a
session.

This repo packages that fix: the patterns that were proven, by accident and by
discipline, while shipping a real live product.

## FIX / WHAT WAS DONE

Built a documentation-first repo — **11 methodology chapters, 9 templates, 6 real
examples** — encoding the workflow (plan → approve → implement → test → log → commit),
the memory layers (`AGENTS.md` + `HANDOFF.md` + skills), a security baseline drawn
from a real audit, and the parallel-agent verification lesson. Added an optional
`bootstrap.sh` that copies the structure into a target project.

## FILES CHANGED

- `README.md` — front door
- `LICENSE`, `CONTRIBUTING.md`, `.gitignore`
- `docs/00-philosophy.md` … `docs/10-anti-patterns.md` (11 files)
- `templates/AGENTS.md.template`, `CLAUDE.md.template`, `README.md.template`,
  `HANDOFF.md.template`, `plan.md.template`, `log.md.template`, `ROADMAP.md.template`,
  `BACKLOG.md.template`, `SKILL.md.template` (9 files)
- `examples/stock-agent/` — `README.md`, `plan-free-tier-limits.md`,
  `log-backup-cron-path.md`, `roadmap.md`, `handoff.md`, `security-finding.md`
- `bootstrap.sh`, `plans/`, `logs/`

## VERIFICATION

- **`bootstrap.sh` tested in a throwaway dir:**
  ```
  $ ./bootstrap.sh /tmp/bstest
    + docs/framework/  (11 files)
    + AGENTS.md  + CLAUDE.md  + HANDOFF.md  + README.md
    + plans/{0000-template,ROADMAP,BACKLOG}.md
    + logs/0000-00-00_template.md  + docs/skills/SKILL.md.template
  ```
  Verified `AGENTS.md` is copied with the **correct final name** (the `.template`
  suffix is source-side only), and that existing files are **never overwritten**.
- **Sanitization:** grep for real domains / IPs / tokens across `examples/` → only
  placeholders (`app.example.com`, `***MASKED***`, `example.com`).
- **Link check:** every relative link in `docs/`, `templates/`, `examples/` resolves.
- **Tool-agnostic:** `AGENTS.md` template present; docs reference Codex, Cursor,
  Claude Code, OpenCode, Gemini CLI.

## STATUS

Done & **published**. Commit `9637c80`, pushed to
`git@github.com:andriaawn/agentic-vibe-framework.git` (branch `main`).

Verified live (unauthenticated):
```
$ curl -s -o /dev/null -w '%{http_code}' https://api.github.com/repos/andriaawn/agentic-vibe-framework
200
license: MIT · default branch: main · public: true
```

## Notes / near-misses

- The build environment's tooling **blocks** writes to files named exactly
  `AGENTS.md` / `CLAUDE.md`. Rather than work around the guard (which we must not do),
  templates were stored with a `.template` suffix — arguably better UX anyway.
- Root `AGENTS.md` / `CLAUDE.md` were later added **with the user's explicit approval**,
  so the repo fully dogfoods its own convention (the guard is an approval gate, not an
  absolute block).
- This is a **dogfooding** repo: it follows the very workflow it documents (plan file
  here, log file here, handoff discipline, sanitize-before-commit).
