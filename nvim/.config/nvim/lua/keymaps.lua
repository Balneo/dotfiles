local map = vim.keymap.set
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Increment number
vim.keymap.set("n", "g+", "<C-a>", { desc = "Increment number" })

-- Decrement number
vim.keymap.set("n", "g-", "<C-x>", { desc = "Decrement number" })




-- jump next/prev TODO
vim.keymap.set("n", "<leader>tn", function()
  require("todo-comments").jump_next()
end, { desc = "Next TODO comment" })

vim.keymap.set("n", "<leader>tp", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous TODO comment" })

vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<CR>", { desc = "Search TODOs" })


-- 

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })



-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

map("n", "<leader>rn", function()
    pcall(vim.lsp.buf.rename)
end, { desc = "rename" })
map({ "n", "x" }, "<leader>ca", function()
    pcall(vim.lsp.buf.code_action)
end, { desc = "[G]oto Code [A]ction" })

map("n", "<leader>ih", function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
end, { desc = "Toggle Inlay Hints" })

map("n", "grr", function()
    pcall(require("telescope.builtin").lsp_references)
end, { desc = "[G]oto [R]eferences" })

map("n", "gd", function()
    pcall(require("telescope.builtin").lsp_definitions)
end, { desc = "[G]oto [D]efinition" })

map("n", "gi", function()
    pcall(vim.lsp.buf.declaration)
end, { desc = "[G]oto [D]eclaration" })

map("n", "gW", function()
    pcall(require("telescope.builtin").lsp_dynamic_workspace_symbols)
end, { desc = "Open Workspace Symbols" })

map("n", "grt", function()
    pcall(require("telescope.builtin").lsp_type_definitions)
end, { desc = "[G]oto [T]ype Definition" })

--
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")
map("n", "<leader>sk", ":Telescope keymaps<cr>", { desc = "Search keymaps" })
map("n", "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "Find Project" })

map("n", "<leader>ff", ":FzfLua files<cr>", { desc = "fzf find files" })
