#!/usr/bin/env bash
#
# bootstrap.sh — copy the framework's structure into a target project.
#
# This is a convenience wrapper, NOT a CLI. It only copies files. Nothing is
# installed, nothing is executed. Review what it does before running it.
#
# Usage:
#   ./bootstrap.sh /path/to/your/project        # copy into an existing dir
#   ./bootstrap.sh --here                       # copy into the current dir
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR"

die() { printf 'error: %s\n' "$1" >&2; exit 1; }

# --- resolve target --------------------------------------------------------
if [[ "${1:-}" == "--here" ]]; then
  TARGET="$(pwd)"
elif [[ -n "${1:-}" ]]; then
  TARGET="$1"
else
  printf 'Usage: %s <target-dir> | --here\n' "$0" >&2
  exit 2
fi

[[ -d "$TARGET" ]] || die "target directory does not exist: $TARGET"
[[ -d "$SRC/templates" ]] || die "templates/ not found — run this from the framework repo"

printf 'Copying framework files into: %s\n\n' "$TARGET"

# --- create structure ------------------------------------------------------
mkdir -p "$TARGET/plans" "$TARGET/logs" "$TARGET/docs/skills"

# --- copy docs (methodology) ----------------------------------------------
if [[ ! -d "$TARGET/docs/framework" ]]; then
  mkdir -p "$TARGET/docs/framework"
  cp "$SRC"/docs/*.md "$TARGET/docs/framework/" 2>/dev/null || true
  printf '  + docs/framework/       (methodology, %s files)\n' \
    "$(ls "$SRC"/docs/*.md 2>/dev/null | wc -l | tr -d ' ')"
fi

# --- copy templates (rename .template -> real name) ------------------------
copy_template() {
  local src="$1" dest="$2"
  if [[ -e "$TARGET/$dest" ]]; then
    printf '  ! %s already exists — skipped\n' "$dest"
  else
    cp "$src" "$TARGET/$dest"
    printf '  + %s\n' "$dest"
  fi
}

copy_template "$SRC/templates/AGENTS.md.template"    "AGENTS.md"
copy_template "$SRC/templates/CLAUDE.md.template"    "CLAUDE.md"
copy_template "$SRC/templates/HANDOFF.md.template"   "HANDOFF.md"
copy_template "$SRC/templates/plan.md.template"      "plans/0000-template.md"
copy_template "$SRC/templates/log.md.template"       "logs/0000-00-00_template.md"
copy_template "$SRC/templates/ROADMAP.md.template"   "plans/ROADMAP.md"
copy_template "$SRC/templates/BACKLOG.md.template"   "plans/BACKLOG.md"
copy_template "$SRC/templates/SKILL.md.template"     "docs/skills/SKILL.md.template"

# --- seed a README if none exists -----------------------------------------
if [[ ! -e "$TARGET/README.md" ]]; then
  cp "$SRC/templates/README.md.template" "$TARGET/README.md"
  printf '  + README.md\n'
else
  printf '  ! README.md already exists — skipped\n'
fi

printf '\nDone. Next:\n'
printf '  1. Fill in AGENTS.md and HANDOFF.md.\n'
printf '  2. Read docs/framework/01-the-workflow.md.\n'
printf '  3. Write your first plan in plans/, then get it approved.\n'
