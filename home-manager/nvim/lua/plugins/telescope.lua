return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    -- Loaded via the <leader>f* keymaps in config/keymaps.lua.
    keys = { "<leader>ff", "<leader>fw", "<leader>fb", "<leader>fh" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
      },
    },
  },
}
