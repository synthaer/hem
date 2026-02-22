# AAKT Best Practices

Operational lessons learned from running AAKT in production across 117+ projects.

## The Cardinal Rule: Cloud vs Local

**AAKT is a cloud-hosted knowledge store. Treat it like one.**

AAKT lives behind OAuth and Cloudflare, but it is internet-accessible.
If AAKT is ever compromised, everything stored in it is exposed. Design
your storage strategy around this threat model.

### What Goes in AAKT (Cloud-Safe)
- Architectural decisions and rationale
- Design patterns and gotchas (described generically)
- Cross-project dependency information
- Session summaries and handoff documents
- Product strategy and feature plans
- Bug patterns and resolution strategies
- Research findings and references

### What Stays LOCAL ONLY (Never in AAKT)
- IP addresses, VLAN configurations, subnet ranges
- SSH configurations, port numbers, connection strings
- Firewall rules, nftables/iptables configurations
- Credentials, API keys, tokens (obviously)
- Network topology details
- VPN configurations, tunnel endpoints
- DNS zone records and resolver configs
- Server hostnames and FQDNs
- Certificate details and paths
- Docker/container networking specifics
- Any text that could reconstruct network access

### Where Local Knowledge Lives
- `MEMORY.md` — Claude's per-project persistent memory
- `.claude/modules/operations/network-ops.md` (v3) or project-local docs
- Project `docs/` directory (runbooks, deploy guides)
- `INFRASTRUCTURE.md` in it-ops projects
- Never committed to public repos; `.gitignore` sensitive files

## The Sanitization Pattern

When an infrastructure insight IS worth sharing cross-project via AAKT,
sanitize it first. Strip connection details, keep the pattern.

### BAD (contains network specifics):
```
"vlan100 is 100.100.100.0/24 with unrestricted SSH access.
MaxStartups 50:30:200 on port 22. Use tmux attach to reconnect."
```

### GOOD (pattern only, details stripped):
```
"Management VLAN uses unrestricted SSH. Key pattern: persistent
tmux/screen sessions avoid connection limits during bulk operations.
See local ops docs for connection details."
```

### The Test
Before storing in AAKT, ask: **"If an attacker read this, could they
use it to access, map, or attack my network?"** If yes, sanitize or
keep local.

## Cloudflare WAF and AAKT

### The Problem
AAKT's MCP API accepts JSON-RPC payloads with free-text fields.
Cloudflare WAF inspects these payloads and may block requests
containing security-related terminology:

- SSH commands, firewall rule syntax, port references
- SQL-like syntax in knowledge text
- Shell commands, exploit-adjacent terminology
- Encoded payloads or unusual character sequences

This is actually Cloudflare doing its job — the text looks like attack
payloads because it IS infrastructure/security content.

### The Incident (2026-02-21)
Stored 5 infrastructure knowledge items. 4 succeeded. 1 was blocked
by Cloudflare WAF because SSH configuration terminology triggered
security rules. The blocked item contained `sshd_config` directives
and connection patterns.

### Resolution: Don't Store Infra Details
The cleanest fix isn't a WAF exclusion — it's not storing the content
that triggers WAF in the first place. Infrastructure details belong in
local documents, not cloud-hosted knowledge stores.

### If WAF Exclusions Are Needed
For legitimate non-infra content that triggers WAF false positives:

1. **Check Firewall Events** in Cloudflare dashboard to find specific rule IDs
2. **Disable only those rules** for the `/mcp` path (surgical, keeps 95% protection)
3. **Never blanket-disable WAF** for the MCP endpoint — you lose:
   - Protection against novel exploits in the API framework
   - Request smuggling and header injection protection
   - DDoS mitigation bundled with WAF rules
   - Defense-in-depth layer

Priority order:
1. Don't store triggering content (best)
2. Sanitize text to avoid trigger patterns (good)
3. Disable specific WAF rule IDs for `/mcp` only (acceptable)
4. Blanket WAF exclusion for `/mcp` (dangerous — avoid)

## Profile-Specific Guidance

### it-ops Profile
This profile is most affected by the cloud-vs-local split.

**AAKT stores:**
- Change management decisions ("migrated from iptables to nftables because...")
- Operational patterns ("persistent sessions prevent connection drops during...")
- Incident summaries ("DNS resolution failed because upstream changed...")
- Cross-project infrastructure dependencies ("project X depends on service Y")

**Local docs store:**
- Actual runbooks with connection details
- INFRASTRUCTURE.md with topology
- Credential vault references
- Network diagrams and VLAN maps

### Cross-Project Profiles
Cross-project AAKT events should reference service names and API contracts,
never connection strings or internal endpoints.

**AAKT:** "project-auth added MFA field to user model, affects admin dashboard"
**Local:** "project-auth runs on port 3001 behind Cloudflare tunnel abc123"

## Agent Instructions

When working in any profile, agents MUST:

1. **Before storing to AAKT:** Apply the sanitization test
2. **Infrastructure content:** Always store locally, reference in AAKT
3. **WAF-blocked stores:** Do NOT retry with a WAF exclusion. Sanitize the text
   and retry, or store locally and add a sanitized AAKT reference
4. **Cross-project infra:** Use service names and patterns, never connection details
5. **Handoff documents:** Sanitize before AAKT push. Full details in local handoff file.
