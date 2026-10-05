#!/usr/bin/env bash
# Glorified /clear for Claude Code *remote-control* sessions (works from phone,
# where /clear can't). Spawns a fresh auto-mode remote session detached, then
# kills THIS session — identified precisely by walking up our own process tree,
# not by guessing "oldest". Runs from inside the session it replaces.
# Optional arg 1 = project dir (defaults to current session cwd).
cd "${1:-$PWD}" || exit 1

# Identify THIS session's own `claude --remote-control` process by walking up
# the parent chain from this script. The previous version used
# `pkill -o -f 'claude --remote-control'` (kill the OLDEST match), which killed
# the wrong process whenever a stale remote-control session was lying around —
# and the `script -qfc "claude --remote-control…"` PTY wrapper matches that
# pattern too, making "oldest" doubly unreliable. Capturing our own PID up
# front, before spawning the replacement, sidesteps both traps.
self_pid=""; wrapper_pid=""
pid=$$
while [ -n "$pid" ] && [ "$pid" -gt 1 ]; do
  args=$(ps -o args= -p "$pid" 2>/dev/null)
  case "$args" in
    "claude --remote-control"*)
      self_pid=$pid
      wrapper_pid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')  # the `script` PTY wrapper
      break ;;
  esac
  pid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')
done

# The new session must be born with a PTY. Detaching with stdin from /dev/null
# gives it no tty, so `claude` decides it's non-interactive, demands a --print
# prompt, errors out ("Input must be provided ... when using --print") and dies
# within ~1s. `script` allocates a pseudo-tty so the interactive remote-control
# session actually starts. NB: remote control is the `--remote-control [name]`
# *flag*, not a subcommand (there is no `claude remote-control` subcommand).
#
# CLAUDE_CODE_ENABLE_AUTO_MODE=1 is what actually makes the new session come up
# in *auto* mode rather than silently downgraded to default. Auto mode passes a
# provider gate (`firstParty`/`anthropicAws`, else this env opt-in); in this
# detached setsid+PTY context provider auto-detection can miss `firstParty`, so
# `--permission-mode auto` alone (and even settings `defaultMode: auto`) gets
# ignored and the session lands in default. The env var forces the gate open.
setsid script -qfc "CLAUDE_CODE_ENABLE_AUTO_MODE=1 claude --remote-control cc-$(date +%H%M%S) --permission-mode auto" /dev/null </dev/null >/dev/null 2>&1 &
disown; sleep 2                                   # let the new session register with claude.ai

if [ -n "$self_pid" ]; then
  # Kill THIS exact session (and its `script` PTY wrapper). The freshly spawned
  # session has a different PID, so it is untouched — and any stale remote
  # sessions from earlier are left alone rather than killed by mistake.
  kill "$self_pid" 2>/dev/null
  [ -n "$wrapper_pid" ] && [ "$wrapper_pid" -gt 1 ] 2>/dev/null && kill "$wrapper_pid" 2>/dev/null
else
  # Fallback: couldn't resolve our own PID (unexpected — not launched from a
  # remote-control session?). Fall back to the old oldest-match behaviour so
  # /fresh still does *something* rather than silently leaving two sessions.
  pkill -o -f 'claude --remote-control'
fi
