# elegance

Code refinement and multi-agent adversarial debate for Claude Code. One command, two modes: pass a file path for deep code analysis, or ask a question to convene a council of 14 specialized agents that argue toward better solutions.

## Install

```
/install lukeslp/elegance
```

## Usage

```bash
# Code refinement (v1 behavior)
/elegance              # analyze recent git changes
/elegance src/         # focus on a directory
/elegance app.tsx      # focus on a single file

# Council debate (v2)
/elegance "Should we rewrite this auth module?"
/elegance "What's the best approach for real-time updates?"
/elegance "Is this data model going to scale?"
```

## Code Refinement

Five passes over your code, each looking for something different:

0. **Contract extraction** -- reads tests, types, and call sites to know what the code does before changing it
1. **Cruft** -- dead code, unused imports, orphan files, stale TODOs
2. **Duplication** -- copy-pasted logic, repeated patterns, near-identical components
3. **Conflicts** -- CSS specificity fights, competing handlers, duplicate state
4. **First principles** -- complex logic boiled down to "what is this actually trying to do?"
5. **Elegance synthesis** -- the version that makes you think "of course"

Nothing changes without your say-so. Each finding shows before/after, explains why, and waits for confirmation. Tests run after each applied change.

## Council Debate

When you ask a question, 14 agents with opposing optimization targets analyze it from different perspectives:

### Core Agents (always invited)

| Agent | Lens |
|-------|------|
| **Governance** | Orchestrates the debate, synthesizes the verdict |
| **Reconnaissance** | Maps what exists in the codebase |
| **Brilliance** | Finds how the best solved this problem |
| **Vigilance** | Tries to break every proposal |
| **Defiance** | Challenges the emerging consensus |
| **Resilience** | Designs what happens when things break |
| **Provenance** | Checks licensing and attribution |
| **Elegance** | Proposes the refined rewrite |
| **Assurance** | Designs how to prove it works |
| **Coherence** | Assesses whether it fits the codebase |

### Post-Decision

| Agent | Role |
|-------|------|
| **Eloquence** | Humanizes the final output |

### Domain Guests (invited when relevant)

| Agent | Domain |
|-------|--------|
| **Conscience** | Accessibility -- WCAG 2.2, motor, cognitive, visual, AAC |
| **Radiance** | Data visualization -- D3.js, "Data is Beautiful" |
| **Cadence** | Embedded/firmware -- Arduino, ESP32, Pi |

### The Protocol

```
Phase 1: FRAMING     -- Governance reads the question, selects guests
Phase 2: FACT-FINDING -- Reconnaissance + Brilliance gather facts (parallel)
Phase 3: ANALYSIS     -- All agents analyze in parallel with facts
Phase 4: SYNTHESIS    -- Governance scores, preserves dissent, Eloquence humanizes
```

### Rules

1. Facts outrank precedent. Precedent outranks taste.
2. Every criticism must include a concrete failure mode.
3. Defiance must always dissent -- the strongest counterargument is always named.
4. Dissenting opinions are preserved. No false consensus.

## The Elegance Rubric

A change earns "elegant" when it scores on three or more of: **succinctness** (nothing superfluous), **readability** (understood without comments), **idiomaticity** (uses the tools as designed), **reproducibility** (multiple senior devs would converge), **modularity** (testable, movable, reusable), **inertia** (resists bugs by structure).

## Research Backing

The council protocol is informed by:
- [Catfish Agent](https://arxiv.org/html/2505.21503) -- structured dissent prevents premature consensus
- [Council Mode](https://arxiv.org/html/2604.02923) -- parallel expert generation + structured synthesis
- [17x Error Trap](https://towardsdatascience.com/why-your-multi-agent-system-is-failing-escaping-the-17x-error-trap-of-the-bag-of-agents/) -- structured phases prevent error amplification

## Author

Luke Steuber -- [lukesteuber.com](https://lukesteuber.com) -- [@lukesteuber.com](https://bsky.app/profile/lukesteuber.com)

## License

MIT
