#!/usr/bin/env bash
# HEM Install — fresh install of Hedonistic Engineering Method v4
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
CLAUDE_DIR="$REPO_ROOT/.claude"
HEM_DIR="$CLAUDE_DIR/hem"

if [[ -f "$HEM_DIR/VERSION" ]]; then
  echo "HEM already installed (v$(cat "$HEM_DIR/VERSION")). Use hem-update.sh to update."
  exit 1
fi

echo "Installing HEM v4..."

# Create directory structure
mkdir -p "$HEM_DIR"/{profiles,workflows,agents,classifier,hooks,templates,backfill,dist/bin,aakt}

# Verify structure
for d in profiles workflows agents classifier hooks templates backfill dist aakt; do
  if [[ ! -d "$HEM_DIR/$d" ]]; then
    echo "ERROR: Failed to create $HEM_DIR/$d"
    exit 1
  fi
done

echo "HEM v4 directory structure created at $HEM_DIR"
echo "Next: populate profile files, then run hem-migrate-v3-to-v4.sh if upgrading from v3"
