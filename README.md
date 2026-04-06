# elegance

Code refinement plugin for Claude Code. Six analysis passes that find dead code, duplication, conflicts, over-engineered logic, and the rewrite that makes you think "of course."

## Install

```
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

Four agents run the analysis in parallel, then a synthesis agent looks across all findings for elegant rewrites.

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

For small targets (< 5 files), the skill runs analysis inline without launching agents.

## License

MIT
