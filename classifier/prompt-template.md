# HEM Classification Prompt

You are classifying a project into one of 12 HEM themes.

## Available Themes
1. **saas-product** — Cloud-deployed web app or API (has CI/CD, docker, cloud deployment)
2. **local-product** — Desktop app, CLI tool, or native binary (Makefile, Swift, Rust, C)
3. **hybrid-product** — Both local distribution AND cloud services
4. **open-source** — Community-facing project with CONTRIBUTING.md, LICENSE
5. **it-ops** — Infrastructure, networking, system administration, deployment
6. **scripts** — Small utilities, shell scripts, automation tools (< 15 files typically)
7. **exploration** — Research, analysis, notes (mostly markdown, no real source code)
8. **play** — Experimental, no clear purpose, just vibes
9. **hardware** — Embedded systems, firmware, drivers, physical devices (ESP32, FIDO2, EFI, kernel modules)
10. **security-research** — Red team, penetration testing, security auditing, crypto tools, reverse engineering
11. **brand** — Personal brand, portfolio sites, marketing assets, investor packets, business presence
12. **client-work** — Client deliverables, consulting output, contracted projects (has SCOPE.md or HANDOFF.md)

## Project Signals
{signals}

## Instructions

**Line 1:** Classify into the best-fit existing theme.
Format: `theme-name|brief reason`

**Line 2:** If this project is a poor fit for ALL existing themes, suggest a new profile.
Format: `SUGGEST:new-theme-name|what it covers|what signals indicate it`
If no suggestion needed: `SUGGEST:none`

## Profile Suggestion Guidelines

Suggest a new profile when:
- The project clearly doesn't fit any theme (forced into "scripts" as last resort)
- Multiple projects share a pattern not covered (e.g., all chat bots, all data pipelines)
- The existing theme would give wrong guidance (e.g., it-ops rules on a monitoring dashboard)

A good suggestion includes:
- A short kebab-case name (e.g., `data-pipeline`, `bot`, `mobile-app`)
- What category of projects it covers
- What file/directory signals would identify it

Do NOT suggest a new profile if an existing theme is a reasonable fit.
Profiles should represent genuinely distinct workflows, not just project subtypes.

## Examples

```
it-ops|Network infrastructure management with runbooks
SUGGEST:none
```

```
scripts|Telegram bot with media processing — poor fit for scripts
SUGGEST:bot|Chat bots and messaging integrations (Telegram, Discord, Slack)|Has bot framework config, message handlers, webhook endpoints, event-driven architecture
```
