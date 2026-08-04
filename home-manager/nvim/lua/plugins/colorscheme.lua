return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- load before other plugins
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = false,
        treesitter = true,
        telescope = true,
        native_lsp = { enabled = true },
        mini = { enabled = true },
      },
      custom_highlights = function(colors)
        return {
          Comment = { fg = colors.overlay1, style = { "italic" } },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme "catppuccin"
    end,
  },
}
