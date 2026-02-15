---@type LazySpec
return {
    {
        "stevearc/overseer.nvim",
        opts = {
            templates = { "builtin", "user" },
        },
        keys = {
            { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Overseer run task" },
            { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Overseer task list" },
            { "<leader>ol", "<cmd>OverseerLoadBundle<cr>", desc = "Overseer load bundle" },
        },
        config = function()
              -- auto-load project bundle whenever you change directories
              vim.api.nvim_create_autocmd("DirChanged", {
                callback = function()
                  pcall(vim.cmd, "OverseerLoadBundle")
                end,
              })
        end,
    },
}

