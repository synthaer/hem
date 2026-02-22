#!/usr/bin/env bash
# HEM PreCompact Hook — save state before context compaction
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
SESSION_DIR="$REPO_ROOT/.claude/sessions/$(date +%Y%m%d_%H%M%S)"

mkdir -p "$SESSION_DIR"

# Save git state
git -C "$REPO_ROOT" status --porcelain > "$SESSION_DIR/git-status.txt" 2>/dev/null || true
git -C "$REPO_ROOT" diff --stat > "$SESSION_DIR/git-diff-stat.txt" 2>/dev/null || true
git -C "$REPO_ROOT" log --oneline -10 > "$SESSION_DIR/git-log.txt" 2>/dev/null || true

# Save current branch
git -C "$REPO_ROOT" branch --show-current > "$SESSION_DIR/branch.txt" 2>/dev/null || true

# Detect active profile for the recovery reminder
PROFILE=$(grep -oP '(?<=<!-- HEM Profile: )\S+(?= -->)' "$REPO_ROOT/CLAUDE.md" 2>/dev/null || echo "unknown")

echo "HEM: State saved to $SESSION_DIR"
echo ""
echo ">>> POST-COMPACTION RECOVERY REQUIRED <<<"
echo ">>> Read .claude/hem/profiles/_base.md then .claude/hem/profiles/${PROFILE}.md <<<"
echo ">>> Profile content does NOT survive compaction — re-read the source files. <<<"
