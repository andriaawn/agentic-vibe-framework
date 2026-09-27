# Example — a real HANDOFF.md (sanitized)

A condensed version of the handoff written for the case-study project, so a new AI
model (or a new server) could pick up the work. Sanitized: domains, IDs, and IPs are
placeholders.

---

```markdown
# HANDOFF

**Last updated:** 2026-09-27

## 0. 60-second overview
- **Product:** Indonesian stock market dashboard. Free tier + premium (manual upgrade).
- **Users:** ~6, live in production.
- **Live at:** https://app.example.com

## 1. Infrastructure
| Piece | Where / how | Notes |
|---|---|---|
| Frontend | Docker, port 80 | nginx serving the SPA |
| Backend | Docker, port 8000 | FastAPI, NOT bind-mounted |
| Database | Postgres (Docker), db `stockdash` | not exposed to host |
| Cache | Redis (Docker) | not published |
| Ingress | Cloudflare Tunnel | 3 hostnames (app, router, workflow) |
| Jobs | host cron | backup 02:00, health hourly, etc. |

**Ports:** frontend 80, backend 8000, internal-router 20128, workflow 5678.
**Careful:** 8080 is NOT the backend — it's a code-server behind a proxy.

## 2. How we work
Plan → approve → implement → test → log → commit. See AGENTS.md.

## 3. Current state
- **Roadmap:** plans/ROADMAP.md
- **Key numbers:** ~1.02M price rows, ~40k news items, DB ~222 MB, 979 stocks.
- **Migration head:** b7c8d9e0f1a2
- **Tests:** 732 passing.

## 4. Open risks / blockers
| # | Issue | Severity | Needs |
|---|---|---|---|
| 1 | Internal router: config 0644 + weak password + binds 0.0.0.0 | critical | sudo |
| 2 | SSH: root login + password auth enabled | high | sudo |
| 3 | Deploy user is in the docker group (= root-equivalent) | high | decision |

## 5. Secrets (names only)
- `DATABASE_URL` → `.env` (mode 600)
- `ADMIN_API_KEY` → `.env`
- `BACKUP_ENCRYPTION_PASSWORD` → password manager (NOT on the server)

## 6. First steps for a new session
1. Read this, then AGENTS.md, then plans/ROADMAP.md.
2. Check it's alive:
   docker compose ps
   curl -s http://localhost:8000/api/v1/health
   git log --oneline -5 && git status
3. Load relevant skills.
4. Read the newest file in logs/.
5. Review open blockers.
6. DO NOT start coding. Ask, plan, wait for approval.

## 7. Pitfalls
- Cron PATH is /usr/bin:/bin — ~/.local/bin tools are invisible. Export PATH in scripts.
- Backend isn't bind-mounted — rebuild the container after backend changes.
- Secrets are mode 600; never print them — mask as ***.
```

---

## Why this handoff works

- **The "60-second overview" lets a new agent orient instantly** — no code reading needed
  to know what the thing is.
- **The ports table is where newcomers get lost.** "Which port is the frontend?" is the
  first question, and the handoff answers it — including the trap (8080 is *not* the backend).
- **Secrets are named, never valued** — the handoff is safe to share and still tells the
  new operator exactly what to set up.
- **"DO NOT start coding"** is explicit, because a fresh agent's instinct is to mutate
  before it understands.
- **Pitfalls are captured** — the cron-PATH trap won't be rediscovered.
