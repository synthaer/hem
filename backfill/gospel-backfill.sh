#!/usr/bin/env bash
# HEM Gospel Backfill — reconstruct Gospel from project history
set -euo pipefail

PROJECT_DIR="${1:?Usage: gospel-backfill.sh <project-dir>}"
PROJECT_NAME="$(basename "$(cd "$PROJECT_DIR" && pwd)")"
GOSPEL_DIR="$PROJECT_DIR/docs/gospel"
GOSPEL_FILE="$GOSPEL_DIR/GOSPEL.md"

if [[ -f "$GOSPEL_FILE" ]]; then
  echo "Gospel already exists for $PROJECT_NAME"
  exit 0
fi

mkdir -p "$GOSPEL_DIR"

# Collect evidence
EVIDENCE=""

# Git history (first commits)
if git -C "$PROJECT_DIR" rev-parse --git-dir >/dev/null 2>&1; then
  FIRST_COMMITS=$(git -C "$PROJECT_DIR" log --reverse --oneline 2>/dev/null | head -5)
  if [[ -n "$FIRST_COMMITS" ]]; then
    EVIDENCE+="## Git History (earliest commits)\n$FIRST_COMMITS\n\n"
  fi
fi

# README content
if [[ -f "$PROJECT_DIR/README.md" ]]; then
  README_SNIPPET=$(head -30 "$PROJECT_DIR/README.md")
  EVIDENCE+="## README.md (first 30 lines)\n$README_SNIPPET\n\n"
fi

# Historical CLAUDE.md
if [[ -f "$PROJECT_DIR/docs/CLAUDE-historical.md" ]]; then
  CLAUDE_SNIPPET=$(head -30 "$PROJECT_DIR/docs/CLAUDE-historical.md")
  EVIDENCE+="## Historical CLAUDE.md\n$CLAUDE_SNIPPET\n\n"
fi

# If we have enough evidence and claude CLI is available, reconstruct
if [[ -n "$EVIDENCE" ]] && command -v claude >/dev/null 2>&1; then
  GOSPEL=$(echo -e "$EVIDENCE" | claude -p "Review this project evidence and reconstruct the Gospel — the original vision.
Output a markdown document with YAML frontmatter containing:
- project, vision (one sentence), created (best guess date), status: active
Then markdown body with: Original Intent, Vision Statement, Scope Boundaries, Success Criteria.
Add comment: <!-- Reconstructed retroactively from project history by HEM v4 backfill -->" 2>/dev/null || true)

  if [[ -n "$GOSPEL" ]]; then
    echo "$GOSPEL" > "$GOSPEL_FILE"
    echo "Gospel reconstructed for $PROJECT_NAME"
    exit 0
  fi
fi

# Fallback: minimal gospel template
cat > "$GOSPEL_FILE" << EOF
---
project: "$PROJECT_NAME"
vision: "TBD — fill in project vision"
created: "$(date +%Y-%m-%d)"
status: "active"
---
<!-- Reconstructed retroactively from project history by HEM v4 backfill -->
<!-- TODO: Fill in actual project vision and intent -->

## Original Intent
$PROJECT_NAME — purpose to be documented.

## Vision Statement
TBD

## Scope Boundaries
TBD

## Success Criteria
TBD
EOF

echo "Gospel template created for $PROJECT_NAME (needs manual review)"
