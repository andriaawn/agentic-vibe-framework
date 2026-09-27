# 08 — Working with Agents

You can run several AI agents in parallel — one auditing auth, one scanning for
injection, one reviewing the frontend — and get a lot done fast. This chapter is about
doing that **safely**, and about the single rule that matters most:

> **A subagent's report is a self-report, not a verified fact.**

---

## Why parallel agents help

Some work is naturally parallel and context-heavy:

- **Audits / reviews** — split by domain (auth, injection, secrets, infra, frontend).
- **Research** — several sources, several questions at once.
- **Independent workstreams** — features that don't touch the same files.

The win is real: six auditors in parallel cover a codebase in the time one would take
to cover a sixth of it. And because each runs in its own context, one agent's huge
intermediate output doesn't flood another's.

---

## The verification rule (non-negotiable)

An agent that finishes a task will **report success**. That report is generated from
the agent's own reasoning — it is *not* evidence. It may be wrong in either direction:

- **False positive:** "password is world-readable" — when the file it named was
  actually `600`, and the real leak was somewhere else.
- **False negative:** "uploaded successfully" — when the upload silently truncated.

**So: never relay a subagent's claim to the user as fact.** For anything with an
external side effect (a file written, a service changed, a deploy, an upload),
require a **verifiable handle** — a URL, an ID, an absolute path, a response body —
and **check it yourself** before you believe it.

### In practice

| The agent says | You do |
|---|---|
| "Report written to `/tmp/x.md`" | `ls -la /tmp/x.md` and read it |
| "Endpoint is protected" | `curl` it and see the status code |
| "Config fixed" | read the file / check the running process |
| "Tests pass" | run them yourself, and see them fail without the fix |
| "Upload succeeded" | fetch the remote object and compare size |

This isn't distrust for its own sake. It's that the agent's confidence and the truth
are **uncorrelated**, and the cost of a wrong claim (shipped bug, false sense of
security) is high.

---

## The false-positive story (a real one)

An audit agent reported, with confident detail, that a service's password was
"stored in a world-readable file." The named file was, on inspection, mode `600` —
correctly protected. The *actual* leak was a different file (a systemd unit, mode
`0644`) that the agent had conflated.

If that claim had been relayed unchecked, the fix would have been applied to the
wrong file and the real hole left open — **while the report said "fixed."**

The lesson: **cross-check every finding against the live system.** Read the file.
Run the command. Check the mode. An audit you didn't verify is an audit you can't trust.

---

## How to brief an agent well

A good brief is self-contained — the agent knows nothing about your conversation:

- **The goal**, precisely. "Audit authentication, authorization, and session handling."
- **The context it needs** — file paths, the stack, where the code lives.
- **The output** — where to write it, in what shape ("findings with severity,
  `file:line`, code, impact, remediation").
- **The constraints** — "read actual code, quote line numbers, be adversarial."
- **What *not* to do** — "never print secret values; mask them."

Vague briefs produce vague, unverifiable reports. The brief is your leverage.

---

## Batch the work

When dispatching several agents:

- Give each a **distinct, non-overlapping** domain, so they don't duplicate or conflict.
- Tell each to **write to its own file** (e.g. `/tmp/audit/01_auth.md`), so results
  survive and you can aggregate.
- **Aggregate with code, not memory** — count, dedupe, and sort the findings in a
  script; don't try to hold 50 findings in your head.
- **Verify the high-severity claims yourself** before acting — those are the ones
  where a false positive is most expensive.

---

## When NOT to use parallel agents

- **Anything needing user interaction** — subagents can't ask questions.
- **Durable work that must survive the session** — use a scheduled job or a real
  process, not a subagent (a subagent dies with the session).
- **A single tool call** — just make the call.
- **Tightly coupled work** — two agents editing the same files will fight. Serialize it.

---

## The mindset

Treat agents as **fast, confident, amnesiac collaborators**. They're brilliant at
generating options, scanning broadly, and doing tedious work at speed. They are not
reliable narrators of their own success. Your job is to direct them well and **verify
the things that matter**.

Direct broadly. Verify ruthlessly. Trust the diff, not the summary.

---

**Next:** [09 — Model-Agnostic](09-model-agnostic.md)
