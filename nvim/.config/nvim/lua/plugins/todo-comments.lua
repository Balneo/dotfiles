-- Highlight todo, notes, etc in comments
return {
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    main = 'todo-comments',
    keys = {
      {
        '<leader>nt',
        function()
          require('todo-comments').jump_next { keywords = { 'ERROR', 'WARNING', 'TODO', 'BUG', 'FIX' } }
        end,
        desc = 'Next error/warning todo comment',
      },
      {
        '<leader>nT',
        function()
          require('todo-comments').jump_prev { keywords = { 'ERROR', 'WARNING', 'TODO', 'BUG', 'FIX' } }
        end,
        desc = 'Previous error/warning todo comment',
      },
    },
    opts = {
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = ' ', -- icon used for the sign, and in search results
          color = 'error', -- can be a hex color, or a named color (see below)
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = ' ', color = 'info' },
        HACK = { icon = ' ', color = 'warning' },
        WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
        PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
      },
      colors = {
        error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
        warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
        info = { 'DiagnosticInfo', '#2563EB' },
        hint = { 'DiagnosticHint', '#10B981' },
        default = { 'Identifier', '#7C3AED' },
        test = { 'Identifier', '#FF00FF' },
      },
      pattern = [[\b(KEYWORDS):?]],
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
