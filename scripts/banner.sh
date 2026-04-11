#!/usr/bin/env bash
# banner.sh — Display per-agent ASCII banners with personality fonts and colors
# Usage: bash scripts/banner.sh <AGENT_NAME> [subtitle]
# Requires: pyfiglet (pip3 install pyfiglet)
# Fallback: toilet -f future, then figlet -f small, then plain text

set -euo pipefail

NAME="${1:-ELEGANCE}"
SUBTITLE="${2:-}"
RESET='\033[0m'

# Per-agent font + color assignments
get_font() {
    case "$1" in
        GOVERNANCE)      echo "calvin_s" ;;
        RECONNAISSANCE)  echo "smbraille" ;;
        BRILLIANCE)      echo "emboss2" ;;
        VIGILANCE)       echo "broadway_kb" ;;
        DEFIANCE)        echo "eftiwater" ;;
        RESILIENCE)      echo "fourtops" ;;
        PROVENANCE)      echo "heart_right" ;;
        ELEGANCE)        echo "eftiwater" ;;
        ASSURANCE)       echo "smbraille" ;;
        COHERENCE)       echo "linux" ;;
        ELOQUENCE)       echo "pagga" ;;
        CONSCIENCE)      echo "amc_3_line" ;;
        RADIANCE)        echo "pagga" ;;
        CADENCE)         echo "straight" ;;
        *)               echo "small" ;;
    esac
}

get_color() {
    case "$1" in
        GOVERNANCE)      echo '\033[1;33m' ;;  # bold yellow
        RECONNAISSANCE)  echo '\033[1;34m' ;;  # bold blue
        BRILLIANCE)      echo '\033[1;36m' ;;  # bold cyan
        VIGILANCE)       echo '\033[1;31m' ;;  # bold red
        DEFIANCE)        echo '\033[1;35m' ;;  # bold magenta
        RESILIENCE)      echo '\033[1;32m' ;;  # bold green
        PROVENANCE)      echo '\033[0;37m' ;;  # white
        ELEGANCE)        echo '\033[1;35m' ;;  # bold magenta
        ASSURANCE)       echo '\033[1;33m' ;;  # bold yellow
        COHERENCE)       echo '\033[1;34m' ;;  # bold blue
        ELOQUENCE)       echo '\033[1;36m' ;;  # bold cyan
        CONSCIENCE)      echo '\033[1;32m' ;;  # bold green
        RADIANCE)        echo '\033[1;35m' ;;  # bold magenta
        CADENCE)         echo '\033[1;33m' ;;  # bold yellow
        # Phase banners
        PHASE*)          echo '\033[1;37m' ;;  # bold white
        *)               echo '\033[0m' ;;
    esac
}

FONT=$(get_font "$NAME")
COLOR=$(get_color "$NAME")

# Try pyfiglet first (571 fonts), then toilet, then figlet, then plain
if python3 -c "import pyfiglet" 2>/dev/null; then
    printf "${COLOR}"
    python3 -c "import pyfiglet; print(pyfiglet.figlet_format('$NAME', font='$FONT').rstrip())"
    printf "${RESET}"
elif command -v toilet &>/dev/null; then
    printf "${COLOR}"
    toilet -f future "$NAME"
    printf "${RESET}"
elif command -v figlet &>/dev/null; then
    printf "${COLOR}"
    figlet -f small "$NAME"
    printf "${RESET}"
else
    printf "${COLOR}═══ %s ═══${RESET}\n" "$NAME"
fi

if [[ -n "$SUBTITLE" ]]; then
    printf "${COLOR}  %s${RESET}\n" "$SUBTITLE"
fi
