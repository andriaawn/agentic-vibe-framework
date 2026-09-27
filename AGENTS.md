# AGENTS.md

Working agreement for AI agents contributing to **this framework repo**. Read this
before editing anything here.

> This repo practices what it preaches: it follows the very workflow it documents.
> The canonical, copy-ready version for *your* project lives at
> [`templates/AGENTS.md.template`](templates/AGENTS.md.template).

## What this repo is

A documentation-first framework for building software with AI coding agents. The
deliverable is **markdown**: methodology docs, templates, and real examples. There is
no application code to run (except `bootstrap.sh`, a convenience copy script).

## Read before you work

1. This file (`AGENTS.md`) — how we work here.
2. [`README.md`](README.md) — what the framework is.
3. [`docs/`](docs/) — the methodology (`00-philosophy` → `10-anti-patterns`).
4. [`plans/`](plans/) and [`logs/`](logs/) — the build trail.

## Rules for working here

- **Docs are the product.** A change is judged by whether it's clear, concrete, and
  correct — not by how much it adds.
- **Concrete beats abstract.** Every rule should carry an example or a reason. If a
  claim can't be wrong, it isn't worth writing.
- **One concern per commit.** Small, reviewable changes.
- **Sanitize everything.** No real secrets, domains, hostnames, IDs, emails, or IPs.
  Use `example.com`, `***`, `user@example.com`.
- **Keep templates in sync with the docs.** If a doc describes a section, the matching
  template should have it.
- **Don't duplicate.** `AGENTS.md` (this file) is the working agreement; `README.md` is
  the front door; `CONTRIBUTING.md` is for human contributors. Link, don't repeat.
- **Templates carry a `.template` suffix.** They're renamed on copy (see
  `bootstrap.sh`). Don't rename them in-place.

## Structure

```
README.md          front door (what it is, how to use)
docs/              methodology, 00 → 10
templates/         fill-in files (*.template; copied + renamed by bootstrap.sh)
examples/          real artifacts from the case study (sanitized)
bootstrap.sh       copies templates into a target project (no install, no exec)
CONTRIBUTING.md    how to contribute
plans/ logs/       this repo's own plan/log trail (dogfooding)
```

## The workflow (we follow it too)

Plan → approve → implement → test → log → commit. For small doc changes the "plan" can
be a one-line intent in the commit message; for structural changes, write a short plan
in `plans/`.

## Before you commit

- [ ] No secrets, real domains, or PII anywhere.
- [ ] Internal links resolve (`docs/`, `templates/`, `examples/`).
- [ ] Templates match what the docs describe.
- [ ] Tone: direct, second person, concrete.
