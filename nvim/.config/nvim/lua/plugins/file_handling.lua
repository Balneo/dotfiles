---@type LazySpec
return {
    {
        "mikavilpas/yazi.nvim",
        version = "*", -- use the latest stable version
        event = "VeryLazy",
        dependencies = {
            { "nvim-lua/plenary.nvim", lazy = true },
        },
        keys = {
            {
                "<C-n>",
                mode = { "n", "v" },
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                "<M-n>",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory",
            },
            {
                "<c-up>",
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        ---@type YaziConfig | {}
        opts = {
            open_for_directories = false,
            keymaps = {
                show_help = "<f2>",
            },
        },
        init = function()
            vim.g.loaded_netrwPlugin = 1
        end,
    },
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = {},
        version = "^1.0.0", -- optional: only update when a new 1.x version is released
    },
    {
        "MagicDuck/grug-far.nvim",
        opts = {},
    },
    -- =====================
    -- Neo-tree plugin
    -- =====================
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- optional, for icons
            "MunifTanjim/nui.nvim",
        },
        keys = {
            {
                "<leader>ee",
                "<cmd>Neotree toggle<cr>",
                desc = "Toggle file explorer (Neo-tree)",
            },
            {
                "<leader>ef",
                "<cmd>Neotree focus<cr>",
                desc = "Focus file explorer",
            },
        },
        opts = {
            close_if_last_window = true,
            enable_git_status = true,
            enable_diagnostics = true,
            default_component_configs = {
                indent = { padding = 0 },
                icon = { folder_closed = "", folder_open = "" },
                git_status = { symbols = { added = "✚", modified = "", removed = "✖" } },
            },
            filesystem = {
                follow_current_file = true,
                filtered_items = {
                    hide_dotfiles = false,
                    hide_by_name = { "node_modules" },
                },
            },
        },
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
        end,
    },
}
