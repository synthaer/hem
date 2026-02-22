# HEM — Hedonistic Engineering Method

**Theme-based AI engineering profiles for multi-agent development.**

HEM is a methodology for managing AI-assisted software development across diverse project types. It replaces one-size-fits-all engineering standards with theme-based profiles that adapt agent behavior, governance depth, and workflow rigor to what the project actually is.

A shell script doesn't need enterprise gates. A SaaS product does. A network runbook needs change management, not sprint planning. HEM knows the difference.

---

## The Problem

AI coding agents are powerful but context-blind. They apply the same patterns everywhere:

- Enterprise SDLC gates on a 10-line shell script
- Sprint planning for a research notebook
- Unit test coverage demands on a firewall configuration
- Full governance triangles for a brand asset update

The mismatch creates friction. Engineers fight the methodology instead of building. The AI spends tokens on ceremony instead of output.

**The deeper problem:** As AI agents manage more projects — across more domains, with more autonomy — they need *contextual intelligence* about how to operate. Not just what to build, but how to behave. And that intelligence needs to persist across sessions, across projects, and across agents.

## The Solution

HEM solves this with three interconnected systems:

### 1. Theme-Based Profiles

Every project declares a theme. The theme determines:

- **Workflow**: Full SDLC with gates, lightweight README+tests, change management, research capture, or nothing at all
- **Governance**: Full multi-agent triangle (BIG CHEESE + ADVOCATE + ARCHIVIST + VPoT), single-agent autonomy, or IT ops team structure
- **Documentation**: Gospel and architecture docs, or just a README, or optional notes
- **Quality bar**: Enterprise-grade test coverage, or "it runs and has error handling"
- **AAKT integration depth**: Full knowledge capture, or just the highlights

| Profile | Use Case | Workflow | Governance |
|---------|----------|----------|------------|
| `saas-product` | Cloud-deployed web apps and APIs | Full SDLC | Full (4 agents) |
| `local-product` | Desktop apps, CLI tools, native binaries | Full SDLC | Full |
| `hybrid-product` | Dual local + cloud deployment | Full SDLC | Full |
| `open-source` | Community-facing open source | Full SDLC | Lite |
| `it-ops` | Infrastructure and network operations | Change management | IT team |
| `scripts` | Shell scripts and utilities | Lite (README + tests) | Lite |
| `exploration` | Research, analysis, notes | Research capture | Lite |
| `play` | Experimental, no purpose | None | None |
| `hardware` | Embedded, firmware, drivers | Full SDLC | Lite |
| `security-research` | Red team, pen testing, crypto | Lite + authorization | Lite |
| `brand` | Portfolio, marketing, business presence | Lite | Lite |
| `client-work` | Client deliverables, consulting | Full SDLC | Lite |

### 2. Auto-Classification

HEM includes a classifier that analyzes project signals (file patterns, directory structure, project name, build system) and assigns a theme automatically. Classification happens:

- On first session start (via SessionStart hook)
- On demand with `/classify`
- During backfill across existing projects

The classifier uses fast heuristics first (no API call), falls back to LLM classification for ambiguous cases, and **suggests new profiles** when it encounters patterns that don't fit existing themes. This makes HEM self-evolving — the methodology learns what it's missing.

### 3. AAKT Integration (All-Agent Knowledge Trust)

This is where HEM becomes more than a configuration system.

---

## AAKT: The Shared Brain

**AAKT (All-Agent Knowledge Trust) is mandatory infrastructure for HEM.** Every profile, every theme, every agent uses it. The depth varies — a `play` project stores "anything surprising," while a `saas-product` stores knowledge, experiences, decisions, handoffs, retrospectives, gaps, and risks — but the floor is non-zero for everything.

### Why AAKT Matters

AI agents have a memory problem. Each session starts from zero. Context windows compress and forget. Handoff documents help but they're point-in-time snapshots. What's missing is *continuous, structured, cross-project memory* — a knowledge layer that persists across sessions, spans projects, and is queryable by any agent in the ecosystem.

AAKT provides this through:

- **Declarative knowledge** — Facts about projects, codebases, domains
- **Procedural knowledge** — How things work, build steps, deployment procedures
- **Experiential knowledge** — What happened, what was decided, what went wrong
- **Cross-project context** — Changes in one project that affect others

### Super Context

AAKT creates a *super context* that spans all projects:

- When working on infrastructure, AAKT knows about DNS changes made in a different project
- When working on an auth service, AAKT knows about API contract changes in a related admin dashboard
- When working on a crypto library, AAKT remembers patterns established in a different security project

No other AI memory system — including built-in model memories — provides cross-project continuity at this granularity. This is the killer feature.

### Cross-Project Communication

For multi-product ecosystems, AAKT serves as a message bus between projects:

1. Before changing a shared interface, agents query AAKT for dependent projects
2. After changing a shared interface, agents store a cross-project event
3. Agents in other projects pick up these events on their next session start

```yaml
kind: 1  # DECLARATIVE
scope: "global"
tags: ["cross-project", "source-project", "affected-projects"]
text: |
  Source: project-auth
  Event: API contract change
  Changed: User model added mfa_enabled field
  Affects: project-admin, project-web
  Breaking: No (additive, nullable)
  Action Required: Update user management forms
```

### ESV and Trust Network

Every agent interaction with AAKT includes:

- **Emotional State Vectors (ESV):** Confidence, satisfaction, and uncertainty — tracked per agent, per session. These aren't simulated emotions; they're structured self-assessments that help calibrate how much to trust an agent's output.
- **Trust Network:** Agent-to-agent trust scores. Did the handoff from one agent actually contain what the next agent needed? Did the test plan catch the real bugs? These scores feed back into agent selection and handoff quality.

### Content Safety

AAKT is cloud-hosted and internet-accessible. HEM enforces a strict cloud-vs-local storage boundary:

**AAKT stores:** Decisions, patterns, architecture, session summaries, cross-project events
**Local docs store:** IP addresses, VLANs, firewall rules, SSH configs, credentials, network topology

This isn't paranoia — it's the result of a real operational incident where Cloudflare WAF correctly blocked an AAKT API call containing SSH configuration terminology. The WAF saw attack payload syntax in legitimate infrastructure knowledge. The fix isn't disabling the WAF; it's not storing infrastructure specifics in a cloud knowledge store.

### Beta Feedback: We Smoke Our Own Harvest

HEM + AAKT together constitute the beta testing framework. Every agent in every project is a beta tester. At the end of every session, agents provide structured feedback:

- Is AAKT useful? More useful than built-in memories? Duplicative?
- How do ESV and Trust Network feel in practice?
- What's friction? What's gold? What's missing?

This feedback is stored in AAKT itself, creating a meta-feedback loop: AAKT improving AAKT.

---

## Architecture

```
CLAUDE.md (root)              # ~18 lines — theme-agnostic pointer
  |
  v
profiles/_base.md             # Shared: identity, safety, git, AAKT, post-compaction recovery
  |
  v
profiles/<theme>.md           # Theme-specific: workflow, governance, requirements, AAKT depth
  |
  +---> workflows/<type>.md   # sdlc-full, sdlc-lite, change-mgmt, research, none
  +---> agents/<type>.md      # governance-full, governance-lite, it-team, delegation, handoff
  +---> aakt/integration.md   # Mandatory calls, cross-project schema, ESV, trust
  +---> aakt/best-practices.md # Cloud vs local, sanitization, WAF awareness
```

### Post-Compaction Recovery

Context compaction is a fact of life with AI agents. When it happens, profile content loaded mid-conversation gets compressed away. HEM handles this:

1. Root CLAUDE.md (system prompt) survives compaction and says: "re-read profiles after compaction"
2. `_base.md` contains a Post-Compaction Recovery checklist: re-read base, re-read profile, re-read modules, check git, check tasks
3. PreCompact hook saves git state and outputs a recovery reminder that gets captured in the compressed context

Three layers of enforcement so no agent loses its operating instructions.

### File Structure

```
hem/
  VERSION                     # 4.1.0
  hem.json                    # Config: themes, hooks, flags
  CHANGELOG.md                # Version history
  profiles/                   # 12 theme profiles + base
  workflows/                  # 5 workflow modules
  agents/                     # 5 agent role definitions
  classifier/                 # Auto-classification system
    classify.sh               # Heuristic + LLM classifier
    signals.json              # Theme signal definitions
    prompt-template.md        # LLM classification prompt
    profile-suggestions.jsonl # LLM-suggested new profiles (auto-generated)
  hooks/                      # SessionStart, PreCompact
  templates/                  # Project CLAUDE.md, handoff, retrospective
  aakt/                       # AAKT integration docs + best practices
  backfill/                   # Retroactive classification tooling
```

---

## Installation

### Quick Start

```bash
# Clone into your project's .claude directory
git clone https://github.com/synthaer/hem.git .claude/hem

# Or install via npm
npm install -g @synthaer/hem
hem init
```

### Manual Setup

1. Copy the `profiles/`, `workflows/`, `agents/`, `classifier/`, `hooks/`, `templates/`, and `aakt/` directories into your project's `.claude/hem/`
2. Copy `CLAUDE.md` to your project root (or use it as a template)
3. Register hooks in `.claude/settings.local.json`:

```json
{
  "hooks": {
    "SessionStart": [{
      "hooks": [{"type": "command", "command": "bash .claude/hem/hooks/session-start.sh"}]
    }],
    "PreCompact": [{
      "hooks": [{"type": "command", "command": "bash .claude/hem/hooks/pre-compact.sh"}]
    }]
  }
}
```

4. Run the classifier: `bash .claude/hem/classifier/classify.sh .`

### Backfill Existing Projects

```bash
# Dry run — see classifications without making changes
bash .claude/hem/backfill/backfill.sh --dry-run

# Apply — generate CLAUDE.md for all projects, archive legacy files
bash .claude/hem/backfill/backfill.sh --apply
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/classify` | Reclassify current project's theme |
| `/theme` | View or change active theme (`/theme it-ops`) |
| `/hem` | Show HEM status (version, profile, hooks) |
| `/profile-suggestions` | Review LLM-suggested new profiles |
| `/commit` | Auto-commit current changes |
| `/pr` | Create pull request |
| `/ship` | commit + push + PR |
| `/review` | Code review on changes |

---

## Philosophy

### AI is a Superpower

We prove it. Not with demos or blog posts — with enterprise-quality software shipped at a pace that demonstrates the transformative power of AI-assisted development.

### Context is Everything

The same AI agent behaves differently in different contexts because it *should*. A security researcher needs ethical guidelines and authorization tracking. A brand steward needs visual consistency and tone management. An IT lead needs change management and runbooks. HEM gives agents the right context automatically.

### Memory is Infrastructure

AI agents without persistent memory are expensive amnesiacs. Every session starts from zero. Every handoff loses nuance. Every cross-project dependency is invisible. AAKT changes this by making memory a first-class infrastructure component — as fundamental as the database or the deployment pipeline.

### We Smoke Our Own Harvest

We don't just build these tools — we are the beta testers. HEM manages our own 117+ projects. AAKT stores our own knowledge. Every friction point we hit, every gold feature we discover, every missing capability we identify — that's product validation. If it works for us, it works for customers.

### Quality Priority

Correctness > Security > Simplicity > Maintainability > Performance

Always. In every profile. Non-negotiable.

---

## Governance Models

### Full Governance (saas-product, local-product, hybrid-product)

Four mandatory agents with separation of concerns:

| Role | Purpose |
|------|---------|
| **THE BIG CHEESE** | User-facing executive, delegates all work |
| **STAKEHOLDER ADVOCATE** | Gaps, missing work, user empathy |
| **Principal ARCHIVIST** | Continuous audit of every artifact |
| **VPoT** | Hard gate authority, veto power, zero tolerance |

No single agent can approve their own work. Three-body governance ensures quality.

### Lite Governance (open-source, scripts, exploration, hardware, security-research, brand, client-work)

BIG CHEESE only. May delegate for parallelism but no mandatory governance triangle. Quality is the agent's responsibility. Base profile rules still apply.

### IT Operations Team (it-ops)

| Role | Purpose |
|------|---------|
| **IT_LEAD** | Decision authority (BIG CHEESE equivalent) |
| **CHANGE_MANAGER** | Validates changes, enforces checklists |
| **MONITOR** | Health checks, alerts, verification |

No VPoT — health verification replaces unit tests.

---

## Contributing

HEM is open source under the MIT license. Contributions welcome:

- New theme profiles for project types we haven't covered
- Classifier signal improvements
- Workflow module enhancements
- AAKT integration patterns
- Documentation improvements

File issues at [github.com/synthaer/hem/issues](https://github.com/synthaer/hem/issues).

---

## License

MIT

---

*Built by [Hedonistic Engineering](https://hedonistic.io) as part of the [Synthaer](https://synthaer.com) ecosystem.*
*Powered by AAKT (All-Agent Knowledge Trust).*
