-- Bootstrap lazy.nvim (installed to the writable data dir, not the read-only
-- Nix-store config dir).
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  spec = {
    { import = "plugins" },
  },
  -- The config dir is a read-only Nix symlink, so lazy cannot write its
  -- lockfile there. Point it at the writable state dir instead.
  lockfile = vim.fn.stdpath "state" .. "/lazy-lock.json",
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = false },
  change_detection = { notify = false },
}
