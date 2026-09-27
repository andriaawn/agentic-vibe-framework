# 00 — Philosophy

> **The model is fast but has no memory. The structure is the memory.**

Everything in this framework follows from one observation: an AI coding agent is
brilliant within a single session and useless across sessions. It can write a
feature in minutes, then forget the entire codebase the moment the context window
closes. It has no memory of *why* a decision was made, no memory of the bug you
fought last week, no memory of the constraint you explained yesterday.

You cannot fix that by finding a smarter model. You fix it by putting the memory
**somewhere that outlives the session** — in the repository. Documents. Plans. Logs.
A handoff file. Files the next session reads before it does anything.

That is the whole framework. The rest is detail.

---

## The five principles

### 1. Documents are contracts, not decoration

A plan is not a wishlist. It is the agreement you and the agent make before code is
written. A log is not a diary. It is the record that lets a future reader reconstruct
what happened and why. If a document can't be wrong, it isn't doing anything.

**Consequence:** write documents that could be *violated*. "We will do X, and here's
how we'll know it's done" — not "we'll try to do good work."

### 2. The plan gate is sacred

Before code: a written plan, then an explicit human approval. Not silence. Not an
unrelated message. Not the agent's own judgment that the plan is "obviously fine."
An explicit "yes."

This single rule prevents the most expensive failure mode in agentic development:
the agent confidently building the wrong thing, at speed, in the wrong direction.

**Consequence:** the agent must stop and wait. Always. Even when it's sure.

### 3. If it doesn't connect, let it go

> *"If something doesn't connect, forget it — don't execute it, rather than making
> the project chaotic."*

A code path with zero callers is not "almost done." It is debt that can leak. Delete
it, or leave it dead — but never wire it up just to look finished. The temptation to
connect a half-built feature so the diagram looks complete is how projects rot.

**Consequence:** an unconnected path is a finding, not a feature. Prefer a smaller,
fully-connected system over a larger, half-wired one.

### 4. Verify the claim, not the confidence

An agent that says "done" is not evidence that it's done. A subagent that reports
"uploaded successfully" may be wrong. Confidence and correctness are unrelated.

The rule: **for anything with an external side effect, demand a verifiable handle**
(a URL, an ID, an absolute path, a test that fails when you revert the fix) **and
check it yourself.** Never relay an agent's self-report to the user as fact.

**Consequence:** "it works" is a hypothesis. A passing test, a live response, a
diff — those are evidence.

### 5. Small, reviewable, reversible

Small commits. Small files. One concern per change. Every step should be something
a human can review in a minute and revert in one command. Big-bang changes hide
their own mistakes.

**Consequence:** commit as you go. The history is the safety net.

---

## Why "structured" beats "pure vibe"

Pure vibe coding optimizes for the first hour. Structured vibe coding optimizes for
the hundredth hour — when the project is real, has users, and someone (maybe you,
maybe a new model, maybe a teammate) has to understand it.

The cost of structure is small: a few files, a little discipline. The cost of *no*
structure is unbounded: a codebase that no one — including the AI — can safely change.

You are not slowing down. You are buying the ability to keep going.

---

## The mental model

Picture the repo as a **shared brain** that both you and the agent read and write:

- `AGENTS.md` — how we work (read every session)
- `HANDOFF.md` — where we are right now (read every session)
- `plans/` — what we agreed to build and why (read before building)
- `logs/` — what actually happened (written after building)
- `ROADMAP.md` / `BACKLOG.md` — what's next, and what we deliberately deferred

The agent doesn't need to *remember*. It needs to *read*. The repo remembers for it.

---

**Next:** [01 — The Workflow](01-the-workflow.md)
