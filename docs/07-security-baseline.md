# 07 — Security Baseline

AI agents ship fast. That speed applies to security holes too. This chapter is a
checklist distilled from a **real security audit** of a live product — the categories
where agent-built apps actually get hurt. Run it before you have real users.

> The pattern behind almost every finding: **the application code was fine; the
> perimeter around it was not.** Agents write decent auth logic and then leave a
> debug service, a weak secret, or an admin panel exposed to the internet.

---

## The checklist

### 1. Secrets

- [ ] No secret in git history — check `git log --all` for `.env`, tokens, keys.
      (A secret committed once is compromised forever; rotate it, don't just delete the file.)
- [ ] `.env` files are git-ignored **and** mode `600` (not world-readable).
- [ ] Secrets are not baked into build args or image layers.
- [ ] Secrets are not logged (`print`, `logger.info`, error handlers).
- [ ] Placeholder secrets are **rejected**, not accepted — a config that only checks
      *length* will happily accept `changeme` if it's long enough. Fail closed.
- [ ] A leaked secret is rotated, not just removed from the working tree.

### 2. Authentication & authorization

- [ ] Passwords are hashed with **bcrypt/argon2** (never md5/sha1/plain).
- [ ] Auth tokens have an expiry **and** a revocation path (a stolen token can be
      killed; a password change invalidates sessions).
- [ ] Authorization is enforced on the **server** — client-side "premium/admin" gating
      is cosmetic only.
- [ ] Privilege checks read from the **database**, not from a token claim that can go
      stale (a downgraded user must lose access immediately, not in 7 days).
- [ ] **Object-level authz (IDOR):** every endpoint taking an `id` verifies the object
      belongs to the caller. This is the most common agent mistake.
- [ ] Admin endpoints require a real admin credential; keys are compared in
      **constant time** and fail closed when unset.

### 3. Injection & input

- [ ] SQL goes through an ORM / parameterized queries — never string-built.
- [ ] **SSRF:** any endpoint that fetches a URL from the user must allow-list hosts and
      block private/link-local ranges (`127.0.0.0/8`, `169.254.0.0/16`, RFC1918),
      and must not blindly follow redirects.
- [ ] File uploads: type **and** size validated, stored safely, not executed.
- [ ] No `eval`, `exec`, `os.system`, or `subprocess` with user input.
- [ ] Unbounded `limit`/`offset` params are capped (a missing `le=` is a DoS).

### 4. Rate limiting & abuse

- [ ] Login is rate-limited **per account** (and can't be used to lock a victim out).
- [ ] Expensive endpoints (AI/LLM, search, full recompute) have a rate limit or cost cap.
- [ ] Account-recovery / linking codes are long enough and throttled (a 6-digit code
      with no attempt limit is brute-forceable).
- [ ] Unauthenticated endpoints that trigger work are throttled.

### 5. Network exposure

- [ ] Databases and caches are **not** published to the host/internet.
- [ ] Internal services bind `127.0.0.1`, not `0.0.0.0`.
- [ ] Anything exposed publicly has real auth in front of it (an identity layer, not
      just the app's own login).
- [ ] Debug/dev servers and admin panels are not reachable from the internet.
- [ ] **Verify** the bind — a config that *says* `127.0.0.1` doesn't mean the process
      obeys. Check with `ss -tlnp`.

### 6. HTTP hardening

- [ ] Security headers: `Content-Security-Policy`, `X-Frame-Options`/`frame-ancestors`,
      `X-Content-Type-Options`, HSTS, `Referrer-Policy`.
- [ ] CORS is an explicit allow-list of real origins — never `*` with credentials.
- [ ] API docs / OpenAPI disabled in production.
- [ ] Error responses don't leak stack traces or internal strings.

### 7. Frontend

- [ ] No `dangerouslySetInnerHTML` / `innerHTML` / `eval` on user or API data.
      (Watch chart libraries: tooltip formatters often build HTML strings — escape them.)
- [ ] Tokens in `localStorage` are XSS-readable — pair with a strict CSP, or use
      HttpOnly cookies.
- [ ] No secrets in `VITE_*` / public env vars (they ship to the browser).
- [ ] Dependencies: `npm audit` / `pip-audit` clean.

### 8. Infrastructure

- [ ] Containers don't run as root unless they must; no `privileged`, no mounted
      `docker.sock`.
- [ ] SSH: no root login, no password auth, `fail2ban` (or equivalent) on.
- [ ] The deploy user is not root-equivalent (docker-group membership = root).
- [ ] Backups are encrypted, **and the key is not on the same box** as the data.
- [ ] Secrets-at-rest: env vars are visible to anyone with container access — treat
      container access as secret access.

---

## How to actually run this

1. **Do it in parallel.** Split the checklist into domains (auth, injection, secrets,
   infra, frontend, API) and have separate agents audit each. See
   [08 — Working with Agents](08-working-with-agents.md).
2. **Verify every finding yourself.** An auditor agent will produce false positives
   and false negatives. Cross-check each claimed finding against the live system.
3. **Rank by real impact, not category.** "Internet-facing unauth RCE" beats "missing
   header," always. Fix the pivot paths first.
4. **Write the report to the repo** (`docs/security/`), with `file:line` evidence and a
   remediation order. It's a living document — mark findings fixed as you fix them.
5. **Never paste real secret values** into the report. Mask them.

---

## The one-line version

> Assume everything you expose to the internet **will** be probed. An agent will
> happily expose a service "just for testing." Your job is to make sure that when the
> probe comes, there's a real door with a real lock — not a hole.

---

**Next:** [08 — Working with Agents](08-working-with-agents.md)
