#!/usr/bin/env bash
# HEM Inventory — scan all project directories and collect signals
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"

echo "project|files|has_pkg_json|has_makefile|has_docker|has_src|has_runbooks|has_claude_md|top_extensions"

for dir in "$REPO_ROOT"/*/; do
  [[ ! -d "$dir" ]] && continue
  NAME="$(basename "$dir")"
  [[ "$NAME" == .* ]] && continue
  [[ "$NAME" == node_modules ]] && continue

  FILES=$(find "$dir" -maxdepth 2 -type f 2>/dev/null | wc -l | tr -d ' ')
  HAS_PKG=$([[ -f "$dir/package.json" ]] && echo "Y" || echo "N")
  HAS_MAKE=$([[ -f "$dir/Makefile" ]] && echo "Y" || echo "N")
  HAS_DOCKER=$([[ -f "$dir/docker-compose.yml" ]] && echo "Y" || echo "N")
  HAS_SRC=$([[ -d "$dir/src" ]] && echo "Y" || echo "N")
  HAS_RUNBOOKS=$([[ -d "$dir/runbooks" ]] && echo "Y" || echo "N")
  HAS_CLAUDE=$([[ -f "$dir/CLAUDE.md" ]] && echo "Y" || echo "N")

  # Top extensions
  EXTS=$(find "$dir" -maxdepth 2 -type f -name "*.*" 2>/dev/null | sed 's/.*\.//' | sort | uniq -c | sort -rn | head -3 | awk '{print $2}' | tr '\n' ',' | sed 's/,$//')

  echo "$NAME|$FILES|$HAS_PKG|$HAS_MAKE|$HAS_DOCKER|$HAS_SRC|$HAS_RUNBOOKS|$HAS_CLAUDE|$EXTS"
done
