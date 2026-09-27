# Examples

These are **real artifacts** from the case-study project (`stock-agent`) — a live
Indonesian stock-market dashboard built entirely with the workflow in this framework.
They've been sanitized: domains, IDs, IPs, and secrets are replaced with placeholders.
Everything else — the structure, the reasoning, the lessons — is genuine.

The point isn't to show off the product. It's to show what the framework's artifacts
**actually look like when they're real**, so you can calibrate your own.

| File | What it demonstrates |
|---|---|
| [`plan-free-tier-limits.md`](plan-free-tier-limits.md) | A plan that worked: specific, decidable, records rejections |
| [`log-backup-cron-path.md`](log-backup-cron-path.md) | A log whose ROOT CAUSE is the valuable part |
| [`roadmap.md`](roadmap.md) | Priority by trigger; a "refused" list that stops re-proposals |
| [`handoff.md`](handoff.md) | A handoff that lets a new model/machine pick up instantly |
| [`security-finding.md`](security-finding.md) | How to write a finding with evidence, not vibes |

## What made the case study work

The project went from nothing to **live in production** with real users, across many
sessions and more than one AI model. What made that possible wasn't a smarter model —
it was the **artifact trail**:

- A plan before every feature, approved by the human.
- A log after every task, with the root cause and the verification.
- A handoff that was updated whenever reality changed.
- A roadmap that said what was done (with evidence) and what was next (with triggers).
- Skills that captured the hard-won pitfalls so they weren't re-learned.

When a new session started, it didn't begin from zero. It read the trail and continued.
That's the entire claim of this framework, and the case study is the evidence.

## A note on the security example

The case study included a full security audit — six parallel auditor agents, then
live verification of every finding by the lead. The lesson that came out of it is in
[`security-finding.md`](security-finding.md) and [`../../docs/08-working-with-agents.md`](../../docs/08-working-with-agents.md):
**auditor agents produce false positives and false negatives; verify every claim
against the live system before acting.**
