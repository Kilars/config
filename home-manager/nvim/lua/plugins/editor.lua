return {
  -- Surround (yours): ys/cs/ds to add/change/delete surrounding pairs.
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Auto-close brackets/quotes.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Indentation guide lines.
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = false },
    },
  },

  -- Inline hex/rgb colour previews.
  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Lightweight statusline (replaces NvChad's).
  {
    "echasnovski/mini.statusline",
    version = false,
    event = "VeryLazy",
    opts = { use_icons = true },
  },
}
