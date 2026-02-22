# Workflow: Full SDLC

Consolidated from v3: gates.md + slices.md + release-gate.md + gospel.md + task-tracking.md

## Gospel Protocol
The Gospel is the project's founding charter — captured once, referenced always.

Location: `docs/gospel/GOSPEL.md`

```yaml
---
project: "<name>"
vision: "<one-sentence vision>"
created: "<date>"
author: "<who initiated>"
status: "active"
---
```

Body contains: Original intent, vision statement, scope boundaries, success criteria, non-goals.

## Gates (Phase Milestones)

### Gate 0 — Genesis
- Gospel captured and committed
- TASKS.md initialized
- Architecture doc drafted (living document)
- Git repo initialized with branch strategy
- Deliverable: converged requirements

### Gate 1 — Foundation
- Architecture validated against requirements
- Toolchain configured (build, test, lint, CI)
- Development environment reproducible
- First vertical slice identified
- Deliverable: buildable project skeleton

### Gate 2 — Build
- Vertical slices implemented (Slice 1-6 per capability)
- Tests passing, coverage tracked
- Documentation updated continuously
- Sprint reviews at capability boundaries
- Deliverable: working software

### Gate 3 — Ship
- All capabilities complete and tested
- Release gate checklist passed
- Documentation complete
- VPoT sign-off obtained
- Deliverable: shippable product

## Vertical Slices (Per Capability)

Each capability goes through 6 slices:

1. **Slice 1 — Skeleton**: Route/endpoint exists, returns placeholder. Proves wiring works.
2. **Slice 2 — Happy Path**: Core logic implemented. Primary use case works end-to-end.
3. **Slice 3 — Validation**: Input validation, error handling, edge cases.
4. **Slice 4 — Tests**: Unit tests, integration tests. Coverage target met.
5. **Slice 5 — Polish**: Error messages, logging, performance. Production-ready.
6. **Slice 6 — Documentation**: API docs, user docs, architecture updates.

## Task Tracking (TASKS.md)

```markdown
## [Capability Name]
- [ ] Task description [TASK-001]
- [~] In-progress task [TASK-002]
- [x] Completed task [TASK-003]
- [!] Blocked task [TASK-004] — reason
```

Update markers atomically. Commit TASKS.md changes with task reference.

## Release Gate Checklist
- [ ] All tests passing
- [ ] No critical/high security issues
- [ ] Documentation complete and accurate
- [ ] CHANGELOG updated
- [ ] Version bumped
- [ ] VPoT sign-off
- [ ] Stakeholder review complete
