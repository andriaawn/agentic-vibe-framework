# Contributing

Thanks for helping improve the Agentic Vibe Framework. This is a documentation-first
project — the contribution we value most is **hard-won lessons**, not volume.

## What we want

- **Lessons that were earned.** A pitfall you actually hit, a pattern that actually
  saved you. Concrete beats theoretical.
- **Examples from real projects.** Sanitized (no secrets, no private domains), but real.
- **Corrections.** If a doc is wrong, misleading, or stale, that's a bug — report it.

## What we don't want

- Generic "10 tips" filler.
- Theory with no concrete example.
- Tool-specific content in the core docs (that belongs in an addendum).

## How to contribute

1. **Open an issue first** for anything non-trivial — describe the lesson and where it
   belongs. Let's agree on the shape before you write.
2. **Fork and branch.**
3. **Match the tone:** direct, concrete, second person. Prefer an example over an
   abstraction. If a claim can't be wrong, it isn't worth writing.
4. **Sanitize everything.** No real domains, tokens, IDs, emails, IPs, or secrets.
   Replace with placeholders (`example.com`, `***`, `user@example.com`).
5. **One concern per PR.**
6. **Open the PR** with: what you added/changed and *why* (the lesson it encodes).

## Style guide

- Markdown, one sentence per line is fine.
- Prefer **bold** for the rule, then explain the *why*.
- Use real examples in fenced code blocks.
- Keep docs skimmable: headings, short paragraphs, tables where they help.
- British/American spelling — pick one per file, don't mix.

## Sanitization checklist (before you submit)

- [ ] No real secret values, tokens, keys, or connection strings.
- [ ] No real domains or hostnames (use `example.com`).
- [ ] No real user IDs, chat IDs, emails, or IPs.
- [ ] No private repository links.
- [ ] No screenshots containing real data.

## License

By contributing, you agree your contribution is licensed under the project's
[MIT License](LICENSE).
