vim.g.have_nerd_font = true

-- load keymaps first
require('keymaps')
-- load options like row number and stuff
require('options')
-- Lets go with lazy.nvim
require("lazy-bootstrap")
require("lazy-plugins")
-- require('config.lspconfig')
require('config.autocmd')
-- load moves (like o and O)
require('moves')



vim.treesitter.language.register("html", "typescriptreact")
vim.treesitter.language.register('tsx', 'typescriptreact')
