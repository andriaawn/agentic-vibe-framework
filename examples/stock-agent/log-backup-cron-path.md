# Example — a real log (sanitized)

An actual task log from the case-study project. Note the **ROOT CAUSE** field: the
symptom and the cause are different, and the cause is the part a future reader can't
reconstruct on their own.

---

```markdown
# Off-site backup silently failing under cron

**Date:** 2026-09-26
**Goal (user's words):** "bro lakukan security audit keseluruhan pada project ini."

## ROOT CAUSE
The off-site backup (rclone upload) was **failing on every scheduled run since the
cron was first set up** — not intermittently, always. The backup script logged:

    WARN: RCLONE_REMOTE is set but rclone is not installed — off-site skipped

But `rclone` WAS installed — at `~/.local/bin/rclone` (85 MB). The problem: **cron's
PATH is only `/usr/bin:/bin`**, so the scheduled run never saw `~/.local/bin`. Manual
runs "worked" because an interactive shell has `~/.local/bin` on PATH — which is
exactly why nobody noticed. The local dump succeeded, so the backup looked healthy.

## FIX / WHAT WAS DONE
Added `export PATH="$HOME/.local/bin:$PATH"` at the top of the three ops scripts that
use `rclone` (`backup-postgres.sh`, `test-restore.sh`, `health-report.sh`). Minimal
fix at the root cause — did not move the binary or change cron.

## FILES CHANGED
- `scripts/ops/backup-postgres.sh` — added PATH export
- `scripts/ops/test-restore.sh` — added PATH export
- `scripts/ops/health-report.sh` — added PATH export

## VERIFICATION
Reproduced the *real* cron environment explicitly (not a convenient shell):

    $ env -i HOME=/home/user PATH=/usr/bin:/bin ./scripts/ops/backup-postgres.sh
    ...
    off-site ok: uploaded + verified (29471282 bytes)   # was: "off-site skipped"

Before the fix, the same command produced the "not installed" warning. Dump size
29.5 MB (grew from 3.9 MB — expected, after a 5-year history backfill).

## STATUS
Done. Committed.

---

## Note: a subagent almost sent us the wrong way
An audit subagent reported the *backup* was fine and separately claimed a service
password file was "world-readable" (it was `600`). Both claims were wrong on
inspection. Verified against the live system before acting — see
`docs/08-working-with-agents.md`.
```

---

## Why this log is useful

- **ROOT CAUSE ≠ symptom.** "Backup failed" would be useless. "Cron's PATH doesn't
  include `~/.local/bin`" tells you where the same bug can hide again (any cron job
  using a user-installed tool).
- **The verification is reproducible** — an exact command, in the *real* environment,
  with the observed output. Not "tested it, works."
- **It explains why nobody noticed** — the most valuable sentence in the whole log,
  because it prevents the *next* silent failure of the same kind.
- **It records a near-miss** (the wrong subagent claim) so the lesson is captured, not
  lost.
