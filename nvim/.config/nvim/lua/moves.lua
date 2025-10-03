-- ~/.config/nvim/lua/moves.lua
local M = {}

-- Functions
function M.new_line_below()
    vim.cmd('normal! o')
    vim.cmd('stopinsert')
end

function M.new_line_above()
    vim.cmd('normal! O')
    vim.cmd('stopinsert')
end

-- Keymaps (self-contained)
vim.keymap.set('n', 'o', M.new_line_below, { noremap = true, silent = true })
vim.keymap.set('n', 'O', M.new_line_above, { noremap = true, silent = true })

return M

