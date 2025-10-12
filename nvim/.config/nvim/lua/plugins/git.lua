return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "▔" },
        changedelete = { text = "▎" },
      },
      current_line_blame = true, -- <== like GitLens
      current_line_blame_opts = {
        delay = 500,
        virt_text_pos = "eol",
        ignore_whitespace = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> • <summary>",
    },
  },
}
