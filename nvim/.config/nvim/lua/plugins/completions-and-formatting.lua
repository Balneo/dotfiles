return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = function()
            return require("configs.conform")
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        version = "*",
        build = (function()
            if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                return
            end
            return "make install_jsregexp"
        end)(),
        dependencies = {
            -- `friendly-snippets` contains a variety of premade snippets.
            --    See the README about individual language/framework/plugin snippets:
            --    https://github.com/rafamadriz/friendly-snippets
            {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
        opts = {},
    },
    { -- Autocompletion
        "saghen/blink.cmp",
        build = "cargo build --release",
        event = "VimEnter",
        version = "1.*",
        dependencies = {
            -- Snippet Engine
            "folke/lazydev.nvim",
        },
        --- @module 'blink.cmp'
        --- @type blink.cmp.Config

        opts = {
            keymap = {
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide", "fallback" },
                ["<CR>"] = { "accept", "fallback" },

                ["<Tab>"] = {
                    function(cmp)
                        return cmp.select_next()
                    end,
                    "snippet_forward",
                    "fallback",
                },
                ["<S-Tab>"] = {
                    function(cmp)
                        return cmp.select_prev()
                    end,
                    "snippet_backward",
                    "fallback",
                },

                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "fallback" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            },

            appearance = {
                nerd_font_variant = "normal",
            },
            snippets = { preset = "luasnip" },
            cmdline = { enabled = true },
            completion = {
                trigger = {
                    show_on_blocked_trigger_characters = { " ", "\n", "\t","}","{",")","(" },
                },
                accept = { auto_brackets = { enabled = true } },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = {
                        direction_priority = {
                            menu_north = { "e", "w", "n", "s" },
                            menu_south = { "w", "e", "s", "n" },
                        },
                    },
                },
                menu = {
                    draw = {
                        columns = {
                            { "label", "label_description", gap = 2 },
                            { "kind_icon", gap = 2 },
                            { "kind", gap = 1 },
                        },
                        components = {
                            label = {
                                text = function(ctx)
                                    local devicons = require("configs.devicons")
                                    local colorful_menu = require("colorful-menu")
                                    -- Replace kind_icon with your custom one
                                    local kind_name = ctx.kind_icon
                                    ctx.kind_icon = devicons[kind_name] or ctx.kind_icon
                                    -- Call colorful-menu to format the rest
                                    return colorful_menu.blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    local colorful_menu = require("colorful-menu")
                                    return colorful_menu.blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
            },

            sources = {
                default = { "lsp", "snippets", "path", "lazydev" },
                providers = {

                    lsp = {
                        min_keyword_length = 0, -- Number of characters to trigger porvider
                        score_offset = 100, -- Boost/penalize the score of the items
                    },
                    path = {
                        min_keyword_length = 0,
                        score_offset = 50,
                    },
                    snippets = {
                        min_keyword_length = 0,
                        score_offset = 90,
                    },
                    buffer = {
                        min_keyword_length = 3,
                        score_offset = 20,
                        max_items = 10,
                    },
                    lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
                },
            },

            fuzzy = { implementation = "prefer_rust" },

            -- Shows a signature help window while you type arguments for a function
            signature = { enabled = false },
        },
    },
}
