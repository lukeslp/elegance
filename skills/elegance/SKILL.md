---
name: elegance
description: "Deep code refinement — finds cruft, duplication, conflicts, and shared component opportunities, then searches for the elegant 'aha' solution. Use when reviewing code quality, refactoring, cleaning up a codebase, or when the user asks to simplify, deduplicate, or improve code. Seeks confirmation before all changes."
---

# Elegance — Code Refinement

Find the beautiful solution hiding inside messy code. Not just cleanup — transformation.

<HARD-GATE>
NEVER make changes without presenting them first and getting explicit user confirmation. Show the before, show the after, explain WHY the new version is better. Every proposed change must be confirmed.
</HARD-GATE>

## Philosophy

Good code isn't just correct — it's inevitable. When you read elegant code, you think "of course, what else could it be?" Your job is to find that version of the code.

Three levels of finding:
- **Cruft** — things that shouldn't be there (dead code, unused imports, orphan files)
- **Simplify** — things that work but are harder than they need to be (duplication, over-engineering, CSS wars)
- **Elegant** — the rewrite that makes someone say "oh, that's beautiful" (a 50-line function that's really a 3-line reduce, a shared component that unifies three similar ones)

## Process

Run six passes over the target code. Use the elegance-analyzer agent for the heavy scanning, then present findings interactively.

### Pass 1: Cruft Scan
- Dead code (unreachable branches, commented-out blocks)
- Unused imports, variables, functions, files
- Orphan files (not imported or referenced anywhere)
- Stale dependencies
- TODO/FIXME/HACK comments that are actually done or obsolete

### Pass 2: Duplication Audit
- Copy-pasted logic (functions or blocks that do the same thing with minor variations)
- Near-identical components (React/Vue/Svelte components that differ by < 20%)
- Repeated CSS patterns (same color values, spacing, shadows declared multiple times)
- Repeated JS patterns (same fetch/error-handling/transform logic)
- Config or constants duplicated across files

### Pass 3: Conflict Detection
- CSS specificity wars (styles overriding each other unnecessarily)
- Competing JS event handlers on the same elements
- Duplicate or conflicting CSS class names
- Z-index battles
- Multiple sources of truth for the same state
- Competing animation/transition definitions
- Tailwind + custom CSS doing the same thing

### Pass 4: First-Principles Rethink
For any complex logic (> 15 lines doing one conceptual thing):
- What is this ACTUALLY trying to do? State it in one sentence.
- Is there a built-in language feature, standard library function, or well-known pattern that does exactly this?
- Can the control flow be simplified? (nested ifs → early returns, loops → map/filter/reduce, switch → object lookup)
- Are there unnecessary intermediate variables or transformations?
- Would inverting the logic make it clearer?

### Pass 5: Shared Component Opportunities
- 2+ components/functions with the same structure but different data
- UI elements that appear in multiple places with slight visual variations
- API call patterns that could be a shared hook or utility
- Error handling that could be centralized
- Layout patterns that repeat across pages/views

### Pass 6: Elegance Search
This is the exciting one. For each significant finding from passes 1-5:
- Search the web for highly-regarded solutions to the same problem (look for terms like "elegant", "clean", "beautiful", "clever", "simple" associated with the pattern)
- Check if the language/framework has an idiomatic way to express this
- Look for well-known design patterns that fit
- Consider: does a library/utility already solve this perfectly?
- The goal: find the solution that makes the reader think "of course"

## Presenting Findings

Group findings by file or area. For each finding:

```
### [area/file] — [finding title]

**Level:** cruft | simplify | elegant
**Confidence:** high | medium | low

**What I found:**
[Brief description of the current state]

**Why it matters:**
[What's wrong or what opportunity exists]

**Proposed change:**
[Show the before/after or describe the transformation]

**Apply this change? (y/n)**
```

Present findings in priority order:
1. **Elegant** findings first (the exciting ones)
2. **Simplify** findings next
3. **Cruft** last (least interesting but still valuable)

Within each level, sort by impact (most improvement first).

## Confirmation Protocol

- Present one finding at a time (or a small related group)
- Wait for explicit confirmation before making ANY edit
- If the user says "apply all" or "yes to all", you may batch-apply remaining changes of the same level
- If the user disagrees with a finding, skip it — don't argue
- After applying changes, show a brief summary of what was changed

## What Makes a Finding "Elegant"

An elegant finding isn't just shorter code. It's code where:
- The intent is immediately obvious
- There's no unnecessary ceremony
- It uses the language/framework the way it was designed to be used
- Someone reading it learns something
- It makes adjacent code simpler too (cascade effect)
- It feels inevitable — "what else could it be?"

## Scope

- If invoked on a specific file or directory, analyze that scope
- If invoked without a target, analyze recently changed files (git diff)
- For large codebases, focus on the most-touched files (git log --shortstat)
- Always respect .gitignore and skip node_modules, dist, build, vendor, etc.
