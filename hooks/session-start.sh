#!/usr/bin/env bash
# HEM SessionStart Hook — auto-classify and announce theme
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
HEM_DIR="$REPO_ROOT/.claude/hem"
CLASSIFIER="$HEM_DIR/classifier/classify.sh"

# Check: does project CLAUDE.md exist with HEM profile header?
if [[ -f "$REPO_ROOT/CLAUDE.md" ]]; then
  PROFILE=$(grep -oP '(?<=<!-- HEM Profile: )\S+(?= -->)' "$REPO_ROOT/CLAUDE.md" 2>/dev/null || true)
  if [[ -n "$PROFILE" ]]; then
    echo "HEM v4: Profile [$PROFILE] active."
    exit 0
  fi
fi

# No profile found — classify if classifier exists
if [[ ! -x "$CLASSIFIER" ]]; then
  echo "HEM v4: No classifier found. Set profile manually with /classify."
  exit 0
fi

RESULT=$("$CLASSIFIER" "$REPO_ROOT" 2>/dev/null || echo "scripts|default")
THEME=$(echo "$RESULT" | cut -d'|' -f1)
REASON=$(echo "$RESULT" | cut -d'|' -f2-)

echo "HEM v4: Classified as [$THEME]. $REASON"
echo "Change with /classify or /theme."
