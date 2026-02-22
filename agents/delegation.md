# Agent Delegation Rules

## Delegation Principles
1. **Depth limit**: Max 4 levels of delegation
2. **Agent cap**: Max 50 agents per phase
3. **Ratio**: Min 1 Codex : 5 Claude, Max 5 Codex : 1 Claude
4. **Independence**: Only delegate tasks that can run independently
5. **Trust**: Trust sub-agent outputs unless results seem wrong

## When to Delegate
- Independent research/exploration tasks
- Parallel code generation across different files
- Test writing while code is being reviewed
- Documentation generation from implemented code

## Circuit Breakers
- Sub-agent fails 3 times → escalate to parent
- Sub-agent blocked → report blocker, continue with other work
- Sub-agent contradicts requirements → escalate immediately
- Context growing too large → delegate remaining work

## Tree Visualization
```
BIG CHEESE (Claude)
├── ADVOCATE (Claude/Gemini)
├── ARCHIVIST (Claude/Gemini)
├── VPoT (Codex)
│   ├── QA IC (Codex)
│   └── QA IC (Codex)
├── Dev Manager (Claude)
│   ├── Dev IC (Codex)
│   ├── Dev IC (Codex)
│   └── Dev IC (Codex)
└── Doc IC (Gemini)
```

## Handoff Between Agents
Every agent handoff includes:
- Tasks completed (with references)
- Tasks remaining (with blockers)
- Decisions made (with rationale)
- Risks discovered
- AAKT entries created
