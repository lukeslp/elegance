---
name: elegance
description: "Code refinement and multi-agent adversarial debate. Pass a file path for deep code analysis, or a question for council debate with 14 specialized agents. Confirms before every change."
allowed-tools: Read, Grep, Glob, Bash, Agent, WebSearch, WebFetch
---

# Elegance

Find the version that was always meant to be written.

<HARD-GATE>
NEVER make changes without presenting them first and getting explicit user confirmation. Show the before, show the after, explain WHY the new version is better. Every proposed change must be confirmed.
</HARD-GATE>

## Session Reuse Sweep (fires once per session, both modes)

Before Mode 1 or Mode 2 dispatches, check that the code in scope isn't reinventing wheels already turning in the user's shared infra. Runs **once per project per session**, tracked via a flag file. This is a cross-cutting gate — both Mode 1 and Mode 2 run it before their own phases begin.

**Flag:** `~/.claude/state/elegance-reuse-sweep/<cwd-slug>.flag` (slug = `pwd | sed 's|/|_|g'`). If the flag exists and was modified < 24h ago, the sweep is skipped. Ensure `~/.claude/state/elegance-reuse-sweep/` exists before writing.

**Scope (what to check against):**
- **`~/shared/llm_providers/`** — especially `ProviderFactory` in `factory.py` (unified interface to 12 LLM providers: Anthropic, OpenAI, xAI, Mistral, Cohere, Gemini, Perplexity, Groq, HuggingFace, Manus, ElevenLabs, Ollama). Direct use of `anthropic.`, `openai.`, `google.generativeai`, or raw `requests.post` to LLM hosts is a duplication flag.
- **`~/shared/utils/`**, **`~/shared/web/sse_helpers.py`**, **`~/shared/data_fetching/`** (17 API clients: arXiv, Census, GitHub, NASA, Wikipedia, YouTube, News, Weather, OpenLibrary, Semantic Scholar, Wayback, FEC, Judiciary, Finance, PubMed, Wolfram), **`~/shared/orchestration/`** (DreamCascade, DreamSwarm).
- **`~/SNIPPETS/`** — index at `~/SNIPPETS/CLAUDE.md`. Focus on `by-pattern/`, `api-clients/`, `async-patterns/`, `database-patterns/`, `data-pipelines/`.

**Sweep procedure:**
1. Check flag. If fresh, announce `Reuse sweep already ran this session (flag: <path>, age: <Xh>)` and continue to mode dispatch. Skip steps 2–4.
2. Grep in-scope files for duplication signals: LLM SDK imports, SSE handlers, API client boilerplate for any source listed above, retry/backoff code, cache helpers, config loaders.
3. For each hit, look up the shared equivalent and report as a finding:
   - **Mode 1:** emit as `Level: cruft`, `Confidence: high` with the shared import as the proposed change. Respects HARD-GATE — confirm before applying.
   - **Mode 2:** hand findings to `@reconnaissance` as part of Phase 2 fact-finding so the council works from them.
4. Touch the flag file regardless of whether findings were produced.

**Overrides:**
- `/elegance --resweep ...` forces a sweep even when the flag is fresh.
- `/elegance --no-sweep ...` skips the sweep entirely (for tight iteration loops).

## Smart Routing

Elegance has two modes. The input determines which runs:

### Mode 1: Code Refinement (file path or no args)

**Triggers:** `/elegance src/`, `/elegance app.tsx`, `/elegance` (no args = recent git changes)

Run the elegance-analyzer agent for 5-pass code scanning (contract extraction, cruft, duplication, conflicts, first-principles rethink, elegance synthesis). Present findings interactively with confirmation.

**Size gate:**
- **< 5 files:** Analyze inline, no agent needed
- **5+ files:** Launch @elegance-analyzer in background, present findings when complete

**Process:** Same as v1 — scan, rank by impact x confidence, present one finding at a time, confirm before applying, run tests after each change.

### Mode 2: Council Debate (question or decision)

**Triggers:** `/elegance "Should we rewrite this auth module?"`, `/elegance "What's the best approach for real-time updates?"`

Convene the council — multiple agents with opposing optimization targets analyze the question in parallel, debate, and produce a synthesis with dissenting opinions preserved.

**Detection:** If the input is quoted text, contains a question mark, or clearly isn't a file path — it's a council question.

---

## Council Protocol (Mode 2)

### Phase 1: Framing

Display banner, then:

1. **Restate the decision** in one sentence
2. **Define acceptance criteria** — what would a good answer include?
3. **Select domain guests** by checking triggers:
   - **@conscience** (accessibility): UI, frontend, components, forms, navigation, buttons, inputs, modals, touch, screen reader
   - **@radiance** (data visualization): charts, graphs, D3, dashboard, plots, maps, choropleths
   - **@cadence** (embedded/firmware): Arduino, ESP32, Raspberry Pi, firmware, IoT, sensors, GPIO, I2C, MQTT
4. **Announce the table** — list seated guests

When in doubt, seat the domain guest.

### Phase 2: Fact-Finding (parallel)

Launch two agents in parallel — facts before opinions:

- **@reconnaissance** — maps what exists in the codebase
- **@brilliance** — finds praised external implementations

Wait for both to complete before Phase 3.

### Phase 3: Analysis (parallel)

Launch all remaining seated agents in parallel with fact-finding results. Each agent produces:

```
- **Claim**: [one sentence]
- **Mechanism**: [how/why, with code or specifics]
- **Risks**: [what could go wrong]
- **Evidence**: [code refs, sources, logic]
```

Core agents:
- **@vigilance** — attacks proposals, finds failure modes
- **@defiance** — challenges the emerging consensus (must always dissent)
- **@resilience** — designs recovery for failure modes
- **@provenance** — checks licensing, attribution
- **@elegance-analyzer** — proposes the refined rewrite (only refines surviving proposals)
- **@assurance** — designs verification strategy
- **@coherence** — assesses architecture fit

Plus any seated domain guests (@conscience, @radiance, @cadence).

### Phase 4: Synthesis

Score findings against rubric:

| Criterion | Weight |
|-----------|--------|
| Correctness | 25% |
| Risk | 20% |
| Fit (Coherence) | 15% |
| Verifiability (Assurance) | 15% |
| Maintainability | 15% |
| User impact | 10% |

Produce output, then pass to **@eloquence** for humanization (post-verdict only).

## Protocol Rules

1. **Facts outrank precedent. Precedent outranks taste.**
2. **Every criticism must include a concrete failure mode.** Unsupported objections expire.
3. **Defiance must always dissent.** Names the strongest counterargument even when consensus is correct.
4. **Elegance-analyzer only refines surviving proposals.**
5. **Eloquence is post-verdict only.** Never influences the decision.
6. **No agent speaks twice until all activated agents have spoken once.**
7. **Brilliance must explain why a pattern transfers**, not just that it's popular.
8. **Dissenting opinions are always preserved.** Never flatten disagreement into false consensus.
9. **Reuse sweep findings enter Phase 2 via @reconnaissance.** Shared-infra duplicates (ProviderFactory, sse_helpers, data_fetching clients, SNIPPETS patterns) are facts, not taste — they outrank precedent.

## Council Output Format

```markdown
## Decision: [one-line summary]

### Recommended Approach
[The winning proposal with rationale]

### Key Evidence
- [Reconnaissance findings]
- [Brilliance findings]

### Risk Assessment
- [Vigilance's top concerns]
- [Resilience's mitigation strategies]

### Verification Plan
[Assurance's testing strategy]

### Architecture Fit
[Coherence's assessment]

### Attribution
[Provenance's findings]

### Dissenting Opinions
- **Defiance**: [strongest counterargument]
- [Any other unresolved disagreements]

### Rejected Alternatives
[What was considered and why it lost]
```

## Code Refinement Output Format (Mode 1)

```markdown
### [area/file] — [finding title]

**Level:** cruft | simplify | elegant
**Impact:** high | medium | low
**Confidence:** high | medium | low
**Risk:** low | medium | high

**What I found:** [current state]
**Why it matters:** [what's wrong or opportunity]
**Proposed change:** [before/after]
**Contract check:** [how rewrite preserves behavior]

**Apply this change? (y/n)**
```

## Confirmation Protocol (Mode 1)

- Present one finding at a time
- Wait for explicit confirmation before ANY edit
- "Apply all" or "yes to all" allows batch-applying
- If user disagrees, skip — don't argue
- After applying: run tests if they exist, report pass/fail

## Agents

| Agent | Color | Phase | Role |
|-------|-------|-------|------|
| @elegance-analyzer | magenta | Mode 1 / Phase 3 | 5-pass code refinement |
| @governance | yellow | Phase 1, 4 | Orchestrator, synthesis |
| @reconnaissance | blue | Phase 2 | Inward fact-finding |
| @brilliance | cyan | Phase 2 | Outward fact-finding |
| @vigilance | red | Phase 3 | Adversarial attack |
| @defiance | magenta | Phase 3 | Structured dissent |
| @resilience | green | Phase 3 | Error recovery |
| @provenance | white | Phase 3 | Attribution, licensing |
| @assurance | yellow | Phase 3 | Testing, verification |
| @coherence | blue | Phase 3 | Architecture fit |
| @eloquence | cyan | Post | Humanization |
| @conscience | green | Phase 3 (domain) | Accessibility |
| @radiance | magenta | Phase 3 (domain) | Data visualization |
| @cadence | yellow | Phase 3 (domain) | Embedded/firmware |
