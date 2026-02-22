#!/usr/bin/env bash
# HEM Migration v3 → v4
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
CLAUDE_DIR="$REPO_ROOT/.claude"
HEM_DIR="$CLAUDE_DIR/hem"
BACKUP_DIR="$CLAUDE_DIR/backups/v3.0.0"

echo "=== HEM v3 → v4 Migration ==="

# Step 1: Backup v3
echo "[1/6] Backing up v3..."
if [[ ! -d "$BACKUP_DIR" ]]; then
  bash "$CLAUDE_DIR/scripts/hem-backup.sh" "3.0.0"
else
  echo "  v3 backup already exists"
fi

# Step 2: Move modules to backup
echo "[2/6] Archiving .claude/modules/..."
if [[ -d "$CLAUDE_DIR/modules" ]]; then
  if [[ ! -d "$BACKUP_DIR/modules" ]]; then
    cp -R "$CLAUDE_DIR/modules" "$BACKUP_DIR/modules"
  fi
  echo "  modules archived to backup"
fi

# Step 3: Verify HEM v4 structure exists
echo "[3/6] Verifying HEM v4 structure..."
for d in profiles workflows agents classifier hooks templates backfill dist aakt; do
  if [[ ! -d "$HEM_DIR/$d" ]]; then
    echo "  ERROR: $HEM_DIR/$d missing. Run hem-install.sh first."
    exit 1
  fi
done
echo "  HEM v4 structure verified"

# Step 4: Verify profile files
echo "[4/6] Verifying profile files..."
MISSING=0
for p in _base saas-product local-product hybrid-product open-source it-ops scripts exploration play; do
  if [[ ! -f "$HEM_DIR/profiles/$p.md" ]]; then
    echo "  MISSING: profiles/$p.md"
    MISSING=$((MISSING + 1))
  fi
done
if [[ $MISSING -gt 0 ]]; then
  echo "  ERROR: $MISSING profile files missing. Create them first."
  exit 1
fi
echo "  All profiles present"

# Step 5: Register hooks
echo "[5/6] Hook registration..."
echo "  Hooks should be registered in .claude/settings.local.json"
echo "  (Manual step — add SessionStart hook pointing to .claude/hem/hooks/session-start.sh)"

# Step 6: Version stamp
echo "[6/6] Finalizing..."
if [[ -f "$HEM_DIR/VERSION" ]]; then
  echo "  HEM v$(cat "$HEM_DIR/VERSION") installed"
else
  echo "  WARNING: VERSION file missing"
fi

echo ""
echo "=== Migration Complete ==="
echo "Next steps:"
echo "  1. Review root CLAUDE.md (should be ~15 lines)"
echo "  2. Register SessionStart hook in settings.local.json"
echo "  3. Run backfill: bash .claude/hem/backfill/backfill.sh --dry-run"
echo "  4. Commit: git add .claude/hem/ && git commit -m 'feat(hem): migrate to HEM v4'"
