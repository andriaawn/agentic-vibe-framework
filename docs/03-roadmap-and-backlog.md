# 03 — Roadmap & Backlog

Two files keep the big picture from dissolving into the chat: a **roadmap** (what's
left, in one place) and a **backlog** (what we deliberately chose *not* to do yet,
and why).

---

## ROADMAP.md — one source of truth

The roadmap answers "what's left?" in a single screen. It is **not** a duplicate of
every plan; it is the index. Each entry links to the detail.

```markdown
# Roadmap — what's left

**Updated:** <date>
**Status:** <one line: live / in progress / paused>

## Done (don't redo)
| Area | Evidence |
|---|---|
| Auth + tiers | plans/phase-a1.md, commit abc123 |

## Remaining — by priority
### P1 — before real users
| # | Item | Effort | Why it matters | Trigger |
|---|---|---|---|---|
| 1 | Off-site backups | S | Local-only backup dies with the VPS | — |

### P2 — after traction
...

### P3 — tech debt
...
```

**Why it matters:** when a new session (or a new model) starts, it reads the roadmap
and instantly knows the state of the project. Without it, every session re-discovers
what's done and re-proposes what's already built.

### Rules for the roadmap

- **One file, always current.** If it's stale, it's worse than nothing — it misleads.
- **"Done" section with evidence.** So nobody rebuilds finished work.
- **Priority = trigger-based, not vibe-based.** "Do this when X happens", not "this
  feels important."
- **Update it as part of the work**, not as a separate chore. If a task finishes, the
  roadmap changes in the same session.

---

## BACKLOG.md — deferred, with reasons

The backlog is where good ideas go to **wait**, not to be lost. The key insight:
an idea without a *reason for deferral* and a *trigger to start* is just a distraction.

```markdown
## <Idea>

**Status:** ⏸ Deferred

**Why deferred:** <the real reason — effort, dependency, low value now>

**Trigger to start:** <the specific event that makes it worth doing>
  e.g. "when >20 real users ask for it" / "after email infra exists"

**Recon already done (don't repeat):** <what you learned while considering it>
```

### Why the trigger matters

A backlog full of "someday" items is noise. A backlog where every item has a
**concrete trigger** is a decision-making tool: you know exactly when to pull it in.
"Email verification: do it when we have >20 users" is actionable. "Email verification:
someday" is not.

### The "recon already done" line

This is the underrated part. When you investigate an idea and decide *not* to do it
yet, you've learned things. Record them, so the next time someone (human or AI)
proposes it, you don't re-investigate from zero. It turns a rejection into an asset.

---

## The "rejected" list — also worth keeping

Some ideas should be **actively refused**, not just deferred. Record them too, with
the reason, so they don't get re-proposed forever:

```markdown
## Refused / deliberately shelved (don't re-propose without a new reason)

| Item | Reason | Recorded in |
|---|---|---|
| AI bot in group chats | Leaks premium features & privacy | BACKLOG §5 |
| Prometheus/Grafana | A shell script covers our scale | plans/... |
```

This is how you stop an agent from helpfully re-suggesting the thing you already
decided against three sessions ago.

---

## How the three files relate

```
ROADMAP.md   → what's left, in priority order, with triggers
BACKLOG.md   → what's deferred, with the reason & the trigger
plans/       → the detail for anything we're actually building now
```

- Something on the roadmap that you decide to build → write a plan for it.
- Something you decide *not* to build yet → it goes to the backlog with a trigger.
- Something you'll *never* do → the refused list, with a reason.

Keep them in sync. A roadmap that disagrees with the backlog is worse than either alone.

---

**Next:** [04 — Logging](04-logging.md)
