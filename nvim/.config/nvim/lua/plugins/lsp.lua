return {
  {
    -- Core LSP configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Mason: handles external tool installation
      { "williamboman/mason.nvim", config = true },
      -- Bridges mason with lspconfig
      "williamboman/mason-lspconfig.nvim",
      -- Integrates LSP with nvim-cmp for autocompletion
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Load required modules
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      -- Capabilities describe what the editor can do; we extend with cmp features
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 1️⃣ Mason setup: manages language servers
      mason.setup()

      -- 2️⃣ Mason-LSP setup: ensures servers are installed + configured
      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",   -- Lua
          "pyright",  -- Python
          -- add others: "tsserver", "clangd", "rust_analyzer", etc.
        },
        handlers = {
          -- Default handler for all servers
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- Optional: custom config per server
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" }, -- Don't warn about global 'vim'
                  },
                  workspace = {
                    checkThirdParty = false,
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
