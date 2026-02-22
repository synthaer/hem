# AAKT Integration — Mandatory Infrastructure

AAKT (All-Agent Knowledge Trust) is mandatory for ALL HEM profiles.
Every agent in every theme uses AAKT. Depth varies by theme but the floor is non-zero.

## Per-Profile AAKT Requirements

| Profile | Level | What Gets Stored |
|---------|-------|-----------------|
| saas-product | Full | Knowledge, experiences, decisions, handoffs, retrospectives, gaps, risks |
| local-product | Full | Same as saas-product |
| hybrid-product | Full | Same + deployment context |
| open-source | Moderate | Decisions, architecture patterns, community findings |
| it-ops | Full (sanitized) | Change decisions, incident summaries, patterns. **NO network specifics** (see best-practices.md) |
| scripts | Light | Interesting patterns, reusable snippets, gotchas |
| exploration | Moderate | All findings, sources, research threads |
| play | Minimal | Anything surprising or worth remembering |

## Mandatory AAKT Calls (All Profiles)

### Session Start
```
query_knowledge(scope="project", tags=["<project-name>"])
```
Retrieve context from previous sessions. What do I know about this project?

### Discovery
```
store_knowledge(kind=1, scope="project", text="<finding>", tags=["<project>", "<topic>"])
```
When learning something new about the project, codebase, or domain.

### Decision
```
store_experience(kind=2, scope="project", text="<decision + rationale>", tags=["decision", "<project>"])
```
When making a non-trivial choice.

### Error / Surprise
```
store_experience(kind=4, scope="project", text="<what happened + context>", tags=["error", "<project>"])
```
When something unexpected occurs.

### Session End
```
store_experience(kind=1, scope="project", text="<session summary>", tags=["session", "<project>"])
```
Session summary with confidence assessment.

### Handoff
```
store_knowledge(kind=2, scope="project", text="<full handoff>", tags=["handoff", "<role>", "<project>"])
```
Full handoff document pushed to AAKT.

## Super Context: Cross-Project Memory

AAKT creates a super context spanning all projects:
- When working on `cloudyday` (it-ops), AAKT knows about DNS changes in `infra-nydc1.arf.io`
- When working on `project-auth`, AAKT knows about API changes in `project-admin`
- When working on `key-gen`, AAKT remembers crypto patterns from `fido2token`

This is the killer feature. No other AI memory system provides cross-project continuity
at this granularity.

## Cross-Project Event Schema

```yaml
kind: 1  # DECLARATIVE
scope: "global"
key: "cross-project:<source>:<event-type>:<timestamp>"
tags: ["cross-project", "<source>", "<affected>", "<event-type>"]
text: |
  Source: <source-project>
  Event: <event-type>
  Changed: <description>
  Affects: <list of affected projects>
  Breaking: Yes/No
  Action Required: <description>
  Urgency: immediate/next-session/informational
```

## Content Safety — READ FIRST

**Before storing ANY knowledge in AAKT, read `aakt/best-practices.md`.**

Key rules:
- **Never store network specifics** (IPs, VLANs, ports, firewall rules, SSH configs)
- **Infrastructure details stay local** (MEMORY.md, project docs, runbooks)
- **Sanitize before storing** — strip connection details, keep the pattern
- **The test:** "If an attacker read this, could they access my network?" → keep local
- **WAF will block infra text** — Cloudflare flags SSH/firewall terminology as attack payloads

See `aakt/best-practices.md` for the full incident report and sanitization patterns.

## ESV and Trust Network

Every agent interaction with AAKT includes:
- **ESV (Emotional State Vector):** Confidence, satisfaction, uncertainty per agent per session
- **Trust Network:** Agent-to-agent trust scores

These metrics feed into:
- Agent selection (prefer high-trust agents for critical work)
- Handoff quality (flag low-confidence handoffs for human review)
- Content quality (weight high-trust-source knowledge higher in retrieval)
