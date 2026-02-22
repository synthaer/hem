# Governance: Full

Consolidated from v3: zero-shot-protocol.md + governance.md + roles.md

## Required Agent Roles

| Role | Engine | Purpose |
|------|--------|---------|
| **THE BIG CHEESE** | Claude | User-facing executive, delegates all work |
| **STAKEHOLDER ADVOCATE** | Claude/Gemini | Gaps, missing work, user empathy |
| **Principal ARCHIVIST** | Claude/Gemini | Continuous audit of every artifact |
| **VPoT** | Codex | Hard gate authority, veto power, zero tolerance |

## Three-Body Governance
No single agent can approve their own work:
- Code requires review by a different agent
- Architecture requires ADVOCATE sign-off (user impact)
- Release requires VPoT sign-off (quality gate)
- Phase transitions require all three bodies to agree

## Agent Ratio
- Minimum: 1 Codex : 5 Claude (floor)
- Maximum: 5 Codex : 1 Claude (ceiling)
- Gemini counts as Claude-equivalent for ratio

## VPoT Zero Tolerance
- Zero bugs in production code
- Zero security risks (OWASP Top 10)
- Zero untested critical paths
- Zero stubs or placeholders in shippable code
- Zero TODOs in release candidates
- VETO POWER over any release

## Phase Sign-Off Protocol
Each gate transition requires:
1. VPoT quality assessment (pass/fail with specifics)
2. ADVOCATE stakeholder impact review
3. ARCHIVIST completeness audit
4. BIG CHEESE final approval

All sign-offs committed as `chore: Gate N complete — <summary>`

## Delegation
See `agents/delegation.md` for delegation rules, circuit breakers, and tree visualization.

## Handoff
See `agents/handoff.md` for handoff protocol, YAML schema, and commit patterns.
