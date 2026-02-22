#!/usr/bin/env bash
# HEM Update — update HEM to latest version
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
CLAUDE_DIR="$REPO_ROOT/.claude"
HEM_DIR="$CLAUDE_DIR/hem"
BACKUP_SCRIPT="$CLAUDE_DIR/scripts/hem-backup.sh"

if [[ ! -f "$HEM_DIR/VERSION" ]]; then
  echo "HEM not installed. Use hem-install.sh first."
  exit 1
fi

CURRENT_VERSION=$(cat "$HEM_DIR/VERSION")
echo "Current HEM version: $CURRENT_VERSION"

# Backup current version
echo "Backing up current version..."
bash "$BACKUP_SCRIPT" "$CURRENT_VERSION"

# Version bump (increment patch)
IFS='.' read -r major minor patch <<< "$CURRENT_VERSION"
NEW_VERSION="$major.$minor.$((patch + 1))"
echo "$NEW_VERSION" > "$HEM_DIR/VERSION"

# Update hem.json version
if command -v python3 >/dev/null 2>&1; then
  python3 -c "
import json
with open('$HEM_DIR/hem.json', 'r') as f:
    data = json.load(f)
data['version'] = '$NEW_VERSION'
with open('$HEM_DIR/hem.json', 'w') as f:
    json.dump(data, f, indent=2)
"
fi

# Append to changelog
echo "" >> "$HEM_DIR/CHANGELOG.md"
echo "## $NEW_VERSION ($(date +%Y-%m-%d))" >> "$HEM_DIR/CHANGELOG.md"
echo "" >> "$HEM_DIR/CHANGELOG.md"
echo "### Updated" >> "$HEM_DIR/CHANGELOG.md"
echo "- Version bump from $CURRENT_VERSION" >> "$HEM_DIR/CHANGELOG.md"

echo "HEM updated: $CURRENT_VERSION → $NEW_VERSION"
