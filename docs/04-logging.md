# 04 — Logging

A log is written **after** the work. Its job: let a future reader — you, a teammate,
or a new AI model — reconstruct what happened and why, **without the chat history**.

Chat is ephemeral. The repo is not. The log is how you move the reasoning from one
to the other.

---

## The shape of a useful log

A fixed structure makes logs scannable and comparable:

```markdown
# <Task title>

**Date:** YYYY-MM-DD
**Goal (from the user, verbatim if possible):** "<their words>"

## ROOT CAUSE
The actual problem — not the symptom. If the task was a bug, what was *really*
wrong? If a feature, what gap existed?

## FIX / WHAT WAS DONE
What changed, and why this approach.

## FILES CHANGED
- path/to/file.py — what changed
- path/to/other.ts — what changed

## VERIFICATION
How we proved it works. Exact commands + observed results.
- `pytest tests/test_x.py` → 4 passed
- live check: `curl ...` → 200 with expected body

## STATUS
Done / blocked / awaiting approval. Anything still open.
```

See [`templates/log.md.template`](../templates/log.md.template).

---

## Why "ROOT CAUSE" is the important field

The symptom is what you noticed. The root cause is what you had to *find* — and it's
the part a future reader can't reconstruct on their own.

> Symptom: "the 1Y chart button shows 6 months of data."
> Root cause: "the fetch window was hard-coded to 150 days in two separate places
> (`stock_fetcher.py` and `backfill_all_universe.py`), so the *data* was capped even
> though the UI offered 1Y/3Y/5Y."

Six months later, "we fixed the chart" tells you nothing. "The fetch window was
hard-coded in two places" tells you where the same bug could hide again.

---

## Why "VERIFICATION" is the second important field

The log records **evidence**, not confidence. Not "it works" but "here's the command
and here's what it printed." This is the same principle as [08 — Working with Agents](08-working-with-agents.md):
claims are hypotheses; evidence is proof.

A verification section that says "tested manually" is nearly worthless. One that says
"ran with the production cron environment (`PATH=/usr/bin:/bin`); off-site upload
succeeded, 29 MB verified" is gold — it's reproducible.

---

## Logging discipline

- **One log per task/session.** Named `logs/YYYY-MM-DD_<slug>.md`.
- **Commit the log.** It's part of the audit trail, not scratch paper.
- **Write it even when things went wrong** — especially then. A log that records a
  failed approach saves the next person from repeating it.
- **Keep it honest.** If you deviated from the plan, say so and why. The log is not
  marketing.
- **Link to commits/PRs** when useful, so code and reasoning connect.

---

## The anti-log

These look like logs but aren't:

- **"Fixed the bug."** — no root cause, no files, no verification. Useless.
- **A copy of the diff.** — the diff shows *what*, not *why*.
- **A status update.** — "still working on it" belongs in chat, not the repo.
- **Marketing.** — "delivered a robust, scalable solution." Say what changed.

If a log could have been written *before* the work, it isn't a log.

---

## Relationship to the plan

```
plans/  → written BEFORE  → the agreement (what we will do, and why)
logs/   → written AFTER   → the record (what actually happened, and why)
```

Read together, they tell the whole story: the intent, and the reality — including
where they diverged. That divergence is often the most valuable thing to capture,
because it's where the surprises were.

---

**Next:** [05 — Handoff](05-handoff.md)
