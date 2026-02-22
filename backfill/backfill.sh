#!/usr/bin/env bash
# HEM Backfill — retroactively apply HEM profiles to all project directories
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
HEM_DIR="$REPO_ROOT/.claude/hem"
CLASSIFIER="$HEM_DIR/classifier/classify.sh"
INVENTORY_SCRIPT="$HEM_DIR/backfill/inventory.sh"
SYNTHESIZE_SCRIPT="$HEM_DIR/backfill/synthesize-legacy.sh"
DRY_RUN="${1:---dry-run}"

if [[ ! -x "$CLASSIFIER" ]]; then
  chmod +x "$CLASSIFIER"
fi

echo "=== HEM v4 Backfill ==="
echo "Mode: $DRY_RUN"
echo ""

TOTAL=0
CLASSIFIED=0
ARCHIVED=0
GENERATED=0
SKIPPED=0

# Walk all top-level project directories
for dir in "$REPO_ROOT"/*/; do
  [[ ! -d "$dir" ]] && continue
  PROJECT_NAME="$(basename "$dir")"

  # Skip hidden dirs, backups, node_modules, .build
  [[ "$PROJECT_NAME" == .* ]] && continue
  [[ "$PROJECT_NAME" == node_modules ]] && continue

  TOTAL=$((TOTAL + 1))

  # Classify
  RESULT=$("$CLASSIFIER" "$dir" 2>/dev/null || echo "scripts|fallback")
  THEME=$(echo "$RESULT" | cut -d'|' -f1)
  REASON=$(echo "$RESULT" | cut -d'|' -f2-)

  CLASSIFIED=$((CLASSIFIED + 1))

  if [[ "$DRY_RUN" == "--dry-run" ]]; then
    printf "  %-45s → %-18s (%s)\n" "$PROJECT_NAME" "$THEME" "$REASON"
    continue
  fi

  # Archive existing CLAUDE.md
  if [[ -f "$dir/CLAUDE.md" ]]; then
    mkdir -p "$dir/docs"
    if [[ ! -f "$dir/docs/CLAUDE-historical.md" ]]; then
      cp "$dir/CLAUDE.md" "$dir/docs/CLAUDE-historical.md"
      ARCHIVED=$((ARCHIVED + 1))
    fi

    # Synthesize custom content from legacy
    CUSTOM=""
    if [[ -x "$SYNTHESIZE_SCRIPT" ]]; then
      CUSTOM=$("$SYNTHESIZE_SCRIPT" "$dir/docs/CLAUDE-historical.md" 2>/dev/null || true)
    fi
  fi

  # Generate new CLAUDE.md from template
  cat > "$dir/CLAUDE.md" << TMPL
# $PROJECT_NAME

<!-- HEM Profile: $THEME -->

## Profile
This project uses the **$THEME** HEM profile.
Read \`.claude/hem/profiles/_base.md\` then \`.claude/hem/profiles/$THEME.md\`.
TMPL

  if [[ -n "${CUSTOM:-}" ]]; then
    echo "" >> "$dir/CLAUDE.md"
    echo "## Project-Specific Context" >> "$dir/CLAUDE.md"
    echo "$CUSTOM" >> "$dir/CLAUDE.md"
  fi

  GENERATED=$((GENERATED + 1))
done

echo ""
echo "=== Backfill Report ==="
echo "Total projects scanned: $TOTAL"
echo "Classified: $CLASSIFIED"
if [[ "$DRY_RUN" != "--dry-run" ]]; then
  echo "Legacy CLAUDE.md archived: $ARCHIVED"
  echo "New CLAUDE.md generated: $GENERATED"
  echo "Skipped: $SKIPPED"
fi
echo ""
if [[ "$DRY_RUN" == "--dry-run" ]]; then
  echo "This was a dry run. Run with --apply to make changes:"
  echo "  bash $0 --apply"
fi
