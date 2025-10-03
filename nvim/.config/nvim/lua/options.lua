-- ~/.config/nvim/lua/options.lua
local o = vim.opt

-- line numbers
o.number = true
o.relativenumber = true

-- appearance
o.wrap = false
o.showmode = false   -- we usually don't need --INSERT--
o.cursorline = true

-- tabs & indentation
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.smartindent = true

-- searching
o.ignorecase = true
o.smartcase = true
o.incsearch = true

-- other quality of life
o.clipboard = 'unnamedplus'  -- use system clipboard
o.mouse = 'a'
o.signcolumn = 'yes'

-- Jump to last known cursor position when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
