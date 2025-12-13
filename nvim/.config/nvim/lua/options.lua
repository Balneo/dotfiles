local opt = vim.opt
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"
vim.o.tabstop = 4 -- Number of spaces that a <Tab> counts for
vim.o.shiftwidth = 4 -- Number of spaces to use for auto-indent
vim.o.expandtab = true
vim.o.winborder = "rounded"
opt.hlsearch = true
opt.incsearch = true
-- Don't show the mode, since it's already in the status line
vim.o.showmode = true
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.termguicolors = true
opt.swapfile = false
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 20
vim.o.confirm = true
vim.o.tabline = ""
vim.o.showtabline = 0

-- vim: ts=2 sts=2 sw=2 et
