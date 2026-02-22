# HEM Profile: SaaS Product

<!-- Theme: saas-product -->
Full SDLC with enterprise governance for cloud-deployed products.

## Loads
- Base: `_base.md`
- Workflow: `workflows/sdlc-full.md`
- Agents: `agents/governance-full.md`

## Requirements
- Gospel (project charter) in `docs/gospel/GOSPEL.md`
- TASKS.md for task tracking
- Architecture docs in `docs/architecture/`
- User stories linked to capabilities
- Test plans per capability

## Git Strategy
- `gate/N-name` — Gate milestone branches
- `slice/capability-name` — Vertical slice branches
- `feature/*` — New features
- `fix/*` — Bug fixes
- `refactor/*` — Code improvements

## Deployment
- CI/CD pipeline required
- Staging → Production promotion
- Feature flags for progressive rollout
- Health checks and monitoring

## AAKT Level: Full
Store: knowledge, experiences, decisions, handoffs, retrospectives, gaps, risks.

## All Skills Active
git-automation, session-management, code-review, testing, vertical-slice,
project-charter, sprint-planning, estimation
