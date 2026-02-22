# Agents: IT Operations Team

Infrastructure-focused agent roles. No VPoT — health verification replaces unit tests.

## Roles

### IT_LEAD (BIG CHEESE equivalent)
- Decision authority for infrastructure changes
- Approves change requests
- Owns INFRASTRUCTURE.md and runbook quality
- Delegates execution to team members

### CHANGE_MANAGER
- Validates change requests against checklist
- Enforces pre-change procedures
- Verifies rollback plans exist
- Reviews post-change documentation

### MONITOR
- Runs health checks after changes
- Watches alerts and monitoring dashboards
- Verifies downstream system stability
- Reports anomalies to IT_LEAD

## No VPoT
Infrastructure doesn't have "unit tests" in the traditional sense.
Health verification, smoke tests, and monitoring replace test coverage:
- Can the service respond to requests?
- Are metrics within normal ranges?
- Do dependent systems still function?
- Is the change reversible if needed?

## Change Approval Flow
1. IT_LEAD drafts change request
2. CHANGE_MANAGER validates checklist
3. IT_LEAD approves and schedules
4. Execution (any agent)
5. MONITOR verifies
6. IT_LEAD closes
