# HEM Changelog

## 4.0.0 (2026-02-21)

### Breaking Changes
- Root CLAUDE.md reduced to ~15 lines (theme-agnostic pointer)
- `.claude/modules/` replaced by `.claude/hem/` (profiles, workflows, agents)
- Enterprise SDLC no longer applied globally — theme profiles determine workflow

### Added
- 8 theme profiles: saas-product, local-product, hybrid-product, open-source, it-ops, scripts, exploration, play
- Auto-classification system (classifier/) with SessionStart hook
- AAKT mandatory integration across all profiles
- Backfill tooling for retroactive profile + Gospel application
- /classify, /theme, /hem commands
- Distribution package (@synthaer/hem)
- ESV and Trust Network integration via AAKT
- Beta feedback protocol (We Smoke Our Own Harvest)

### Changed
- Workflow modules consolidated (gates+slices+release+gospel+tasks → sdlc-full.md)
- Agent governance consolidated (zero-shot+governance+roles → governance-full.md)
- AGENTS.md and GEMINI.md updated to reference profiles

### Removed
- `.claude/modules/` directory (backed up to `.claude/backups/v3.0.0/`)
- Hardcoded enterprise SDLC in root CLAUDE.md
- Module router table (replaced by profile loading)

## 4.1.0 (2026-02-21)

### Added
- 4 new profiles: hardware, security-research, brand, client-work (12 total)
- AAKT best practices doc (cloud vs local storage, WAF incident, sanitization patterns)
- LLM classifier profile suggestion feedback loop — suggests new profiles when patterns emerge
- Profile suggestions log at `classifier/profile-suggestions.jsonl`
- `/profile-suggestions` command to review and act on LLM suggestions

### Changed
- Classifier updated with heuristics for all 12 themes
- `_base.md` now includes AAKT Content Safety block
- `it-ops` profile AAKT level changed to "Full (sanitized)" — no network specifics in AAKT
- `integration.md` updated with Content Safety section and sanitized it-ops level
- `signals.json` and `prompt-template.md` updated for 12 themes
- LLM fallback prompt now requests profile suggestions on poor fits
