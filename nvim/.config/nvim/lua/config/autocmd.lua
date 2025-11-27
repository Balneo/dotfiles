vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf

        vim.keymap.set("n", "<leader>ih", function()
            local enabled = vim.lsp.inlay_hint.is_enabled()
            vim.lsp.inlay_hint.enable(not enabled)
        end, { buffer = bufnr, desc = "Toggle Inlay Hints" })

        vim.keymap.set({ "n", "v" }, "<leader>ca", function()
            require("actions-preview").code_actions()
        end, { buffer = bufnr, desc = "Code Actions" })
    end,
})

