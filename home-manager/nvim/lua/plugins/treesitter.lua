return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSUpdate", "TSInstallInfo" },
    opts = {
      -- Parsers compiled on demand with gcc into ~/.local/share/nvim.
      -- Add more here, or just run :TSInstall <lang> at runtime.
      ensure_installed = {
        "vim",
        "vimdoc",
        "lua",
        "bash",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "rust",
        "nix",
        "markdown",
        "markdown_inline",
      },
      auto_install = true, -- auto-install a parser when opening a new filetype
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
