# Example — a real security finding (sanitized)

How to write a finding so it's **actionable and verifiable**, not a vague worry. From
the case-study audit. Notice: severity, exact location, evidence from the live system,
impact, and a remediation — plus the honest note that the finding was *verified*, not
just reported.

---

```markdown
## C-2 — Internal router service exposed with a weak, world-readable credential

**Severity:** CRITICAL
**Location:** /etc/systemd/system/internal-router.service:14
**Status:** 🔴 OPEN (needs sudo)

### Evidence (verified live)
$ ls -l /etc/systemd/system/internal-router.service
-rw-r--r-- 1 root root ... internal-router.service      # mode 0644 = world-readable

$ grep INITIAL_PASSWORD /etc/systemd/system/internal-router.service
Environment=INITIAL_PASSWORD=***MASKED***               # 8 characters

$ curl -s -X POST http://127.0.0.1:20128/api/auth/login \
    -d '{"password":"***MASKED***"}' -o /dev/null -w '%{http_code}'
200                                                     # login succeeds with it

$ ss -tlnp | grep 20128
LISTEN 0 4096 0.0.0.0:20128 0.0.0.0:*                  # binds all interfaces
                                                        # (unit asks for 127.0.0.1)

### Impact
The service is reachable from the internet (published through the tunnel). Its admin
password is stored in a file any local user can read, is only 8 characters, and the
process listens on all interfaces despite the unit requesting loopback. An attacker
who reads the file (or brute-forces 8 chars) gains admin access to the router, which
proxies to internal services.

### Remediation
1. chmod 600 /etc/systemd/system/internal-router.service
2. Rotate INITIAL_PASSWORD to a strong value; move it out of the unit file.
3. Fix the bind so the process actually listens on 127.0.0.1 only (verify with ss).
4. systemctl daemon-reload && systemctl restart internal-router
5. Remove the public hostname from the tunnel if the UI isn't needed externally.
```

---

## Why this finding is good

- **Severity + exact `file:line`.** A reader can go straight to the problem.
- **Evidence, not assertion.** Four commands, four outputs — including the `ss` check
  that *proves* the bind contradicts the config. ("The unit says 127.0.0.1" is not the
  same as "the process listens on 127.0.0.1.")
- **Impact is concrete** — who can do what, and why it matters.
- **Remediation is ordered and checkable** — including "verify with ss", so the fix
  itself is verifiable.
- **Secrets are masked** (`***MASKED***`) even in the evidence.

## The meta-lesson

An audit is only as good as its **verification**. In the same audit, an agent reported
a *different* file as the world-readable one (it was `600`), and separately reported a
git-history token that turned out to be a 13-char placeholder, not the real 46-char
token. Both claims were corrected by checking the live system.

**Rule:** every finding gets verified against the real system before it's trusted —
and every "fixed" claim gets re-verified before it's believed.
