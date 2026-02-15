-- lazydocker.nvim
return {
  "mgierada/lazydocker.nvim",
  dependencies = { "akinsho/toggleterm.nvim" },
  config = function()
    require("lazydocker").setup({
	    border = "curved", -- valid options are "single" | "double" | "shadow" | "curved"
	    width = 0.9, -- width of the floating window (0-1 for percentage, >1 for absolute columns)
	    height = 0.9, -- height of the floating window (0-1 for percentage, >1 for absolute rows)
        opacity = 0.1,
    })
  end,
  event = "BufRead",
  keys = {
    {
      "<leader>lc",
      function()
        require("lazydocker").open()
      end,
      desc = "Open Lazydocker floating window",
    },
  },
}

