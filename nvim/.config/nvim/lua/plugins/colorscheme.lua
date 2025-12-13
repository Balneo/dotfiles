return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("tokyonight").setup({
                styles = {
                    comments = { italic = false }, -- Disable italics in comments
                },
            })
        end,
    },
    {
        "Skardyy/makurai-nvim",
        lazy = false,
        config = function()
            require("makurai").setup({
                transparent = false, -- removes the bg color
            })
        end,
    },
    {
      "EdenEast/nightfox.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        require("nightfox").setup({
          options = {
            transparent = true,
            styles = {
              comments = "italic",
              keywords = "bold",
              functions = "italic,bold",
              types = "italic",
            },
          },
        })
        -- 🌈 Set your default theme here
        vim.cmd.colorscheme("carbonfox")
      end,
    },
    {
        "rktjmp/lush.nvim",
    },
    { "catppuccin/nvim", lazy = false, name = "catppuccin", priority = 1000 },
    {
        "neanias/everforest-nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "Everblush/everblush.nvim",
        lazy = false,
        priority = 1000,
    },
}
-- vim: ts=2 sts=2 sw=2 et
