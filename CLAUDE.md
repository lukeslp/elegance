# elegance v2

Code refinement plugin for Claude Code, expanded with a multi-agent adversarial debate council.

## Architecture

**One command, two modes:**

- `/elegance src/` → 5-pass code refinement (elegance-analyzer)
- `/elegance "Should we rewrite this?"` → council debate (14 agents)

Detection: file path → code scan. Quoted question → council.

## Plugin Structure

```
.claude-plugin/          Plugin metadata
agents/                  14 agent definitions (each <2000 tokens)
  elegance-analyzer.md   Original 5-pass code scanner (v1)
  governance.md          Council orchestrator
  reconnaissance.md      Inward fact-finding
  brilliance.md          External implementation search
  vigilance.md           Adversarial attack
  defiance.md            Structured dissent (catfish)
  resilience.md          Error recovery
  provenance.md          Attribution, licensing
  assurance.md           Testing, verification
  coherence.md           Architecture fit
  eloquence.md           Post-verdict humanization
  conscience.md          Accessibility (domain)
  radiance.md            Data visualization (domain)
  cadence.md             Embedded/firmware (domain)
skills/elegance/SKILL.md Smart routing + protocol
commands/elegance.md     /elegance entry point
scripts/banner.sh        toilet/figlet ASCII banners
```

## Agent Colors

Each agent shows as a colored @tag in Claude Code:

| Agent | Color | Role |
|-------|-------|------|
| @elegance-analyzer | magenta | Code refinement |
| @governance | yellow | Orchestration |
| @reconnaissance | blue | Inward facts |
| @brilliance | cyan | External facts |
| @vigilance | red | Adversarial |
| @defiance | magenta | Dissent |
| @resilience | green | Recovery |
| @provenance | white | Attribution |
| @assurance | yellow | Verification |
| @coherence | blue | Architecture |
| @eloquence | cyan | Humanization |
| @conscience | green | Accessibility |
| @radiance | magenta | Data viz |
| @cadence | yellow | Firmware |

## Council Protocol Rules

1. Facts outrank precedent. Precedent outranks taste.
2. Every criticism must include a concrete failure mode.
3. Defiance must always dissent.
4. Elegance-analyzer only refines surviving proposals.
5. Eloquence is post-verdict only.
6. Dissenting opinions are always preserved.

## Development

Pure-markdown plugin — no build step, no dependencies. Edit the `.md` files directly. Banner script requires `toilet` or `figlet` (falls back to plain text).
