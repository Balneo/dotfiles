vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.have_nerd_font = true

require("options")
require("lazy-bootstrap")
require("lazy-plugins")
require("mappings")
require("configs.lspconfig")
require("configs.colorscheme")

vim.filetype.add({
    extension = {
        ["http"] = "http",
    },
})

vim.treesitter.language.register("html", "typescriptreact")
vim.treesitter.language.register('tsx', 'typescriptreact')
