# Workflow: Change Management

IT operations workflow for infrastructure changes.

## Change Request Flow

### 1. Request
Document the change:
- **What**: Specific systems and changes
- **Why**: Business justification or incident reference
- **Impact**: Affected services, users, downstream systems
- **Rollback**: How to revert if something goes wrong
- **Window**: Maintenance window or schedule

### 2. Pre-Change Checklist
- [ ] Backups verified (config, data, state)
- [ ] Affected parties notified
- [ ] Maintenance window confirmed (if applicable)
- [ ] Rollback procedure tested (if possible)
- [ ] Monitoring/alerts configured for post-change verification
- [ ] Change logged in CHANGELOG.md

### 3. Execute
- Follow runbook if one exists
- Document deviations from plan
- Capture output/logs of significant operations

### 4. Verify
- Health checks on affected systems
- Smoke tests on critical paths
- Monitor for 15-30 minutes post-change
- Verify downstream systems unaffected

### 5. Close
- Update CHANGELOG.md with final status
- Update runbooks if procedure changed
- Update INFRASTRUCTURE.md if topology changed
- Store change record in AAKT

## Incident Response
1. Identify and contain
2. Communicate (affected parties, stakeholders)
3. Fix or rollback
4. Post-incident review
5. Update runbooks to prevent recurrence
6. Store incident in AAKT for cross-project awareness

## Runbook Protocol
Location: `runbooks/<system-name>/<operation>.md`

Every runbook contains:
- Prerequisites
- Step-by-step procedure
- Verification steps
- Rollback procedure
- Last tested date
