return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright" },
        automatic_installation = true,
      })

      local lspconfig = vim.lsp.config  -- Corrected: Use vim.lsp.config
      lspconfig.pyright.setup({})
    end,
  },
}
--
-- return {
--   -- LSP core
--   {
--     "neovim/nvim-lspconfig",
--     event = { "BufReadPre", "BufNewFile" },
--     dependencies = {
--       "williamboman/mason.nvim",
--       "williamboman/mason-lspconfig.nvim",
--     },
--     config = function()
--       -- Setup mason
--       require("mason").setup()
-- 
--       -- Setup mason-lspconfig
--       require("mason-lspconfig").setup({
--         ensure_installed = { "pyright" }, -- auto-install Python LSP
--         automatic_installation = true,
--       })
-- 
--       -- Setup LSP servers
--       local lspconfig = require("lspconfig")
--       lspconfig.pyright.setup({})
--     end,
--   },
-- }
