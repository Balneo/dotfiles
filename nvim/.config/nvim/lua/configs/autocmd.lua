vim.api.nvim_create_autocmd("FileType", {
    pattern = "http",
    callback = function()
        vim.keymap.set({ "n", "v" }, "<CR>", function()
            require("kulala").run()
        end, { desc = "Send request (Kulala)", buffer = true })
    end,
})

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

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.cmd([[
		highlight! link Pmenu Normal
		highlight! link PmenuSel Visual
		highlight! link PmenuThumb Normal
		highlight! link NormalFloat Normal
		highlight! link FloatBorder Normal
		highlight! link CmpItemKindFunction Function
		highlight! link CmpItemKindVariable Identifier
		highlight! link CmpItemKindKeyword Keyword
		]])
    end,
})
