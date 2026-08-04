local map = vim.keymap.set

-- Centered scrolling / jumping (carried over from the old config)
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down + center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up + center" })
map("n", "<C-j>", "jzz", { desc = "Line down + center" })
map("n", "<C-k>", "kzz", { desc = "Line up + center" })

-- jk to escape from insert mode
map("i", "jk", "<Esc>", { desc = "Escape" })

-- Keep selection when indenting in visual mode
map("v", ">", ">gv", { desc = "Indent and reselect" })
map("v", "<", "<gv", { desc = "Outdent and reselect" })

-- Format buffer with conform
map("n", "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format buffer" })

-- Error / diagnostic hover
map("n", "<leader>e", function()
  vim.diagnostic.open_float { border = "rounded" }
end, { desc = "Open error/diagnostic float" })

-- LSP rename (native; replaces nvchad.renamer)
map("n", "<leader>ra", vim.lsp.buf.rename, { desc = "LSP rename" })

-- Telescope
local function telescope(builtin)
  return function()
    require("telescope.builtin")[builtin]()
  end
end
map("n", "<leader>ff", telescope "find_files", { desc = "Find files" })
map("n", "<leader>fw", telescope "live_grep", { desc = "Live grep" })
map("n", "<leader>fb", telescope "buffers", { desc = "Find buffers" })
map("n", "<leader>fh", telescope "help_tags", { desc = "Help tags" })
