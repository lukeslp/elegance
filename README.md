# elegance

Deep code refinement for Claude Code. Finds cruft, duplication, CSS/JS conflicts, and elegant solutions — then seeks confirmation before every change.

## Install

```
/install lukeslp/elegance
```

## Usage

```
/elegance              # analyze recent git changes
/elegance src/         # analyze a specific directory
/elegance app.tsx      # analyze a specific file
```

## What it does

Six analysis passes, three levels of findings:

### Passes
1. **Cruft scan** — dead code, unused imports, orphan files, stale TODOs
2. **Duplication audit** — copy-pasted logic, repeated CSS/JS patterns, near-identical components
3. **Conflict detection** — CSS specificity wars, competing event handlers, z-index battles, state duplication
4. **First-principles rethink** — complex logic distilled to its essence
5. **Shared component extraction** — reusable patterns hiding across the codebase
6. **Elegance search** — find the "aha" solution via web search for well-regarded patterns

### Finding levels
- **Elegant** — the rewrite that makes someone say "oh, that's beautiful"
- **Simplify** — works but harder than it needs to be
- **Cruft** — shouldn't be there at all

Every proposed change is presented with before/after and rationale. Nothing is changed without your explicit confirmation.

## Components

| Component | Type | Purpose |
|-----------|------|---------|
| `/elegance` | Command | Entry point with optional path argument |
| `elegance` | Skill | Interactive refinement flow with confirmation |
| `elegance-analyzer` | Agent | Background codebase scanning |

## License

MIT
