return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("noice").setup({
                notify = { enabled = false },
                lsp = {
                    on_confirm = function()
                        -- Close the Noice notification after confirmation
                        require("noice").dismiss()
                    end,
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            })
        end,
    },
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
            local fortune = require("fortune")
            require("dashboard").setup({
                theme = "hyper",
                config = {
                    header = {},
                    week_header = {
                        enable = true,
                        append = fortune.get_fortune(100),
                    },
                    footer = { "" },
                    shortcut = {
                        { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
                        {
                            icon = " ",
                            icon_hl = "@variable",
                            desc = "Files",
                            group = "Label",
                            action = "Telescope find_files",
                            key = "f",
                        },
                        {
                            desc = " Apps",
                            group = "DiagnosticHint",
                            action = "Telescope app",
                            key = "a",
                        },
                        {
                            desc = " dotfiles",
                            group = "Number",
                            action = "Telescope dotfiles",
                            key = "d",
                        },
                    },
                },
            })
        end,
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
    },
    {
        "dgagn/diagflow.nvim",
        event = "LspAttach",
        opts = {
            show_borders = true,
            padding_right = 10,
        },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
}
