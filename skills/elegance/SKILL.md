---
name: elegance
description: "Code refinement that goes past cleanup to find the version that feels inevitable. Use when reviewing code quality, refactoring, cleaning up, or when someone asks to simplify, deduplicate, or improve code. Confirms before every change."
---

# Elegance

Find the version of the code that was always meant to be written.

<HARD-GATE>
NEVER make changes without presenting them first and getting explicit user confirmation. Show the before, show the after, explain WHY the new version is better. Every proposed change must be confirmed.
</HARD-GATE>

## Philosophy

When you read good code, you don't think "that's clever." You think "of course." Your job is to find that version.

Three levels:
- **Cruft** -- shouldn't be here (dead code, unused imports, orphan files)
- **Simplify** -- works, but working too hard (duplication, over-engineering, CSS fights)
- **Elegant** -- the rewrite that makes you pause (a 50-line function that's really a 3-line reduce, three components that want to be one)

## Elegance Rubric

A change earns "elegant" when it scores on three or more of these dimensions:

| Dimension | Test |
|-----------|------|
| **Succinctness** | Does removing any part break it? Nothing superfluous. |
| **Readability** | Can a new team member understand it without comments? |
| **Idiomaticity** | Does it use the language/framework the way it was designed? |
| **Reproducibility** | Given the same problem, would multiple senior devs converge on this? |
| **Modularity** | Can it be tested, moved, or reused without surgery? |
| **Inertia** | Does the structure resist bugs? (illegal states unrepresentable) |

## Process

The elegance-analyzer agent defines the analysis passes (contract extraction, cruft, duplication/shared patterns, conflicts, first-principles + documentation, elegance synthesis). This skill orchestrates the flow and presents findings interactively.

### Size Gate

- **Small target (< 5 files):** Run the analysis inline -- no need to launch the agent. Read the files, apply the same pass logic, present findings directly.
- **Large target (5+ files):** Launch the elegance-analyzer agent in the background for heavy scanning, then present its findings interactively.

### Determining Target

- If invoked on a specific file or directory, analyze that scope
- If invoked without a target, analyze recently changed files (git diff)
- For large codebases, focus on the most-touched files (git log --shortstat)
- Always respect .gitignore and skip node_modules, dist, build, vendor, etc.

## Presenting Findings

Findings arrive ranked by **impact x confidence** (not grouped by level). Present them in that order -- a safe, high-impact simplification surfaces before a risky elegant rewrite.

For each finding:

```
### [area/file] — [finding title]

**Level:** cruft | simplify | elegant
**Impact:** high | medium | low
**Confidence:** high | medium | low
**Risk:** low | medium | high

**What I found:**
[Brief description of the current state]

**Why it matters:**
[What's wrong or what opportunity exists]

**Proposed change:**
[Show the before/after or describe the transformation]

**Contract check:**
[How the rewrite preserves existing behavior, or what can't be verified]

**Apply this change? (y/n)**
```

## Confirmation Protocol

- Present one finding at a time (or a small related group)
- Wait for explicit confirmation before making ANY edit
- If the user says "apply all" or "yes to all", you may batch-apply remaining changes of the same level
- If the user disagrees with a finding, skip it -- don't argue
- After applying changes, show a brief summary of what was changed

## Test Verification

After applying any change:
- If the project has a test suite, run the relevant tests
- Report pass/fail status before moving to the next finding
- If tests fail, immediately revert the change and flag it as higher risk
- If no tests exist, note this in the contract check ("no automated verification available")
