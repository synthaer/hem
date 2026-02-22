#!/usr/bin/env bash
# HEM Legacy Synthesizer — extract custom content from old CLAUDE.md
set -euo pipefail

LEGACY_FILE="${1:?Usage: synthesize-legacy.sh <path-to-legacy-claude.md>}"

if [[ ! -f "$LEGACY_FILE" ]]; then
  echo ""
  exit 0
fi

# Extract useful sections from legacy CLAUDE.md
# Look for: tech stack, build commands, project-specific rules, endpoints, architecture notes
python3 -c "
import re, sys

with open('$LEGACY_FILE', 'r') as f:
    content = f.read()

# Skip HEM boilerplate sections
skip_patterns = [
    r'## Core Identity.*?(?=\n## |\Z)',
    r'## Module Router.*?(?=\n## |\Z)',
    r'## Always-On Rules.*?(?=\n## |\Z)',
    r'## Required Agent Roles.*?(?=\n## |\Z)',
    r'## Skills & Commands.*?(?=\n## |\Z)',
    r'## Current Focus.*?(?=\n## |\Z)',
    r'# Hedonistic Engineering.*?\n',
]

for pattern in skip_patterns:
    content = re.sub(pattern, '', content, flags=re.DOTALL)

# Clean up excessive whitespace
content = re.sub(r'\n{3,}', '\n\n', content).strip()

if len(content) > 20:
    print(content)
" 2>/dev/null || true
