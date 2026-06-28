{ pkgs, lib, ... }:

let
  # Auto-discover every skill directory under ./claude/skills and link each one
  # individually into ~/.claude/skills/. Drop a new dir in the repo -> it's
  # linked on the next `home-manager switch`. Linking per-skill (rather than the
  # whole skills/ dir) keeps ~/.claude/skills writable for anything Claude adds
  # at runtime.
  skillsSrc = ./claude/skills;
  skillNames = builtins.attrNames
    (lib.filterAttrs (_: type: type == "directory") (builtins.readDir skillsSrc));
  skillLinks = builtins.listToAttrs (map (n: {
    name = ".claude/skills/${n}";
    value.source = skillsSrc + "/${n}";
  }) skillNames);
in
{
  # claude-code itself + jq (used by the statusline script below).
  # claude-code is pinned to nixpkgs and updated via `nix flake update`; it does
  # NOT self-update. The native installer (~/.local/{bin,share}/claude) has been
  # removed so the two don't conflict on PATH.
  home.packages = [ pkgs.claude-code pkgs.jq ];

  # Declarative Claude Code config. Everything here is written as a read-only
  # symlink into the Nix store -> change it HERE and run `home-manager switch`,
  # not via Claude's runtime /config, /model, or theme toggles.
  #
  # Intentionally NOT managed by Nix (mutable runtime state): claude-mem's
  # data/daemon, and ~/.claude.json / credentials / history / sessions. We only
  # *declare* the plugin enabled below; Claude still installs it from its
  # marketplace.
  home.file = {
    ".claude/settings.json".text = builtins.toJSON {
      model = "opus";
      effortLevel = "xhigh";
      theme = "dark";
      enabledPlugins = {
        "claude-mem@thedotmack" = true;
      };
      statusLine = {
        type = "command";
        command = "${pkgs.bash}/bin/bash ${./claude/statusline.sh}";
      };
    };
  } // skillLinks;
}
