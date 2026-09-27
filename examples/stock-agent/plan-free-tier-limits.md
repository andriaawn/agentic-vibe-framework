# Example — a real plan (sanitized)

This is an actual plan from the case-study project (`stock-agent`), lightly sanitized.
It shows the shape of a plan that worked: specific, decidable, honest about trade-offs.

---

```markdown
# Phase A2 — Free tier limits

**Date:** 2026-09-14
**Status:** ✅ approved

## Goal
Enforce free-tier limits on watchlist and portfolio, and route users to upgrade when
they hit them. Manual admin upgrade (GoPay), no payment gateway integration yet.

## Decisions
- Watchlist: **5 items** max for free.
- Portfolio: **3 positions** max for free (stricter — it's the more valuable feature).
- Premium (`tier == "premium"`) skips all checks → unlimited.
- "position" = a distinct held stock, not a transaction count. Buying more of a stock
  you already hold is **allowed** at the limit.
- Rejected: hard-blocking with a generic 403. We return a message + an upgrade CTA, so
  the limit becomes a conversion path, not just a wall.

## File breakdown
- `backend/app/core/config.py` — add `free_watchlist_limit`, `free_portfolio_limit`
- `backend/app/services/watchlist_service.py` — check limit in `add_stock()`
- `backend/app/services/portfolio_service.py` — check limit after snapshot
- `frontend/src/components/UpgradeCallout.tsx` — shared CTA component
- `frontend/src/pages/WatchlistPage.tsx` — show the CTA on limit hit

## Acceptance criteria
- [ ] Free user adding a 6th watchlist item gets 403 with a clear message
- [ ] Buying more of a held stock is allowed at the limit
- [ ] Premium user is never blocked
- [ ] The upgrade CTA shows on both watchlist and portfolio limit hits
- [ ] Limits are read from config, not hard-coded

## Open questions
- None.
```

---

## Why this plan is good

- **Every decision is a choice you could disagree with** ("3 positions", "buying more is
  allowed"). That's what makes it a contract, not a description.
- **It names files.** The agent had to read the code to write this.
- **Each criterion could fail.** "Premium user is never blocked" is checkable — and it's
  exactly the kind of edge case an agent forgets.
- **It records a rejection** (hard-block vs. CTA) with the reason — so a future session
  doesn't "improve" it back to the thing we rejected.
- **"Open questions: None."** — explicit, so the gate is clean.
