# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Claude Code plugin that performs deep code refinement. Six analysis passes find cruft, duplication, CSS/JS conflicts, first-principles simplifications, shared component opportunities, and elegant rewrites. Every proposed change requires user confirmation before applying.

## Plugin Structure

```
.claude-plugin/plugin.json   # Plugin metadata (required for marketplace install)
commands/elegance.md          # /elegance [path] slash command entry point
skills/elegance/SKILL.md      # Core skill: interactive review loop with confirmation protocol
agents/elegance-analyzer.md   # Background agent: heavy six-pass codebase scanning
```

The command delegates to the skill, which launches the agent for heavy scanning, then presents findings interactively one at a time.

## Architecture

**Three-level finding classification:** cruft (remove), simplify (reduce complexity), elegant (rewrite that feels inevitable)

**Six analysis passes:** cruft scan, duplication audit, conflict detection, first-principles rethink, shared component opportunities, elegance search (web-assisted)

**Confirmation gate:** The skill enforces a hard gate — no edits without explicit user approval. Findings are presented individually with before/after/rationale.

## Development

This is a pure-markdown plugin — no build step, no dependencies. Edit the `.md` files directly.

- `package.json` exists for npm metadata but is not used by the plugin system
- `.claude-plugin/plugin.json` is what Claude Code reads for marketplace discovery
- `.claude/settings.local.json` configures dev-time permissions (not shipped with the plugin)

## Install

```
/install lukeslp/elegance
```
