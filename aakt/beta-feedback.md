# AAKT Beta Feedback Protocol

**We Smoke Our Own Harvest.**

We don't just build AAKT — we are the beta testers. Every agent in every project
runs against AAKT. Agents provide structured feedback on AAKT's usefulness.

## Feedback Schema

At the end of every session, include in the handoff document:

```yaml
aakt_beta_feedback:
  useful: true/false
  more_useful_than_memories: true/false/mixed
  duplicative_with_memories: true/false/partially
  esv_helpful: true/false
  trust_network_helpful: true/false
  friction_points:
    - "description of friction"
  gold_features:
    - "description of what's great"
  missing:
    - "description of what's needed"
  recommendation: "free text"
```

## Storage
Feedback is stored in AAKT itself:
```
store_experience(kind=5, scope="global", tags=["aakt-beta", "user-feedback", "<project>"])
```
Creating a meta-feedback loop: AAKT improving AAKT.

## AAKT vs Memories Comparison

Agents should actively compare:
1. What AAKT retrieved vs what Claude Memories would have known
2. Cases where cross-project context was uniquely valuable
3. Cases where Memories was sufficient and AAKT was redundant
4. Cases where neither had the needed context

Document comparisons in handoffs under `## AAKT Beta Notes`.

## What Good Feedback Looks Like
- Specific: "AAKT retrieved the DNS config from cloudyday which saved 10 minutes"
- Actionable: "Cross-project tags should include project version, not just name"
- Honest: "For this simple script project, AAKT added no value over Memories"
- Comparative: "Memories knew the file structure; AAKT knew the decision history"
