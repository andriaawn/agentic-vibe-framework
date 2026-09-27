# Example — a real roadmap (sanitized)

A sanitized roadmap from the case-study project. Notice: **done with evidence**,
**priority by trigger**, and a **refused** list so old decisions don't get re-proposed.

---

```markdown
# Roadmap — what's left

**Updated:** 2026-09-27
**Status:** LIVE — in production, 6 real users

## Done (don't redo)

| Area | Evidence |
|---|---|
| Auth + tiers (free/premium) | plans/phase-a1.md |
| Free tier limits (watchlist 5, portfolio 3) | plans/phase-a2-free-tier-limits.md |
| Charts + screener | commits 2df7afb, 7dca5ed |
| 5-year OHLCV history | commit 36d252c, log 2026-09-26_history-5y.md |
| Telegram broadcast channel | plans/phase-channel-broadcast.md |
| Security audit | docs/security/AUDIT-2026-09-26.md |

## Remaining — by priority

### P1 — before scaling
| # | Item | Effort | Why it matters | Trigger |
|---|---|---|---|---|
| 1 | Harden internal router service (world-readable config, weak password, wrong bind) | S | Internet-facing service with a known CVE | now — needs sudo |
| 2 | Rotate placeholder secrets that passed the length-only guard | S | A "secret" of `changeme` is not a secret | now |

### P2 — after traction
| # | Item | Effort | Why it matters | Trigger |
|---|---|---|---|---|
| 1 | Email verification | M | Spam/abuse control | when >20 real users |
| 2 | Payment gateway (vs. manual GoPay) | L | Removes manual admin step | when >50 paying users |

### P3 — tech debt
| # | Item | Effort | Why it matters | Trigger |
|---|---|---|---|---|
| 1 | Move backups to a second provider | M | One provider = one point of failure | when the app is revenue-positive |

## Refused (don't re-propose without a new reason)

| Item | Reason |
|---|---|
| AI bot in group chats | Leaks premium features & user privacy |
| Prometheus/Grafana | A shell script covers our scale |
| Upgrade n8n 1.x → 2.x | The CVE isn't fixed by upgrading; perimeter is closed instead |
```

---

## Why this roadmap works

- **"Done" has evidence.** A new session won't rebuild the free-tier limits because the
  roadmap says they exist and points to the plan.
- **Every item has a trigger** ("when >20 users", "needs sudo"), not a vibe ("important").
  That turns a wishlist into a decision tool.
- **The refused list is as important as the todo list.** "Don't upgrade n8n" has a
  *reason*, so a future agent doesn't helpfully upgrade it and reintroduce risk.
