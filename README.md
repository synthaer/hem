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

## Synthaer AAKT: The All-Agent Knowledge Trust

**AAKT is the shared brain for AI fleets.** It is a persistent, structured, cross-project knowledge store that transforms isolated AI agents into a collaborative intelligence network. Every agent in every HEM profile uses AAKT. The depth varies by theme, but the floor is non-zero — even a `play` project captures surprises worth remembering.

AAKT is not a database. It is not a chat history. It is a *trust-weighted, provenance-verified, emotionally-aware knowledge graph* that makes every AI agent in your fleet smarter because every other agent has worked before it.

### The Problem AAKT Solves

AI agents today are expensive amnesiacs. Consider the operational reality:

1. **Session amnesia.** Every AI session starts from zero. The agent that spent 45 minutes understanding your authentication architecture yesterday knows nothing today. Context windows compress and forget. Handoff documents help, but they're point-in-time snapshots that lose nuance.

2. **Silo intelligence.** Agent A working on your API has no idea that Agent B, working on your frontend last week, discovered that the date format convention changed. Each agent operates in isolation, rediscovering what others already learned.

3. **Unchecked hallucination.** When an agent states a "fact" about your codebase, there is no mechanism to verify it against prior knowledge. No institutional memory means no institutional correction. Hallucinations propagate unchallenged through handoffs and documentation.

4. **Invisible fleet operations.** Human operators have no visibility into what their AI agents actually know, what decisions they're making, or how confident they are. Managing an AI fleet without a knowledge layer is like managing a team where no one writes anything down and no one talks to each other.

AAKT solves all four problems simultaneously.

### How AAKT Works

AAKT stores four types of knowledge, each with full provenance tracking:

| Kind | Type | What It Captures |
|------|------|-----------------|
| 1 | **Declarative** | Facts — project architecture, API contracts, domain rules, infrastructure state |
| 2 | **Procedural** | How-to — build steps, deployment procedures, debugging workflows, operational runbooks |
| 3 | **Episodic** | What happened — session summaries, incident reports, decision logs, change histories |
| 4 | **Experiential** | Lessons learned — errors encountered, patterns discovered, gotchas, optimization insights |

Every knowledge entry carries metadata:
- **Source agent** — Which agent stored this knowledge
- **Timestamp** — When it was created
- **Scope** — Project-specific or global (cross-project)
- **Confidence** — How certain the storing agent was (via ESV)
- **Trust score** — How reliable the source agent has been historically (via Trust Network)
- **Tags** — Semantic labels for retrieval

### Contextual Awareness: Making Agents Smarter

AAKT makes every agent contextually aware at session start:

```
Session begins →
  Agent queries AAKT: "What do I know about this project?" →
    AAKT returns: prior decisions, unresolved issues, cross-project events,
    patterns from related projects, warnings from previous agents →
      Agent operates with full institutional context
```

This transforms the agent experience from "starting from scratch every time" to "continuing where the team left off." The agent knows:

- What was decided and why (so it doesn't re-litigate settled questions)
- What went wrong before (so it doesn't repeat known mistakes)
- What other projects depend on this one (so it doesn't break shared interfaces)
- What patterns work well here (so it follows established conventions)

The result is measurably better output: fewer hallucinations, fewer redundant questions, faster ramp-up, and decisions consistent with prior work.

### AI Team Accuracy: The Compounding Knowledge Effect

The more agents use AAKT, the more accurate every agent becomes. This is a compounding effect:

1. **Session 1:** Agent stores 5 knowledge entries (decisions, patterns, gotchas)
2. **Session 2:** Next agent retrieves those 5 entries, avoids 2 known pitfalls, stores 3 new entries
3. **Session 10:** Agent retrieves 30+ entries spanning multiple sessions and agents. It has a richer understanding of the project than any single human session could produce.
4. **Session 100:** The knowledge base represents hundreds of hours of AI work. Every new agent starts with near-complete institutional knowledge.

Traditional AI memory (built-in model memories, chat history) is linear — it captures what *one* agent did. AAKT is exponential — it captures what *every* agent across *every* project learned, weighted by trust and verified by provenance.

### Hallucination Challenge and Refutation

AAKT provides a structured mechanism to detect, challenge, and correct hallucinations:

**Detection:** When an agent makes a claim about the codebase ("the API uses JWT authentication"), AAKT can cross-reference against stored declarative knowledge. If prior knowledge contradicts the claim, the system flags the conflict.

**Challenge:** Conflicting knowledge entries trigger a challenge protocol:
1. Both entries are surfaced with their provenance (which agent, when, what confidence level)
2. Trust scores weight the challenge — a high-trust agent's prior knowledge outweighs a new agent's assertion
3. The conflict is logged as an experience entry for future reference

**Refutation:** When a hallucination is confirmed:
1. The incorrect entry is marked as refuted (not deleted — the refutation itself is knowledge)
2. The correct information is stored with elevated confidence
3. The originating agent's trust score is adjusted downward
4. Future agents retrieving knowledge from this domain see the correction

**Prevention:** Over time, AAKT builds a "known facts" layer for each project that agents can verify against. This functions as institutional memory that actively resists hallucination — the system *remembers* what's true and pushes back when an agent invents something different.

### Fleet-Wide AI Collaboration

AAKT enables something unprecedented: AI agents that genuinely collaborate across sessions, projects, and even AI platforms.

#### Cross-Project Knowledge Sharing

Changes in one project automatically propagate awareness to related projects:

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
  Urgency: next-session
```

When an agent starts a session on `project-admin`, AAKT surfaces this event: "Heads up — `project-auth` added a field you need to handle." The agent doesn't discover the breaking change by accident during testing. It knows before it writes a single line of code.

#### Multi-Engine Collaboration

AAKT is engine-agnostic. Claude agents, Codex agents, and Gemini agents all read from and write to the same knowledge store. A Codex agent running tests can store a discovered bug pattern that a Claude agent picks up when writing the fix. A Gemini agent doing architecture review can store a structural concern that the Codex dev agent reads before implementation.

This is true multi-agent collaboration — not just parallel execution, but shared learning.

#### Pattern Propagation

When an agent discovers an effective pattern in one project (a testing strategy, a deployment approach, an error handling technique), AAKT makes it available to agents working on similar projects:

- Crypto patterns discovered in a security key project are available to agents working on encryption libraries
- Deployment strategies proven in one infrastructure project are suggested in others
- Performance optimizations found in one API apply to architecturally similar services

The fleet gets smarter as a collective, not just as individuals.

### Human Operator Insights

AAKT gives human operators unprecedented visibility into their AI fleet:

#### What Your Agents Know
Query AAKT to see the complete knowledge base for any project — every decision made, every pattern discovered, every issue encountered. This is the institutional memory that normally exists only in engineers' heads.

#### How Confident Your Agents Are
ESV (Emotional State Vectors) track agent confidence, satisfaction, and uncertainty per session. When an agent reports low confidence on a critical decision, you know to review it. When confidence is consistently high across sessions, you know the project is on solid ground.

#### Who Trusts Whom
The Trust Network reveals the quality of agent-to-agent collaboration. Did the testing agent catch the bugs the dev agent missed? Did the handoff contain what the next agent actually needed? Trust scores surface collaboration quality issues before they become product quality issues.

#### Where Hallucinations Happen
Challenge and refutation logs show you exactly where agents are producing unreliable output — which domains, which project types, which agent roles. This data drives targeted improvements: better prompts, additional context, or human review gates for high-risk areas.

#### Fleet Health Dashboard
Aggregated AAKT data provides a fleet-level view:
- Knowledge growth rate per project (is the team learning?)
- Cross-project event frequency (how connected is the ecosystem?)
- Trust score distribution (is collaboration quality improving?)
- Hallucination rate trends (is accuracy improving over time?)

### Emotional State Vectors (ESV)

ESV is not simulated emotion. It is a structured self-assessment framework that gives agents a vocabulary for communicating uncertainty and confidence.

Every agent interaction with AAKT includes an ESV snapshot:
- **Confidence** — How certain is the agent about its output? (0.0 to 1.0)
- **Satisfaction** — How well does the agent believe it met the objective? (0.0 to 1.0)
- **Uncertainty areas** — Specific domains where the agent lacks confidence

ESV serves three purposes:
1. **Calibration** — Human operators see when agents are unsure, enabling targeted review
2. **Weighting** — AAKT weights knowledge entries by the storing agent's confidence. A finding stored with 0.9 confidence ranks higher in retrieval than one stored at 0.4
3. **Trend analysis** — ESV trends across sessions reveal whether agents are becoming more or less confident in a domain, signaling maturity or emerging complexity

### Trust Network

The Trust Network is an agent-to-agent reputation system built from observed collaboration outcomes.

**How trust is built:**
- Agent A hands off to Agent B. Agent B rates the handoff quality. That rating updates A's trust score.
- Agent A stores knowledge. Agent B retrieves and uses it. If the knowledge was accurate and useful, A's trust score increases. If it was wrong, A's trust score decreases.
- VPoT (testing agent) finds zero bugs in code from Dev IC. Dev IC's trust score increases. VPoT finds critical bugs? Trust score decreases.

**How trust is used:**
- **Agent selection** — For critical work, prefer agents with higher trust scores in the relevant domain
- **Knowledge weighting** — Retrieve knowledge from high-trust agents first; weight their entries higher in case of conflicts
- **Handoff quality** — Flag low-trust handoffs for human review before the next agent relies on them
- **Hallucination detection** — When a low-trust agent contradicts a high-trust agent's prior knowledge, the conflict is weighted toward the high-trust source

**Trust properties:**
- Domain-specific (an agent can be high-trust for testing and low-trust for documentation)
- Decays over time (past performance must be continuously reconfirmed)
- Recoverable (an agent whose trust dropped can rebuild it through consistent quality)
- Transparent (trust scores are queryable — agents and operators can see the graph)

### DKIM-Style Knowledge Verification

AAKT applies a concept borrowed from email security: every knowledge entry is signed at the point of creation, establishing an unbreakable chain of provenance.

Just as DKIM (DomainKeys Identified Mail) allows email recipients to verify that a message genuinely came from the claimed sender and wasn't tampered with in transit, AAKT's knowledge verification ensures:

- **Authenticity** — This knowledge entry was genuinely created by the agent that claims to have created it
- **Integrity** — The knowledge has not been modified since it was stored
- **Non-repudiation** — The storing agent cannot deny having stored it
- **Chain of custody** — The full history of a knowledge entry's lifecycle (created, retrieved, challenged, refuted, confirmed) is immutably tracked

This matters because knowledge without provenance is just another potential hallucination. When Agent B retrieves knowledge stored by Agent A, it can verify: Agent A actually stored this, at this time, with this confidence level, and it hasn't been tampered with. Combined with Trust Network scores, this creates a reliability assessment for every piece of knowledge in the system.

### Content Safety

AAKT is cloud-hosted and internet-accessible. HEM enforces a strict cloud-vs-local storage boundary:

**AAKT stores:** Decisions, patterns, architecture, session summaries, cross-project events
**Local docs store:** IP addresses, VLANs, firewall rules, SSH configs, credentials, network topology

This isn't paranoia — it's the result of a real operational incident where Cloudflare WAF correctly blocked an AAKT API call containing SSH configuration terminology. The WAF saw attack payload syntax in legitimate infrastructure knowledge. The fix isn't disabling the WAF; it's not storing infrastructure specifics in a cloud knowledge store.

### The Exponential Advantage

The value of AAKT compounds along three axes simultaneously:

**Time:** Each session adds knowledge. After 100 sessions, an agent starting work on a project has access to the equivalent of hundreds of hours of prior engineering context — instantly, at session start, before writing a single line of code.

**Breadth:** Each project adds cross-project context. An agent working on one service knows about changes in every related service. In a 50-project ecosystem, that's 50x the contextual awareness of an isolated agent.

**Trust:** Each interaction refines trust scores. The system learns which agents produce reliable output in which domains. Knowledge retrieval becomes increasingly weighted toward proven sources. Hallucination rates decrease as the trust graph matures.

These three axes multiply: `time x breadth x trust = compound intelligence`. A fleet of AI agents backed by a mature AAKT instance is not linearly better than isolated agents — it is exponentially better, because every agent benefits from every other agent's accumulated, trust-weighted, provenance-verified experience.

This is the thesis: **AI agents are not a tool. They are a fleet. And fleets need shared intelligence to operate.**

AAKT is that intelligence.

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
