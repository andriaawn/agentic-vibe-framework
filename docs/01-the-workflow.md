# 01 — The Workflow

Six steps. One hard gate. The artifact trail is committed to the repo so the
reasoning survives without the chat.

```
┌─────────┐   ┌─────────┐   ┌───────────┐   ┌──────┐   ┌─────┐   ┌────────┐
│  PLAN   │──▶│ APPROVE │──▶│ IMPLEMENT │──▶│ TEST │──▶│ LOG │──▶│ COMMIT │
└─────────┘   └─────────┘   └───────────┘   └──────┘   └─────┘   └────────┘
     │             │
     │             └── HARD GATE: explicit human "yes". Silence is NOT approval.
     └── written to plans/phaseN-slug.md BEFORE any code
```

---

## Step 1 — PLAN

Before touching code, the agent writes a plan to `plans/<slug>.md`.

A good plan covers:

- **Goal / scope** — what we're building, in one or two sentences.
- **Key decisions & trade-offs** — the choices made, and what was rejected.
- **File / task breakdown** — what changes where.
- **Acceptance criteria** — how we'll know it's done (checkboxes).
- **Open questions** — anything that needs the human's input before starting.

The plan is a document on disk, not a chat message. It is committed, so it can be
reviewed later. See [02 — Planning](02-planning.md) for the anatomy.

## Step 2 — APPROVE  ← **the hard gate**

The agent **stops** and waits for an explicit approval: "go", "approved", "ok", or
requested changes.

**Silence is not approval. An unrelated message is not approval. The agent's own
confidence is not approval.**

This is the single most important rule in the framework. It is what stops a fast
agent from confidently building the wrong thing. An agent that skips this gate is
not "being efficient" — it is spending your budget in a direction you never agreed to.

## Step 3 — IMPLEMENT

Once approved, the agent works **autonomously**. It does not stop to ask permission
for routine decisions. It commits as it goes, in small reviewable steps.

It *does* stop and ask when a decision genuinely affects architecture or business
requirements beyond what the approved plan covers. (That's a different thing from
"asking permission for every small step.")

## Step 4 — TEST

Tests, lint, and type-checks run **as part of the work**, not as an afterthought.

- Tests must actually be able to fail. A test that passes whether or not the bug
  exists is worse than no test — it's false confidence. (See the mutation-test trick
  in [10 — Anti-Patterns](10-anti-patterns.md).)
- "It builds" is not "it works." Verify the behavior, ideally against a live system.

## Step 5 — LOG

After the work, the agent writes `logs/YYYY-MM-DD_<slug>.md`.

A useful log has a fixed shape so it's scannable:

- **ROOT CAUSE** — the actual problem (not the symptom).
- **FIX** — what was changed and why.
- **FILES CHANGED** — the exact list.
- **VERIFICATION** — how we proved it works (commands, outputs).
- **STATUS** — done / blocked / needs approval.

The log is the audit trail. It answers "why is the code like this?" six months later,
when the chat is long gone.

## Step 6 — COMMIT

Commit the trail: the plan, the code, the log. Small commits, one concern each.
**Stage exact file paths — never `git add -A`** (it sweeps in secrets and junk).

Pushing is a separate, explicit decision. Committing is local; publishing is not.

---

## Why the order matters

You might be tempted to skip the plan ("I know what I want") or skip the log ("I'll
remember"). Don't. The order is the whole value:

- **Plan first** → you catch the wrong direction *before* it costs anything.
- **Approve gate** → the human stays in control of direction, not just review.
- **Log after** → the *next* session (or model) can reconstruct the reasoning.

Skipping steps doesn't save time. It moves the cost to a later session where it's
larger and harder to pay.

---

## What this looks like in practice

```
you:    "add dark mode"
agent:  writes plans/2026-09-27-dark-mode.md  →  STOPS
you:    "approved"
agent:  implements, tests, commits (small steps), writes the log
you:    review the diff, push when ready
```

Two files added (plan + log), a handful of commits, and — crucially — a future
session can read `plans/` and `logs/` and understand exactly what dark mode did and why.

---

**Next:** [02 — Planning](02-planning.md)
