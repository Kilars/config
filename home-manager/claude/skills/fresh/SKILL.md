---
name: fresh
description: Restart the current Claude Code REMOTE-CONTROL session with a clean context, in auto (no-prompt) mode. A "/clear" that works from the phone/remote where /clear can't. Use when the user says "/fresh", "fresh session", "restart remote session", "clear from phone", or wants a clean slate on a remote-driven session.
---

# /fresh — respawn the remote-control session, clean, in auto mode

Purpose: from a phone-driven remote-control session you can't hit `/clear`. This spawns a
**new** `claude --remote-control` session (auto permission mode) detached, then **kills the
current one**. On the phone the old session drops and a new `cc-HHMMSS` appears — tap it.

## Do this
Run the bundled script and tell the user what happened:

```bash
bash ~/.claude/skills/fresh/reset.sh
```

- The current session **dies** as part of this (that's the point) — so this is the last thing
  you do. Don't queue work after it.
- The new session opens in the **same working directory** and in **auto mode**
  (`--permission-mode auto`: routine actions auto-approved, background safety classifier still
  blocks destructive/exfil moves).
- To respawn in a different dir: `bash ~/.claude/skills/fresh/reset.sh /path/to/project`.

## How it stays alive
`setsid script -qfc … /dev/null & disown` spawns the new session under a **pseudo-tty** and
detaches it so it survives the current process dying. The `script` PTY is essential: a plain
`setsid claude … </dev/null` gets no tty, so `claude` treats it as non-interactive, demands a
`--print` prompt, errors out and dies in ~1s — then the kill below takes out *this* session and
you're left with **nothing** (the exact failure this replaced).

## How it kills the *right* session
Before spawning the replacement, the script walks up its own parent chain (`$$` → … → the
`claude --remote-control` ancestor) to capture **this session's exact PID** and its `script`
PTY-wrapper PID, then `kill`s precisely those. The freshly spawned session has a different PID,
so it's untouched, and any **stale** remote-control sessions lying around are left alone.
(The old version used `pkill -o -f 'claude --remote-control'` — kill the *oldest* match — which
targeted the wrong process whenever a stale session existed; the `script` wrapper matches that
pattern too, compounding it. That's why `/fresh` used to leave orphans behind.) If the walk-up
can't resolve our own PID, it falls back to the old `pkill -o` so `/fresh` still does something.

## Requires
`claude` ≥ 2.1.x with the `--remote-control [name]` flag (a flag, not a subcommand — there is
no `claude remote-control` subcommand). No settings.json changes — nothing nix-managed is
touched.
