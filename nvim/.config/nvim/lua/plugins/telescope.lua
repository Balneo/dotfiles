return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help tags" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        prompt_prefix = "  ",
      },
    })
  end,
}
