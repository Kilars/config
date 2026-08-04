return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      -- Formatter binaries come from Nix (home.packages).
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        sh = { "shfmt" },
      },
      -- <leader>fm formats manually; anything without a formatter above
      -- falls back to the LSP (e.g. rust_analyzer for Rust).
      default_format_opts = {
        lsp_format = "fallback",
      },
    },
  },
}
