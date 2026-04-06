# elegance

Code refinement plugin for Claude Code. Looks past surface-level cleanup to find the version of your code that feels inevitable.

## Install

```
/install lukeslp/elegance
```

## Usage

```
/elegance              # look at recent git changes
/elegance src/         # focus on a directory
/elegance app.tsx      # focus on a single file
```

## How it works

Five passes over your code, each looking for something different:

0. **Contract extraction** -- reads tests, types, and call sites to establish what the code is supposed to do before changing anything
1. **Cruft** -- dead code, unused imports, orphan files, stale TODOs
2. **Duplication and shared patterns** -- copy-pasted logic, repeated CSS/JS patterns, near-identical components, cross-file pattern opportunities
3. **Conflicts** -- CSS specificity fights, competing event handlers, z-index chaos, duplicate state
4. **First principles + documentation** -- complex logic boiled down to "what is this actually trying to do?", plus stale comments, missing intent, names that could be clearer
5. **Elegance synthesis** -- for significant findings, search for the version that makes you think "of course" -- citing the specific pattern, language feature, or design principle

Every finding gets a level (cruft, simplify, elegant) and is scored on impact, confidence, and risk. Findings surface in order of value, not category -- a safe high-impact simplification appears before a risky elegant rewrite.

Nothing changes without your say-so. Each finding shows what's there now, what it could look like, why, and whether the rewrite preserves existing behavior. You confirm before anything is touched. If the project has tests, they run after each applied change.

## The elegance rubric

A change earns "elegant" when it scores on three or more of: **succinctness** (nothing superfluous), **readability** (understood without comments), **idiomaticity** (uses the tools as designed), **reproducibility** (multiple senior devs would converge on this), **modularity** (testable, movable, reusable), **inertia** (resists bugs by structure).

## What's in the box

| What | Type | Does |
|------|------|------|
| `/elegance` | Command | Run it with an optional path |
| `elegance` | Skill | Orchestrates the review loop, presents findings, confirms changes |
| `elegance-analyzer` | Agent | Runs the five-pass analysis on larger targets |

For small targets (< 5 files), the skill handles analysis inline. The agent launches only for larger scans.

## Examples

A 47-line validation function that's really `zod.object({...}).parse()`. Three card components that differ by an icon and a color. CSS that sets `font-weight: 600` in nine different places instead of using a variable. A nested ternary that reads better as an object lookup. A function with a comment explaining what it does that could just have a better name.

## License

MIT
