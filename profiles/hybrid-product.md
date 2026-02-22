# HEM Profile: Hybrid Product

<!-- Theme: hybrid-product -->
Full SDLC with dual deployment — local distribution AND cloud services.

## Loads
- Base: `_base.md`
- Workflow: `workflows/sdlc-full.md`
- Agents: `agents/governance-full.md`

## Requirements
- Gospel in `docs/gospel/GOSPEL.md`
- TASKS.md for task tracking
- Architecture docs covering both local and cloud components
- Dual deployment documentation

## Git Strategy
- `gate/N-name`, `slice/capability-name`, `feature/*`, `fix/*`, `refactor/*`

## Deployment
- Local: Platform-specific build + distribution
- Cloud: CI/CD pipeline, staging → production
- Sync strategy between local and cloud components documented

## AAKT Level: Full + Deployment Context
Store everything from saas-product plus deployment topology and sync strategies.

## All Skills Active
git-automation, session-management, code-review, testing, vertical-slice,
project-charter, sprint-planning, estimation
