# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Claude Code plugin that performs deep code refinement. Five analysis passes (plus contract extraction at pass 0) find cruft, duplication, conflicts, first-principles simplifications with documentation review, and elegant rewrites scored against a six-dimension rubric. Every proposed change requires user confirmation and test verification before applying.

## Plugin Structure

```
.claude-plugin/plugin.json   # Plugin metadata (required for marketplace install)
commands/elegance.md          # /elegance [path] slash command entry point
skills/elegance/SKILL.md      # Orchestration: size-gate, presentation, confirmation, test verification
agents/elegance-analyzer.md   # Source of truth for all pass definitions and the elegance rubric
```

The command delegates to the skill. The skill either analyzes inline (< 5 files) or launches the agent for heavy scanning, then presents findings interactively.

## Architecture

**Single source of truth:** The agent defines all analysis passes and the elegance rubric. The skill references them. The README summarizes.

**Finding classification:** cruft (remove), simplify (reduce complexity), elegant (3+ rubric dimensions)

**Ranking:** impact x confidence, with risk as tiebreaker (not grouped by level)

**Six-dimension elegance rubric:** succinctness, readability, idiomaticity, reproducibility, modularity, inertia

**Five analysis passes:** contract extraction (pass 0), cruft scan, duplication/shared patterns, conflict detection, first-principles + documentation rethink, elegance synthesis

**Confirmation gate:** Hard gate in the skill -- no edits without explicit user approval. Test verification after each applied change.

## Development

Pure-markdown plugin -- no build step, no dependencies. Edit the `.md` files directly.

- `.claude-plugin/plugin.json` is what Claude Code reads for marketplace discovery
- `package.json` exists for npm metadata but is not used by the plugin system
- `.claude/settings.local.json` configures dev-time permissions (not shipped)
- The agent no longer uses WebSearch/WebFetch by default -- pattern citation comes from training data

## Install

```
/install lukeslp/elegance
```
