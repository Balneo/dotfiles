-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Increment number
vim.keymap.set("n", "g+", "<C-a>", { desc = "Increment number" })

-- Decrement number
vim.keymap.set("n", "g-", "<C-x>", { desc = "Decrement number" })
