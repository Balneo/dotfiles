return {
    {
        url = "https://codeberg.org/andyg/leap.nvim",
        event = "VeryLazy",
        dependencies = {
            "tpope/vim-repeat",
        },
        config = function()
            require("leap")
        end,
    },
    {

        "echasnovski/mini.nvim",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.surround").setup()
            require("mini.ai").setup()
            require("mini.pairs").setup()
            require("mini.operators").setup({
                exchange = {
                    prefix = "gX",

                    reindent_linewise = true,
                },
            })
            require("mini.bracketed").setup()
            require("mini.extra").setup()
            require("mini.clue").setup()
            require("mini.indentscope").setup()
        end,
    },
    {
        "sphamba/smear-cursor.nvim",
        lazy = false,
        opts = {
            -- hide_target_hack = true,
            cursor_color = "none",
        },
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    -- Defaults
                    enable_close = true, -- Auto close tags
                    enable_rename = true, -- Auto rename pairs of tags
                    enable_close_on_slash = false, -- Auto close on trailing </
                },
                -- Also override individual filetype configs, these take priority.
                -- Empty by default, useful if one of the "opts" global settings
                -- doesn't work well in a specific filetype
                per_filetype = {
                    ["html"] = {
                        enable_close = false,
                    },
                },
            })
        end,
    },
}
-- vim: ts=2 sts=2 sw=2 et
