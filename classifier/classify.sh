#!/usr/bin/env bash
# HEM Project Classifier — determines theme profile for a project directory
set -euo pipefail

PROJECT_DIR="${1:-.}"
PROJECT_NAME="$(basename "$(cd "$PROJECT_DIR" && pwd)")"
PROJECT_NAME_LOWER="$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]')"

# Collect signals
has_file() { [[ -f "$PROJECT_DIR/$1" ]]; }
has_dir() { [[ -d "$PROJECT_DIR/$1" ]]; }
has_glob() { compgen -G "$PROJECT_DIR/$1" >/dev/null 2>&1; }
file_count() { find "$PROJECT_DIR" -maxdepth 2 -type f 2>/dev/null | wc -l | tr -d ' '; }

# --- Heuristic classification (fast, no API call) ---

# Security Research (check before it-ops — some overlap in network tooling)
if has_file "AUTHORIZATION.md" || [[ "$PROJECT_NAME_LOWER" =~ (red-team|redteam|pentest|security[Rr]eview|exploit|ctf) ]]; then
  echo "security-research|Security research project (authorization doc or name pattern)"
  exit 0
fi
if [[ "$PROJECT_NAME" =~ ^(sniffies|PlausibleDeniability|observational_network|web-inspector) ]]; then
  echo "security-research|Security research project (known project: $PROJECT_NAME)"
  exit 0
fi

# IT Operations
if has_dir "runbooks" || [[ "$PROJECT_NAME" =~ ^(infra-|network|cloudyday|.*opnsense.*|.*openwrt.*|demonic-|firewall|zerotier|dnsvpn|unifi|solvemyemail|magic-pve|oops-i-pinged|voip|Bridge|routingTable|Windows_Network|remote$) ]]; then
  echo "it-ops|Infrastructure/network operations (signals: runbooks or name pattern)"
  exit 0
fi

# Brand / Personal (name patterns)
if [[ "$PROJECT_NAME_LOWER" =~ (brand|portfolio|manifesto|investor|hedonistic|damien|arfio[Ff]ont|upwork|jobapplication) ]]; then
  echo "brand|Personal brand/business asset (name pattern: $PROJECT_NAME)"
  exit 0
fi

# Hardware / Embedded (check before local-product — more specific)
if [[ "$PROJECT_NAME_LOWER" =~ (esp32|fido2|arduino|stm32|firmware|efi[Bb]oot|macosboot|macosvm|multiplus|asahi) ]]; then
  echo "hardware|Hardware/embedded project (name pattern: $PROJECT_NAME)"
  exit 0
fi
if has_file "platformio.ini" || has_file "sdkconfig" || has_dir "components"; then
  echo "hardware|Hardware/embedded project (build system signals)"
  exit 0
fi
if has_glob "*.ino" || has_glob "*.hex" || has_glob "*.bin" || has_glob "*.uf2"; then
  echo "hardware|Hardware/embedded project (firmware file signals)"
  exit 0
fi

# Client Work (check for scope/handoff docs)
if has_file "SCOPE.md" || has_file "HANDOFF.md"; then
  echo "client-work|Client deliverable (has SCOPE.md or HANDOFF.md)"
  exit 0
fi

# SaaS Product (cloud-deployed)
if has_file "docker-compose.yml" && has_dir "src" && has_file "package.json"; then
  if has_file "Dockerfile" || has_dir ".github"; then
    echo "saas-product|Cloud-deployed product (docker-compose + src + package.json + CI)"
    exit 0
  fi
fi

# Local Product (desktop/CLI — native build systems)
if has_file "Makefile" && (has_glob "*.c" || has_glob "*.swift" || has_glob "*.rs" || has_file "Package.swift" || has_file "Cargo.toml"); then
  echo "local-product|Local application (Makefile + native source)"
  exit 0
fi
if has_file "Package.swift" || has_file "Cargo.toml"; then
  echo "local-product|Local application (native build system)"
  exit 0
fi
# Local Product — Python with build system and structured src/
if has_dir "src" && (has_file "pyproject.toml" || has_file "setup.py" || has_file "setup.cfg") && has_dir "tests"; then
  echo "local-product|Local application (Python project with tests)"
  exit 0
fi

# Hybrid Product
if has_file "docker-compose.yml" && (has_file "Makefile" || has_file "Package.swift"); then
  echo "hybrid-product|Hybrid deployment (both local build and docker)"
  exit 0
fi

# Open Source
if has_file "CONTRIBUTING.md" || (has_file "LICENSE" && has_dir "src"); then
  echo "open-source|Open source project (CONTRIBUTING.md or LICENSE + src)"
  exit 0
fi

# Exploration (mostly markdown, research dirs, no substantial source)
MD_COUNT=$(find "$PROJECT_DIR" -maxdepth 3 -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
SRC_COUNT=$(find "$PROJECT_DIR" -maxdepth 3 \( -name "*.ts" -o -name "*.js" -o -name "*.py" -o -name "*.swift" -o -name "*.c" -o -name "*.rs" -o -name "*.go" \) -type f 2>/dev/null | wc -l | tr -d ' ')
if [[ "$MD_COUNT" -gt 5 ]] && [[ "$SRC_COUNT" -lt 5 ]]; then
  echo "exploration|Research/exploration project (${MD_COUNT} markdown, ${SRC_COUNT} source files)"
  exit 0
fi
if has_dir "patent" || has_dir "research" || has_dir "analysis"; then
  echo "exploration|Research project (has patent/, research/, or analysis/ dirs)"
  exit 0
fi

# Scripts (small, mostly shell/python)
COUNT=$(file_count)
if [[ "$COUNT" -lt 15 ]]; then
  if has_glob "*.sh" || has_glob "*.py" || has_glob "*.js"; then
    echo "scripts|Small utility/script project ($COUNT files)"
    exit 0
  fi
fi

# SaaS fallback (has package.json + src)
if has_file "package.json" && has_dir "src"; then
  echo "saas-product|Web application (package.json + src)"
  exit 0
fi

# --- Fallback: LLM classification ---
SIGNALS="Project: $PROJECT_NAME\n"
SIGNALS+="Files: ${COUNT:-$(file_count)}\n"
SIGNALS+="Has package.json: $(has_file package.json && echo yes || echo no)\n"
SIGNALS+="Has Makefile: $(has_file Makefile && echo yes || echo no)\n"
SIGNALS+="Has docker-compose: $(has_file docker-compose.yml && echo yes || echo no)\n"
SIGNALS+="Has src/: $(has_dir src && echo yes || echo no)\n"
SIGNALS+="Has runbooks/: $(has_dir runbooks && echo yes || echo no)\n"
SIGNALS+="Has AUTHORIZATION.md: $(has_file AUTHORIZATION.md && echo yes || echo no)\n"
SIGNALS+="Has SCOPE.md: $(has_file SCOPE.md && echo yes || echo no)\n"
SIGNALS+="Top-level files: $(ls "$PROJECT_DIR" 2>/dev/null | head -20 | tr '\n' ', ')\n"

SUGGESTIONS_LOG="$(cd "$(dirname "$0")/.." && pwd)/classifier/profile-suggestions.jsonl"

if command -v claude >/dev/null 2>&1; then
  LLM_PROMPT="Classify this project into one of the existing HEM themes:
saas-product, local-product, hybrid-product, open-source, it-ops,
scripts, exploration, play, hardware, security-research, brand, client-work.

IMPORTANT: If this project does NOT fit well into any existing theme, you MUST
suggest a new profile. Projects forced into 'scripts' as a fallback are a signal
that a profile is missing.

Reply format — EXACTLY two lines:
Line 1: theme-name|reason (use best-fit existing theme)
Line 2: SUGGEST:new-theme-name|description of what this profile would cover|what signals indicate it
If no suggestion, Line 2 should be: SUGGEST:none

Examples:
scripts|Small shell utility
SUGGEST:none

scripts|Telegram bot with media processing — doesn't fit scripts or saas
SUGGEST:bot|Chat bots and messaging integrations (Telegram, Discord, Slack)|Has bot framework config, message handlers, webhook setup"

  RESULT=$(echo -e "$SIGNALS" | claude -p "$LLM_PROMPT" 2>/dev/null || true)
  if [[ -n "$RESULT" ]]; then
    # Extract classification (line 1)
    CLASSIFICATION=$(echo "$RESULT" | head -1)
    # Extract suggestion (line 2)
    SUGGESTION=$(echo "$RESULT" | grep "^SUGGEST:" | head -1)

    # Log suggestion if it's not "none"
    if [[ -n "$SUGGESTION" ]] && [[ "$SUGGESTION" != "SUGGEST:none" ]]; then
      SUGGESTED_THEME=$(echo "$SUGGESTION" | sed 's/^SUGGEST://' | cut -d'|' -f1)
      SUGGESTED_DESC=$(echo "$SUGGESTION" | sed 's/^SUGGEST://' | cut -d'|' -f2-)
      echo "{\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"project\":\"$PROJECT_NAME\",\"classified_as\":\"$(echo "$CLASSIFICATION" | cut -d'|' -f1)\",\"suggested_profile\":\"$SUGGESTED_THEME\",\"description\":\"$SUGGESTED_DESC\"}" >> "$SUGGESTIONS_LOG"
    fi

    echo "$CLASSIFICATION"
    exit 0
  fi
fi

# Ultimate fallback
echo "scripts|Could not classify — defaulting to scripts"
