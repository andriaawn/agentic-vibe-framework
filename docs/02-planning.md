# 02 — Planning

A plan is the contract you and the agent agree on **before** code exists. Its job
is not to be long. Its job is to be **decidable** — specific enough that you can say
"yes, build this" and later check whether it was built.

---

## The anatomy of a good plan

```markdown
# Phase <N> — <short title>

## Goal
One or two sentences. What are we building, and why now?

## Decisions (from the user / made here)
The choices already made. What was rejected and why.

## File / task breakdown
What changes, where. Concrete paths. This is where the agent proves it
understands the codebase, not just the request.

## Acceptance criteria
- [ ] Checkable statements. Each one could be false.
- [ ] "Login returns 401 on a wrong password" — not "login is secure."

## Open questions
Things that need the human's input before starting. If there are none, say so.
```

See [`templates/plan.md.template`](../templates/plan.md.template) for the fill-in version.

---

## What makes a plan good

**It's specific.** "Improve performance" is not a plan. "Cache the market overview
for 60s; measure p95 before/after" is a plan.

**It names files.** A plan that says "update the backend" doesn't prove the agent
read the code. A plan that says "add `free_watchlist_limit` to `core/config.py` and
enforce it in `watchlist_service.add_stock()`" does.

**Acceptance criteria can be false.** If every criterion is automatically true, the
plan is decoration. Write criteria a reviewer could use to *fail* the work.

**It surfaces decisions.** The most valuable part of a plan is the trade-offs: what
was considered and rejected. This is what a future reader (or model) needs to
understand why the code is the way it is.

**It's honest about unknowns.** "Open questions" is a feature, not a weakness.
It's better to ask before building than to guess and rebuild.

---

## Plan size: right-size it

- **Tiny change** (fix a typo, rename a variable): you may not need a file. A one-line
  intent in the commit message can be enough.
- **Normal feature**: a plan file. A page or two.
- **Large / risky change** (new subsystem, migration, anything touching data):
  a longer plan, and treat the open questions as a real gate.

The rule of thumb: **if the change would be painful to revert, write the plan.**

---

## The plan gate in detail

The gate is: **the agent writes the plan, then stops, and waits for an explicit yes.**

Why "explicit"? Because an agent will happily treat ambiguity as approval. "Looks
interesting, continue when ready" is not a yes. An unrelated follow-up message is not
a yes. The agent being *sure* is not a yes.

Enforce it in your `AGENTS.md` (see the template). It is the difference between a
collaborator and a runaway process.

### What approval looks like

| Input | Approval? |
|---|---|
| "go" / "approved" / "ok, build it" / "lanjut" | ✅ yes |
| "looks good" (then nothing else) | ⚠️ borderline — ask for a clear yes |
| silence | ❌ no |
| "what about X instead?" | ❌ no — that's a plan change; revise and re-gate |
| a message about something else | ❌ no |

---

## Anti-patterns in planning

- **The chat-only plan.** Discussed in the chat, never written to disk. Gone tomorrow.
- **The moving plan.** The agent starts building and "adjusts" the plan as it goes,
  so the plan never matched reality. If the direction changes, stop and re-gate.
- **The plan theater.** A plan so vague it can't be wrong ("build a robust, scalable
  system"). It provides no control.
- **The plan that's really a spec.** Over-planning a small change wastes the gate's
  value. Right-size it.

---

## Worked example

A real plan from the case study (sanitized) — a "free tier limits" feature:

```markdown
## Goal
Enforce free-tier limits on watchlist and portfolio, and route users to
upgrade when they hit them. Manual admin upgrade, no payment gateway.

## Decisions
- Watchlist: 5 items. Portfolio: 3 positions (stricter).
- Premium: unlimited (tier == "premium" skips all checks).
- "position" = distinct held stock, not transaction count.

## File breakdown
- core/config.py: add free_watchlist_limit, free_portfolio_limit
- services/watchlist_service.py: check limit in add_stock()
- services/portfolio_service.py: check limit after snapshot

## Acceptance criteria
- [ ] Free user adding a 6th watchlist item gets 403 with a clear message
- [ ] Buying more of a held stock is allowed at the limit
- [ ] Premium user is never blocked
```

Note how each decision is a choice you could disagree with, and each criterion could
fail. That's what makes it a contract.

---

**Next:** [03 — Roadmap & Backlog](03-roadmap-and-backlog.md)
