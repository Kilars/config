# CLAUDE.md

This repo is a Nix home-manager dotfiles config — and it manages **Claude Code
itself** via `home-manager/claude.nix` (the `claude-code` package,
`settings.json`, statusline, and skills).

Key rule: edit the Nix source under `home-manager/`, then run `home-manager
switch`. Do **not** edit generated files in `~/.config/` or `~/.claude/`
directly. In particular, `~/.claude/settings.json` is a **read-only** Nix store
symlink, so `/config`, `/model`, and `/statusline` changes won't persist —
change them in `home-manager/claude.nix` instead.

Full guidance:

@AGENTS.md
