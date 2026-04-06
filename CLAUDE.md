# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Claude Code plugin for code refinement. Four agents run analysis passes in parallel (contract extraction, cruft, duplication, conflicts, first-principles rethink), then a synthesis agent looks for elegant rewrites scored against a six-dimension rubric. Findings are presented interactively with confirmation before every edit.

## Plugin Structure

```
.claude-plugin/
  plugin.json                          # Marketplace metadata
  marketplace.json                     # Marketplace registry
commands/
  elegance.md                          # /elegance [path] [--flags] entry point
skills/
  elegance/SKILL.md                    # Orchestration: banners, preferences, parallel dispatch, session management
agents/
  elegance-contract-cruft.md           # Pass 0 + 1 (parallel group A)
  elegance-duplication.md              # Pass 2 (parallel group B)
  elegance-conflicts-rethink.md        # Pass 3 + 4 (parallel group C)
  elegance-analyzer.md                 # Pass 5 synthesis (sequential, after A+B+C)
```

## Architecture

**Parallel dispatch:** For 5+ files, the skill launches three agents simultaneously (passes 0-4), then feeds merged results to the synthesis agent (pass 5). For < 5 files, analysis runs inline.

**Ranking:** impact x confidence, risk as tiebreaker. Not grouped by level.

**Rubric (owned by elegance-analyzer):** succinctness, readability, idiomaticity, reproducibility, modularity, inertia. Three or more dimensions required for "elegant."

**Preferences:** Saved to `.claude/elegance.local.md` on first run. Confirmation mode, external CLI opinions, default scope.

**Session management:** `--begin` records git HEAD baseline, `--checkpoint` scans changes since baseline, `--conclude` summarizes and cleans up. State in `.claude/elegance-session.json`.

**External CLI opinions:** Optional. For elegant-level findings, pipes before/after to detected CLIs (gemini, codex, aider) for second opinions.

## Development

Pure-markdown plugin. No build step, no dependencies. Edit the `.md` files directly.

- `.claude-plugin/plugin.json` — marketplace discovery
- `.claude-plugin/marketplace.json` — marketplace registry
- `.claude/settings.local.json` — dev-time permissions (not shipped)
- `.claude/elegance.local.md` — user preferences (created at runtime, not shipped)
- `.claude/elegance-session.json` — session state for --begin/--checkpoint/--conclude (runtime only)
- Agent tools: Read, Grep, Glob, Bash only (no WebSearch by default)
- Contract verification happens only in the synthesis agent (Pass 5), not the parallel agents
