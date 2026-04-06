---
name: elegance
description: "Code refinement — finds the version that was always meant to be written. /elegance [path] [--flags]"
arguments:
  - name: path
    description: "File or directory to analyze (optional — defaults to preference or recent changes)"
    required: false
---

Invoke the `elegance` skill with: $ARGUMENTS

Flag reference (pass these through to the skill):
- `--setup` — Re-run the preference wizard
- `--full` — Full codebase scan regardless of scope preference
- `--quick` — Cruft-only pass, fast, no agents
- `--begin` — Start a new session: record git HEAD as baseline, run initial full scan
- `--checkpoint` — Incremental pass on files changed since --begin
- `--conclude` — Final pass, print session summary, clean up
