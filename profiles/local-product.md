# HEM Profile: Local Product

<!-- Theme: local-product -->
Full SDLC for locally-distributed desktop/CLI applications. No cloud deployment.

## Loads
- Base: `_base.md`
- Workflow: `workflows/sdlc-full.md`
- Agents: `agents/governance-full.md`

## Requirements
- Gospel in `docs/gospel/GOSPEL.md`
- TASKS.md for task tracking
- Architecture docs in `docs/architecture/`
- Platform build instructions (Makefile, Package.swift, Cargo.toml, etc.)

## Git Strategy
- `gate/N-name` — Gate milestone branches
- `slice/capability-name` — Vertical slice branches
- `feature/*`, `fix/*`, `refactor/*`

## Build & Distribution
- Platform-specific build system (make, swift build, cargo, etc.)
- Release binaries or installers
- No CI/CD deployment gates — local build verification sufficient
- README with build prerequisites and instructions

## AAKT Level: Full
Store: knowledge, experiences, decisions, handoffs, retrospectives, gaps, risks.

## All Skills Active
git-automation, session-management, code-review, testing, vertical-slice,
project-charter, sprint-planning, estimation
