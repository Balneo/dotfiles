return {
  {
    'olrtg/nvim-emmet',
    ft = { 'html', 'htmlangular',"typescriptreact","javascriptreact" },
    config = function()
      vim.keymap.set({ 'n', 'v' }, '<C-y>', require('nvim-emmet').wrap_with_abbreviation)
    end,
  },
  {
    'brenoprata10/nvim-highlight-colors',
    enabled = true,
    event = 'VeryLazy',
    opts = {
      render = 'virtual', ---@usage 'background'|'foreground'|'virtual'
      virtual_symbol = '󱓻',
    },
    config = true,
  },
}
