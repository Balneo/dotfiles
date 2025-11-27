require("mason-tool-installer").setup({
    ensure_installed = {
        "lua-language-server",
        "unocss",
        "html",
        "bashls",
        "cssls",
        "css_variables",
        "dockerls",
        "docker_compose_language_service",
        "cssmodules_ls",
        "jsonls",
        "debugpy",
        "basedpyright",
        "ruff",
        "tailwindcss",
        "lua_ls",
        "html-lsp",
        "emmet-language-server",
        "typescript-language-server",
        "stylua",
        "marksman",
        "markdownlint",
    },
})

local servers = {
    "unocss",
    "bashls",
    "basedpyright",
    "html",
    "cssls",
    "css_variables",
    "dockerls",
    "docker_compose_language_service",
    "cssmodules_ls",
    "jsonls",
    "tailwindcss",
    "lua_ls",
    "marksman",
    "emmet_language_server",
    "ts_ls",
}
vim.lsp.config("marksman", {
    filetypes = { "md", "markdown", "mdx", "markdown.mdx" },
})

vim.lsp.config("html", {
    filetypes = { "typescriptreact", "javascriptreact", "html", "htmlangular" },
})

for _, lsp in ipairs(servers) do
    vim.lsp.enable(lsp)
end

