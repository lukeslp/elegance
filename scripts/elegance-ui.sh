#!/usr/bin/env bash
# elegance-ui.sh — CLI visual output for the elegance plugin
# Usage: bash elegance-ui.sh <command> [args...]
#
# Commands:
#   start <scope>           Session start banner
#   pass <label>            Pass header (before dispatch)
#   done <label> <count>    Pass complete (after return)
#   score <cruft> <simplify> <elegant>   Findings scoreboard
#   finding <level> <title> Finding header
#   session <action>        Session management (begin|checkpoint|conclude)
#   prefs <mode> <cli> <scope>  Preference summary one-liner
#   summary <files> <findings> <applied> <duration>  Session summary stats

set -euo pipefail

# Colors
M='\033[35m'      # magenta
MB='\033[1;35m'   # bold magenta
W='\033[1;37m'    # bold white
D='\033[2m'       # dim
R='\033[31m'      # red
Y='\033[33m'      # yellow
G='\033[32m'      # green
C='\033[36m'      # cyan
X='\033[0m'       # reset

cmd="${1:-help}"
shift 2>/dev/null || true

case "$cmd" in

  start)
    scope="${1:-recent changes}"
    printf '\n'
    printf "${MB}  ◆ elegance${X}  ${D}%s${X}\n" "$scope"
    printf "${M}  ─────────────────────────────────${X}\n"
    printf '\n'
    ;;

  pass)
    label="${1:-analysis}"
    printf "${M}  ▸ %s${X}\n" "$label"
    ;;

  done)
    label="${1:-analysis}"
    count="${2:-0}"
    if [ "$count" -eq 0 ]; then
      printf "${M}  ✓ %s ${D}· clean${X}\n" "$label"
    else
      printf "${M}  ✓ %s ${D}· %d finding%s${X}\n" "$label" "$count" "$([ "$count" -eq 1 ] && echo '' || echo 's')"
    fi
    ;;

  score)
    cruft="${1:-0}"
    simplify="${2:-0}"
    elegant="${3:-0}"
    total=$((cruft + simplify + elegant))
    printf '\n'
    printf "${M}  ─────────────────────────────────${X}\n"
    if [ "$total" -eq 0 ]; then
      printf "  ${G}no findings${X}\n"
    else
      printf "  ${R}%d cruft${X}  ${Y}%d simplify${X}  ${G}%d elegant${X}\n" "$cruft" "$simplify" "$elegant"
    fi
    printf "${M}  ─────────────────────────────────${X}\n"
    printf '\n'
    ;;

  finding)
    level="${1:-simplify}"
    title="${2:-untitled}"
    case "$level" in
      cruft)    color="$R"; icon="✕" ;;
      simplify) color="$Y"; icon="◇" ;;
      elegant)  color="$G"; icon="◆" ;;
      *)        color="$D"; icon="·" ;;
    esac
    printf "\n  ${color}${icon} %s${X}  ${D}%s${X}\n" "$level" "$title"
    ;;

  session)
    action="${1:-begin}"
    case "$action" in
      begin)
        printf '\n'
        printf "${MB}  ◆ elegance ${C}session start${X}\n"
        printf "${M}  ─────────────────────────────────${X}\n"
        printf "${D}  baseline recorded · full scan starting${X}\n"
        printf '\n'
        ;;
      checkpoint)
        printf '\n'
        printf "${MB}  ◆ elegance ${C}checkpoint${X}\n"
        printf "${M}  ─────────────────────────────────${X}\n"
        printf "${D}  scanning changes since baseline${X}\n"
        printf '\n'
        ;;
      conclude)
        printf '\n'
        printf "${MB}  ◆ elegance ${C}session complete${X}\n"
        printf "${M}  ─────────────────────────────────${X}\n"
        ;;
    esac
    ;;

  prefs)
    mode="${1:-confirm-each}"
    cli="${2:-none}"
    scope="${3:-recent}"
    printf "${D}  prefs: %s · cli-opinions: %s · scope: %s${X}\n\n" "$mode" "$cli" "$scope"
    ;;

  summary)
    files="${1:-0}"
    findings="${2:-0}"
    applied="${3:-0}"
    duration="${4:-unknown}"
    printf "  ${D}files: %s · findings: %s · applied: %s · %s${X}\n" "$files" "$findings" "$applied" "$duration"
    ;;

  help|*)
    printf "Usage: bash elegance-ui.sh <command> [args...]\n"
    printf "Commands: start, pass, done, score, finding, session, prefs, summary\n"
    ;;
esac
