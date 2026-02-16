return {
    "stevearc/overseer.nvim",

    opts = {
        strategy = "terminal",
        auto_scroll = true,
        auto_focus = false,
        close_on_exit = false,

        task_list = {
            direction = "right",
            min_width = 40,
            max_width = 60,
            default_detail = 1,
        },

        templates = { "builtin" },
    },

    config = function(_, opts)
        local overseer = require("overseer")
        overseer.setup(opts)

        -- Now register custom templates
        -- require("tasks.java")
        require("tasks.python")
        require("tasks.esphome")
        -- require("tasks.web")
        -- require("tasks.devops")
    end,

    keys = {
        { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run task" },
        { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle task list" },
        { "<leader>oo", "<cmd>OverseerOpen<cr>", desc = "Open task list" },
        { "<localleader>rr", "<cmd>OverseerRestartLast<cr>", desc = "Restart last" },
    },
}
