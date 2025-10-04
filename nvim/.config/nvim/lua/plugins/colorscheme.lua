return {
  -- 🦊 Nightfox
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false,
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

  -- 🌃 Tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 999,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
        terminal_colors = true,
      })
      -- you could also make this the default instead by moving the line here
      -- vim.cmd.colorscheme("tokyonight")
    end,
  },
}
