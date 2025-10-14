-- lua/plugins/todo-comments.lua
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = true, -- show icons in the sign column
    keywords = {
      TODO = { icon = " ", color = "info" },
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG" } },
      NOTE = { icon = " ", color = "hint" },
    },
    highlight = {
      before = "", -- don't highlight the keyword prefix
      keyword = "wide_bg",
      after = "fg",
    },
  },
  config = function(_, opts)
    require("todo-comments").setup(opts)
  end,
}
