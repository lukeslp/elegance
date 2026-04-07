# elegance

Code refinement and multi-agent adversarial debate for Claude Code. One command, two modes: pass a file path for deep code analysis, or ask a question to convene a council of 14 specialized agents that argue toward better solutions.

## Install

```
<<<<<<< HEAD
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
=======
/plugin install elegance@lukeslp-elegance
```

Or browse for it: `/plugin` → Discover → search "elegance"

## Usage

```
/elegance              # scan recent git changes
/elegance src/         # scan a directory
/elegance app.tsx      # scan a single file
/elegance --quick      # cruft only, fast
/elegance --full       # full project scan
/elegance --setup      # change preferences
```

### Session workflow

Start a session at the beginning of a work block. Checkpoint as you go. Conclude when you're done.

```
/elegance --begin       # record baseline, initial full scan
# ... do your work ...
/elegance --checkpoint  # scan what changed since --begin
# ... keep working ...
/elegance --conclude    # final pass, session summary
```

## How it works

Three agents run the analysis in parallel, then a synthesis agent looks across all findings for elegant rewrites.

**Pass 0 + 1** — Extract contracts from tests, types, and call sites. Then scan for cruft: dead code, unused imports, orphan files, stale TODOs.

**Pass 2** — Find duplication: copy-pasted logic, repeated CSS values, near-identical components. Won't propose a shared abstraction unless the pattern appears 3+ times and has a natural name.

**Pass 3 + 4** — Detect conflicts (CSS specificity fights, competing handlers, duplicate state) and rethink complex logic from first principles. Also catches stale comments and misleading names.

**Pass 5** — Synthesis. Takes findings from all other passes and looks for the version that feels inevitable. Cites the specific language feature, pattern, or design principle. Verifies against the contract from Pass 0.

Findings are ranked by impact and confidence, not grouped by category. A safe high-value simplification surfaces before a risky elegant rewrite.

## First run

Asks three questions: how to confirm changes, whether to get second opinions from other CLI tools (gemini, codex, aider), and default scan scope. Saves your answers so it only asks once. Run `--setup` to change later.

## The elegance rubric

A rewrite earns "elegant" when it scores on three or more of: **succinctness** (nothing superfluous), **readability** (understood without comments), **idiomaticity** (uses the tools as designed), **reproducibility** (multiple devs would converge on this), **modularity** (testable and movable), **inertia** (resists bugs by structure).

## What's in the box

| Component | Type | Role |
|-----------|------|------|
| `/elegance` | Command | Entry point, flag parsing |
| `elegance` | Skill | Orchestration: banners, preferences, parallel dispatch, confirmation, test verification |
| `elegance-contract-cruft` | Agent | Pass 0 + 1: contracts and cruft |
| `elegance-duplication` | Agent | Pass 2: duplication and shared patterns |
| `elegance-conflicts-rethink` | Agent | Pass 3 + 4: conflicts and first-principles |
| `elegance-analyzer` | Agent | Pass 5: synthesis and the elegance rubric |

| `elegance-ui.sh` | Script | CLI banners, pass headers, scoreboard, session output |

For small targets (< 5 files), the skill runs analysis inline without launching agents.
>>>>>>> origin/main

## License

MIT
