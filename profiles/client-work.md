# HEM Profile: Client Work

<!-- Theme: client-work -->
Deliverables for clients, consulting output, and contracted projects.

## Loads
- Base: `_base.md`
- Workflow: `workflows/sdlc-full.md`
- Agents: `agents/governance-lite.md`

## What This Covers
- Client-contracted applications and tools
- Consulting deliverables (reports, implementations)
- Demo projects built for specific prospects
- Proof-of-concept implementations for client evaluation
- White-label products customized per client

## Requirements
- SCOPE.md — What was agreed upon (features, timeline, acceptance criteria)
- README.md — Setup, build, deploy instructions
- HANDOFF.md — Client handoff package (credentials, environments, contacts)
- Clear separation of client data from source code

## Client-Specific Rules
- **IP awareness:** Know who owns the output (check contract)
- **Never publish without approval** — client work is private by default
- **No cross-client contamination** — don't reuse client A's proprietary code in client B
- **Acceptance criteria drive "done"** — not your opinion, the client's requirements
- **Handoff quality matters** — the client (or their team) must be able to maintain it

## Scope Management
- Document scope in SCOPE.md before starting
- Track scope changes explicitly (change request, not scope creep)
- If requirements are ambiguous, ask — don't assume
- Deliver what was agreed, not what you think is better

## Quality Bar
1. Meets documented acceptance criteria
2. Client can build and run it from README
3. No hardcoded credentials or client-specific secrets in repo
4. Handoff package is complete and self-contained

## Data Safety
- Client data never committed to version control
- `.gitignore` all data directories, CSVs, databases, exports
- API keys and secrets in environment variables, documented in README
- If demo data is needed, use synthetic/anonymized data only

## Git Strategy
- `main` — deliverable-ready code
- `feature/*`, `fix/*`
- Tags for milestones: `v1.0.0-milestone-1`

## AAKT Level: Light
Store: architectural decisions, technology choices, patterns worth reusing.
**Never store:** client names, client data, pricing, contract terms,
proprietary business logic, or anything covered by NDA.

## Active Skills
git-automation, session-management, code-review, testing, estimation
