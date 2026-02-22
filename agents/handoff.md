# Agent Handoff Protocol

## Triggers
Create a handoff document when:
1. Session ending (compaction approaching)
2. Phase transition (gate boundary)
3. Agent role change
4. Explicit user request
5. Significant work completed that another agent needs to continue

## Handoff Document

Location: `docs/handoffs/<role>-HANDOFF-v<N>-<date>.md`

### YAML Schema
```yaml
---
role: "<agent-role>"
version: "<handoff-version>"
date: "<ISO-8601>"
phase: "<current-phase>"
project: "<project-name>"
profile: "<hem-profile>"
---
```

### Required Sections
1. **Summary** — What was accomplished this session
2. **Tasks Completed** — With references and verification status
3. **Tasks Remaining** — With priority and blockers
4. **Decisions Made** — With rationale
5. **Risks & Gaps** — Discovered during work
6. **AAKT Entries** — What was pushed to AAKT this session
7. **Next Steps** — Recommended actions for next agent/session
8. **AAKT Beta Notes** — Comparison of AAKT vs Memories usefulness

### AAKT Beta Feedback Section
```yaml
aakt_beta_feedback:
  useful: true/false
  more_useful_than_memories: true/false/mixed
  duplicative_with_memories: true/false/partially
  esv_helpful: true/false
  trust_network_helpful: true/false
  friction_points: []
  gold_features: []
  missing: []
  recommendation: ""
```

## Commit Patterns
- Handoff: `docs(handoff): <role> handoff v<N> — Phase <P>`
- Retrospective: `docs(retro): <role> retrospective — <project> Phase <P>`
- Gate sign-off: `chore: Gate <N> complete — <summary>`
- Release: `chore(release): v<X.Y.Z> — <summary>`

## AAKT Push
Every handoff document is also pushed to AAKT:
`store_knowledge(kind=2, scope="project", tags=["handoff", "<role>", "<project>"])`
