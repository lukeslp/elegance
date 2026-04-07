#!/usr/bin/env bash
# banner.sh — Display agent/phase banners using toilet or figlet
# Usage: bash scripts/banner.sh <agent_name> [subtitle]
# Output: 4-line ASCII banner (3-line name + subtitle)

set -euo pipefail

NAME="${1:-ELEGANCE}"
SUBTITLE="${2:-}"

# Prefer toilet -f future (3 lines, box-drawing), fall back to figlet -f small
if command -v toilet &>/dev/null; then
    toilet -f future "$NAME"
elif command -v figlet &>/dev/null; then
    figlet -f small "$NAME"
else
    # Pure fallback — no dependencies
    echo "═══ $NAME ═══"
fi

[[ -n "$SUBTITLE" ]] && echo "  $SUBTITLE"
