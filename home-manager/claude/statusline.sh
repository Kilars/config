#!/usr/bin/env bash
# Claude Code statusline: model · context capacity · usage% · effort · folder
# Receives a JSON payload on stdin from Claude Code.
export LC_ALL=C   # ensure '.' decimal separator so printf '%.0f' handles e.g. 42.7
input=$(cat)

m=$(printf '%s' "$input" | jq -r '.model.display_name // "?"')
m=${m#Claude }                                                   # "Claude Opus 4.8" -> "Opus 4.8"
sz=$(printf '%s' "$input" | jq -r '.context_window.context_window_size // empty')
pct=$(printf '%s' "$input" | jq -r '.context_window.used_percentage // empty')
dir=$(printf '%s' "$input" | jq -r '.workspace.current_dir // empty')
fold=$(basename "${dir:-$PWD}")
eff=$(jq -r '.effortLevel // empty' "$HOME/.claude/settings.json" 2>/dev/null)

esc=$(printf '\033')
R="${esc}[0m"
BURG="${esc}[1;38;2;168;50;78m"  # model + capacity -> burgundy (#A8324E)
DIM="${esc}[2m"                  # folder           -> dim
MG="${esc}[35m"                  # effort           -> magenta

# context capacity: 1000000 -> 1M, 200000 -> 200K
cap=""
if [ -n "$sz" ]; then
  if   [ "$sz" -ge 1000000 ]; then cap="$((sz / 1000000))M"
  elif [ "$sz" -ge 1000 ];    then cap="$((sz / 1000))K"
  else cap="$sz"
  fi
fi

# usage percentage, colored by threshold
p=""
pc=""
if [ -n "$pct" ]; then
  p=$(printf '%.0f' "$pct")
  if   [ "$p" -ge 80 ]; then pc="${esc}[1;38;2;224;108;117m"   # high -> coral  #E06C75
  elif [ "$p" -ge 50 ]; then pc="${esc}[1;38;2;229;192;123m"   # mid  -> gold   #E5C07B
  else pc="${esc}[1;38;2;126;192;167m"                          # low  -> teal   #7EC0A7
  fi
fi

out="${BURG}${m}${R}"
[ -n "$cap" ] && out="${out} ${BURG}${cap}${R}"
[ -n "$p" ]   && out="${out}  ${pc}${p}%${R}"
[ -n "$eff" ] && out="${out}  ${MG}${eff}${R}"
out="${out}  ${DIM}${fold}${R}"

printf '%s' "$out"
