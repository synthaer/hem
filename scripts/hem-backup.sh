#!/usr/bin/env bash
# HEM Backup Script — backs up current HEM version before migration
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
CLAUDE_DIR="$REPO_ROOT/.claude"
VERSION="${1:-3.0.0}"
BACKUP_DIR="$CLAUDE_DIR/backups/v${VERSION}"

if [[ -d "$BACKUP_DIR" ]]; then
  echo "Backup already exists at $BACKUP_DIR — skipping"
  exit 0
fi

mkdir -p "$BACKUP_DIR"

# Backup root instruction files
for f in CLAUDE.md AGENTS.md GEMINI.md; do
  [[ -f "$REPO_ROOT/$f" ]] && cp "$REPO_ROOT/$f" "$BACKUP_DIR/$f"
done

# Backup .claude subdirectories
for d in modules rules commands skills scripts hooks; do
  [[ -d "$CLAUDE_DIR/$d" ]] && cp -R "$CLAUDE_DIR/$d" "$BACKUP_DIR/$d"
done

# Generate manifest with checksums
manifest="$BACKUP_DIR/manifest.json"
echo "{" > "$manifest"
echo "  \"version\": \"$VERSION\"," >> "$manifest"
echo "  \"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"," >> "$manifest"
echo "  \"files\": {" >> "$manifest"

first=true
while IFS= read -r -d '' file; do
  rel="${file#$BACKUP_DIR/}"
  checksum=$(shasum -a 256 "$file" | cut -d' ' -f1)
  if $first; then first=false; else echo "," >> "$manifest"; fi
  printf "    \"%s\": \"%s\"" "$rel" "$checksum" >> "$manifest"
done < <(find "$BACKUP_DIR" -type f ! -name manifest.json -print0 | sort -z)

echo "" >> "$manifest"
echo "  }" >> "$manifest"
echo "}" >> "$manifest"

echo "Backup complete: $BACKUP_DIR"
echo "Files backed up: $(find "$BACKUP_DIR" -type f ! -name manifest.json | wc -l | tr -d ' ')"
