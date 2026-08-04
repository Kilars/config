#!/usr/bin/env bash
# Glorified /clear for Claude Code *remote-control* sessions (works from phone,
# where /clear can't). Spawns a fresh auto-mode remote session detached, then
# kills the current one. Runs from inside the session it replaces.
# Optional arg 1 = project dir (defaults to current session cwd).
cd "${1:-$PWD}" || exit 1
# NB: remote control is the `--remote-control [name]` *flag*, not a subcommand
# (there is no `claude remote-control` subcommand). The name is the flag's
# optional positional; --permission-mode auto applies to the spawned session.
setsid claude --remote-control "cc-$(date +%H%M%S)" --permission-mode auto </dev/null >/dev/null 2>&1 &
disown; sleep 2                                   # let the new session register with claude.ai
pkill -o -f 'claude --remote-control'            # -o = kill only the OLDEST match (this/old one); the fresh one survives
