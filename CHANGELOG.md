# Changelog

All notable changes to this framework. Format loosely follows
[Keep a Changelog](https://keepachangelog.com/).

## [Unreleased]

### Added
- Initial release: methodology docs, templates, and a real case study.
- `docs/00-philosophy.md` … `docs/10-anti-patterns.md` — 11 chapters covering the
  workflow (plan → approve → implement → test → log → commit), memory layers
  (`AGENTS.md` + `HANDOFF.md` + skills), a security baseline, working with parallel
  agents, model-agnostic portability, and anti-patterns.
- `templates/` — `AGENTS`, `CLAUDE`, `HANDOFF`, `README`, `plan`, `log`, `ROADMAP`,
  `BACKLOG`, `SKILL`.
- `examples/stock-agent/` — real, sanitized artifacts from a live product: a plan, a
  log, a roadmap, a handoff, and a security finding.
- `bootstrap.sh` — optional helper that copies the structure into a target project.
- `CONTRIBUTING.md`, `LICENSE` (MIT).
