require("mason-tool-installer").setup({
    ensure_installed = {
        "lua-language-server",
        "unocss",
        "html",
        "bashls",
        "cssls",
        "css_variables",
        "clangd",
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
        "yaml-language-server",
    },
})

local servers = {
    "unocss",
    "bashls",
    "basedpyright",
    "html",
    "clangd",
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

vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=never",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
})

vim.lsp.config("yamlls", {
    filetypes = { "yaml", "yml" },
    settings = {
        yaml = {
            schemas = {
                -- GitHub Actions
                -- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                -- Kubernetes
                -- ["https://json.schemastore.org/kubernetes.json"] = "k8s/*.yaml",
                -- Docker Compose
                ["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.yml",
                -- Azure DevOps Pipelines
                ["https://json.schemastore.org/azure-pipelines.json"] = "*pipeline*.yml",
            },
            validate = true,
            hover = true,
            completion = true,
            format = { enable = true },
        },
    },
})
for _, lsp in ipairs(servers) do
    vim.lsp.enable(lsp)
end

