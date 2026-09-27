# 10 — Anti-Patterns

The patterns that look fine, feel productive, and quietly cost you the most. Every
one of these is drawn from a real project. Learn them cheap here, or expensive later.

---

## 1. "It works on my machine" — but not where it runs

**The trap:** you test a change by running the command manually, it works, you ship it.

**The reality:** the manual run happened in *your* shell — with your `PATH`, your
env vars, your user. The scheduled/production run happens with a **minimal
environment**. They are not the same.

> Real example: a backup script worked every time it was run by hand, and failed
> **every time** under cron — because the `rclone` binary lived in `~/.local/bin`,
> and cron's `PATH` is only `/usr/bin:/bin`. Weeks of "successful" backups that
> didn't exist.

**The fix:** test in the *real* environment, not a convenient one. Reproduce the
minimal env explicitly:
```bash
env -i HOME=/home/user PATH=/usr/bin:/bin ./your-script.sh
```
If it doesn't work there, it doesn't work.

---

## 2. A green test that can't fail

**The trap:** you write a test, it passes, you feel safe.

**The reality:** if the test passes whether or not the code is correct, it's not a
test — it's a decoration that hides bugs. (SQLite, for instance, doesn't enforce
`VARCHAR` length — so a test asserting a length constraint passes even when the
constraint is broken.)

**The fix:** **prove the test can fail.** Temporarily break the code (or the
constraint) and confirm the test goes red. A test you've never seen fail is a test
you can't trust. This "mutation check" takes seconds and catches the whole category.

---

## 3. "Almost done" — the unwired path

**The trap:** you build a feature, wire it partially, and call it done because it
*looks* done on the diagram.

**The reality:** a code path with zero callers is not progress. It's debt that can
leak — untested, unmonitored, and confusing to the next reader.

> The rule, stated bluntly: *"A path with zero callers isn't 'almost finished' — it's
> debt that can leak. Delete it or leave it dead; never wire it up just to look
> finished."*

**The fix:** if it doesn't connect to something real, either connect it fully or
remove it. A smaller, fully-wired system beats a larger, half-connected one.

---

## 4. The stale doc that lies

**The trap:** you wrote good docs once. They were true then.

**The reality:** a doc that's drifted is **worse than no doc**, because it actively
misleads. A new agent trusts it and goes the wrong way.

> Real example: the README told a new agent the project ran on **Windows**, with a
> **local venv** and a **portable Postgres** — while it actually ran on a **Linux
> server in Docker**. Every "fact" was a trap.

**The fix:** make "did this change the handoff/README?" part of the definition of
done. Update docs in the **same session** as the change that invalidated them.

---

## 5. Relaying an agent's claim as fact

**The trap:** a subagent says "done" / "uploaded" / "protected", and you tell the user
it's handled.

**The reality:** that report is the agent's *self-assessment*, not evidence. It can be
wrong in both directions, and its confidence is uncorrelated with its correctness.

**The fix:** for anything with a side effect, demand a verifiable handle and check it
yourself. Trust the diff and the live response, not the summary. (See [08](08-working-with-agents.md).)

---

## 6. The chat-only decision

**The trap:** you decide something important in the chat — an architecture choice, a
rejected approach — and move on.

**The reality:** the chat is ephemeral. Next session, the decision is gone, and the
agent re-proposes the thing you already rejected.

**The fix:** decisions go to disk — a plan, a log, or the backlog's "refused" list
with a reason. If it matters, it's written.

---

## 7. Fixing the symptom

**The trap:** something's wrong, you patch what you see, it seems fixed.

**The reality:** you treated the symptom; the root cause is still there, and will
resurface — often somewhere else.

> Real example: "the chart shows 6 months of data." The fix wasn't in the chart. The
> fetch window was hard-coded to 150 days in **two** places, so the *data* was capped.
> Patching the chart would have changed nothing.

**The fix:** always find the root cause. Write it in the log's `ROOT CAUSE` field —
if you can't, you haven't found it yet.

---

## 8. `git add -A`

**The trap:** stage everything, commit, move on. Fast.

**The reality:** `-A` sweeps in secrets, `.env` files, build junk, and unrelated
changes. One careless commit can leak a credential into history forever.

**The fix:** stage **exact paths**. Review the diff before committing. Add `.gitignore`
entries before you need them.

---

## 9. The destructive command without a dry run

**The trap:** a migration, a bulk delete, a "cleanup" script — run it and see.

**The reality:** destructive operations are irreversible. A `downgrade()` that drops a
column, a script that deletes the wrong rows, a `docker compose down -v` that wipes a
volume — all one keystroke from disaster.

**The fix:** test destructive operations against a **throwaway copy** first. Take a
backup. Print what *would* happen before it happens. Never run a destructive command
you haven't rehearsed.

---

## 10. Optimizing for "looks finished"

**The trap:** you wire up the half-built thing, add the stub, stub the TODO, so the
dashboard/diagram looks complete.

**The reality:** you've traded real progress for the *appearance* of progress, and
added debt that someone will have to untangle.

**The fix:** prefer honest incompleteness over misleading completeness. A clearly
marked TODO is fine. A wired-up lie is not.

---

## The meta-pattern

Almost every anti-pattern here is one move: **trading a small, real cost now for a
larger, hidden cost later.** Manual test (now) vs. real-environment test (later).
Stub it (now) vs. unwire it (later). Chat decision (now) vs. lost decision (later).

The framework exists to make the honest move the *easy* move — by putting the
verification, the decision, and the root cause **somewhere they survive**.

---

**Back to:** [README](../README.md) · [00 — Philosophy](00-philosophy.md)
