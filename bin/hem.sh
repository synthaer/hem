#!/usr/bin/env bash
# HEM CLI — Hedonistic Engineering Method
set -euo pipefail

VERSION="4.0.0"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# When installed via npm, HEM_ROOT is the dist dir; otherwise find .claude/hem
HEM_ROOT="${HEM_DIR:-$(git rev-parse --show-toplevel 2>/dev/null)/.claude/hem}"

usage() {
  cat <<EOF
hem v$VERSION — Hedonistic Engineering Method

Usage: hem <command> [options]

Commands:
  init          Classify current project and generate CLAUDE.md
  classify      Reclassify current project
  backfill      Apply HEM profiles to all project directories
  update        Update HEM to latest version
  profile list  List available profiles
  profile show  Show current project's profile
  version       Show HEM version
  help          Show this help

Options:
  --dry-run     Preview changes without applying (for backfill)

EOF
}

cmd="${1:-help}"
shift || true

case "$cmd" in
  init|classify)
    if [[ -x "$HEM_ROOT/classifier/classify.sh" ]]; then
      "$HEM_ROOT/classifier/classify.sh" "${1:-.}"
    else
      echo "ERROR: Classifier not found at $HEM_ROOT/classifier/classify.sh"
      exit 1
    fi
    ;;
  backfill)
    if [[ -x "$HEM_ROOT/backfill/backfill.sh" ]]; then
      "$HEM_ROOT/backfill/backfill.sh" "${1:---dry-run}"
    else
      echo "ERROR: Backfill script not found"
      exit 1
    fi
    ;;
  update)
    REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
    if [[ -x "$REPO_ROOT/.claude/scripts/hem-update.sh" ]]; then
      bash "$REPO_ROOT/.claude/scripts/hem-update.sh"
    else
      echo "ERROR: Update script not found"
      exit 1
    fi
    ;;
  profile)
    subcmd="${1:-list}"
    case "$subcmd" in
      list)
        echo "Available HEM profiles:"
        for f in "$HEM_ROOT"/profiles/*.md; do
          name="$(basename "$f" .md)"
          [[ "$name" == _base ]] && continue
          desc=$(head -1 "$f" | sed 's/^# HEM Profile: //')
          printf "  %-20s %s\n" "$name" "$desc"
        done
        ;;
      show)
        REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
        if [[ -f "$REPO_ROOT/CLAUDE.md" ]]; then
          grep -oP '(?<=<!-- HEM Profile: )\S+(?= -->)' "$REPO_ROOT/CLAUDE.md" 2>/dev/null || echo "No profile set"
        else
          echo "No CLAUDE.md found"
        fi
        ;;
      *)
        echo "Usage: hem profile [list|show]"
        ;;
    esac
    ;;
  version|--version|-v)
    echo "hem v$VERSION"
    ;;
  help|--help|-h)
    usage
    ;;
  *)
    echo "Unknown command: $cmd"
    usage
    exit 1
    ;;
esac
