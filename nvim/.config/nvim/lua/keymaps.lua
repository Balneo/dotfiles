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
