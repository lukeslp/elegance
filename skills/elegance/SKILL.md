---
name: elegance
description: "Code refinement that goes past cleanup to find the version that feels inevitable. Use when reviewing code quality, refactoring, cleaning up, or when someone asks to simplify, deduplicate, or improve code. Confirms before every change."
---

# Elegance

Find the version of the code that was always meant to be written.

<HARD-GATE>
NEVER make changes without presenting them first and getting explicit user confirmation. Show the before, show the after, explain WHY the new version is better. Every proposed change must be confirmed.
</HARD-GATE>

## Banners

Print these at key moments using the Bash tool. They make the passes visible and the work trustworthy.

**Session start:**
```bash
printf '\n\033[1;35m  ┌───────────────────────────────────────┐\033[0m\n'
printf '\033[1;35m  │\033[0m  \033[1;37m◆ elegance\033[0m  \033[2m%s\033[0m\033[1;35m%*s│\033[0m\n' "$SCOPE_LABEL" $((28 - ${#SCOPE_LABEL})) ""
printf '\033[1;35m  └───────────────────────────────────────┘\033[0m\n\n'
```
Where `$SCOPE_LABEL` is something like `4 files · recent changes` or `src/ · 12 files`. Adjust the padding math to fit the content.

**Pass header** (print before each agent dispatch or inline pass):
```bash
printf '\033[35m  ── pass %s ──\033[0m\n' "0+1 · contract + cruft"
```

**Pass complete** (print when an agent returns):
```bash
printf '\033[35m  ── pass %s · %d findings ──\033[0m\n' "0+1" 3
```

**Scoreboard** (print after all passes, before presenting findings):
```bash
printf '\n\033[1;35m  ┌───────────────────────────────────────┐\033[0m\n'
printf '\033[1;35m  │\033[0m  \033[31m%d cruft\033[0m · \033[33m%d simplify\033[0m · \033[32m%d elegant\033[0m\033[1;35m%*s│\033[0m\n' 2 3 1 $PAD ""
printf '\033[1;35m  └───────────────────────────────────────┘\033[0m\n\n'
```

Adjust padding dynamically. If numbers are large, shrink padding. Keep the boxes clean.

## Preferences

**First run** (no `.claude/elegance.local.md` in the target project):

1. Detect available external CLIs:
   ```bash
   which gemini codex aider 2>/dev/null
   ```

2. Ask three questions using AskUserQuestion:

   **Question 1** — Confirmation mode:
   - "Confirm each change individually" 
   - "Batch by level (approve all cruft at once, then simplify, then elegant)"

   **Question 2** — External CLI opinions (only if CLIs detected):
   - "Yes — get second opinions on elegant-level findings from [detected tools]"
   - "No — skip external opinions"

   **Question 3** — Default scope (only if no path was given):
   - "Recent changes (git diff)"
   - "Full project scan"

3. Save answers to `.claude/elegance.local.md`:
   ```yaml
   ---
   confirmation: confirm-each
   cli_opinions: true
   detected_clis: [gemini, codex]
   default_scope: recent-changes
   ---
   ```

**Subsequent runs:** Read `.claude/elegance.local.md` and print a one-liner after the session banner:
```bash
printf '\033[2m  prefs: %s · cli-opinions: %s · scope: %s\033[0m\n\n' "confirm-each" "gemini,codex" "recent"
```

**`--setup` flag:** Delete `.claude/elegance.local.md` and re-run the wizard.

## Determining Target

- `--begin`: record current HEAD, then full scan (see Session Management)
- `--checkpoint`: scan only files changed since `--begin` baseline
- `--conclude`: final pass on changed files, then session summary
- `--full`: full project scan regardless of preference
- `--quick`: cruft-only, inline, no agents
- Explicit path: analyze that path
- No path, no flags: use the scope from preferences (recent changes or full scan)
- Always respect .gitignore and skip node_modules, dist, build, vendor, etc.
- For large codebases without a specific target, focus on the most-touched files (git log --shortstat)

## Analysis Flow

### Small target (< 5 files) or --quick

Run the analysis inline — no agents. Apply the pass logic directly:
- If `--quick`: only Pass 1 (cruft scan). Fast, no frills.
- Otherwise: run all passes sequentially in the conversation.

Print pass headers as you go.

### Large target (5+ files)

Dispatch three agents in parallel:

1. **elegance-contract-cruft** agent — Pass 0 (contract extraction) + Pass 1 (cruft scan)
2. **elegance-duplication** agent — Pass 2 (duplication and shared patterns)
3. **elegance-conflicts-rethink** agent — Pass 3 (conflicts) + Pass 4 (first-principles + docs)

Print pass headers as each dispatches. Print pass-complete with finding counts as each returns.

When all three return:
- Merge their findings into a single list
- Forward the merged findings + contract context to the **elegance-analyzer** agent for Pass 5 (elegance synthesis)
- The synthesis agent returns the final ranked report

Print the scoreboard.

## External CLI Opinions (elegant findings only)

If enabled in preferences and CLIs are available:

For each **elegant-level** finding (skip cruft and simplify — not worth the latency):

1. Format the before/after as a compact prompt
2. Pipe to each detected CLI:
   - `echo "[before]\n---\n[after]\n---\nIs this refactor correct and genuinely better? One paragraph." | gemini -p "Review this code change briefly."`
   - Same pattern for `codex exec "..."` and `aider --no-git --yes -m "..."`
3. Summarize their responses as a line in the finding: `**Second opinions:** gemini agrees, codex agrees` or `**Second opinions:** gemini flags potential issue with X`

Run these in parallel (one Bash call per CLI).

## Presenting Findings

Findings are ranked by **impact x confidence** (not grouped by level). Present them in that order.

For each finding:

```
### [area/file] — [finding title]

**Level:** cruft | simplify | elegant
**Impact:** high | medium | low
**Confidence:** high | medium | low
**Risk:** low | medium | high

**What I found:**
[Brief description]

**Why it matters:**
[What's wrong or what opportunity exists]

**Proposed change:**
[Before/after with code]

**Contract check:**
[How the rewrite preserves behavior, or what can't be verified]

**Second opinions:** [if CLI opinions enabled and this is elegant-level]

**Apply this change? (y/n)**
```

## Confirmation Protocol

**If preference is `confirm-each`:**
- Present one finding at a time
- Wait for explicit confirmation before editing
- "apply all" or "yes to all" switches to batch mode for remaining findings at the same level

**If preference is `batch-by-level`:**
- Group findings by level
- Present each group as a batch: "Apply all N cruft findings? (y/n)"
- If user declines a batch, fall back to individual confirmation for that level

**Always:**
- If the user disagrees with a finding, skip it — don't argue
- After applying changes, show a brief summary

## Test Verification

After applying any change:
- If the project has a test suite, run the relevant tests
- Report pass/fail before moving to the next finding
- If tests fail, immediately revert the change and flag it as higher risk
- If no tests exist, note "no automated verification available" in the contract check

## Session Management

### --begin
1. Print session start banner
2. Record current git HEAD:
   ```bash
   git rev-parse HEAD > .claude/elegance-session.json
   ```
   Save as JSON: `{ "baseRef": "<sha>", "startedAt": "<iso>", "applied": [] }`
3. Run a full scan (equivalent to --full)

### --checkpoint
1. Read `.claude/elegance-session.json` to get baseRef
2. Get changed files:
   ```bash
   git diff --name-only <baseRef>
   ```
3. Run analysis on those files only
4. After applying changes, append to the session's `applied` list

### --conclude
1. Read `.claude/elegance-session.json`
2. Get all files changed since baseRef
3. Run a final pass on changed files
4. Print a session summary:
   ```
   Session: <duration>
   Files scanned: N
   Findings: N cruft · N simplify · N elegant
   Applied: N changes
   ```
5. Delete `.claude/elegance-session.json`
