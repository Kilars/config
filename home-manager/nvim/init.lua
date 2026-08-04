-- Self-managed Neovim config (migrated off NvChad v1).
-- Structure:
--   lua/config/*  -> options, keymaps, autocmds, lazy bootstrap
--   lua/plugins/* -> one spec file per concern, auto-imported by lazy
--
-- LSP server + formatter binaries come from Nix (home.packages), NOT mason.

require "config.options"
require "config.keymaps"
require "config.autocmds"
require "config.lazy"
