-- Trouble.nvim: A better diagnostics, references, telescope results, quickfix, and location list
-- Provides a beautiful UI for viewing and managing diagnostics

return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    auto_close = true, -- Auto close when there are no items
    auto_open = false, -- Auto open when there are items
    auto_preview = true, -- Automatically preview the location of the diagnostic
    auto_refresh = true, -- Auto refresh when diagnostics change
    focus = true, -- Focus the window when opened
    restore = true, -- Restore previous window configuration on close
    follow = true, -- Follow current diagnostic
    indent_guides = true, -- Show indent guides
    max_items = 200, -- Maximum number of items to show
    multiline = true, -- Render multi-line messages
    pinned = false, -- Pin the trouble window
    warn_no_results = true, -- Show warning when there are no results
    open_no_results = false, -- Open window even when there are no results
    icons = {
      indent = {
        middle = '├╴',
        last = '└╴',
        top = '│ ',
        ws = '  ',
      },
      folder_closed = '',
      folder_open = '',
      kinds = {
        Array = ' ',
        Boolean = '󰨙 ',
        Class = ' ',
        Constant = '󰏿 ',
        Constructor = ' ',
        Enum = ' ',
        EnumMember = ' ',
        Event = ' ',
        Field = ' ',
        File = ' ',
        Function = '󰊕 ',
        Interface = ' ',
        Key = ' ',
        Method = '󰊕 ',
        Module = ' ',
        Namespace = '󰦮 ',
        Null = ' ',
        Number = '󰎠 ',
        Object = ' ',
        Operator = ' ',
        Package = ' ',
        Property = ' ',
        String = ' ',
        Struct = '󰆼 ',
        TypeParameter = ' ',
        Variable = '󰀫 ',
      },
    },
  },
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / References / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
    {
      '[t',
      function()
        require('trouble').prev { skip_groups = true, jump = true }
      end,
      desc = 'Previous Trouble Item',
    },
    {
      ']t',
      function()
        require('trouble').next { skip_groups = true, jump = true }
      end,
      desc = 'Next Trouble Item',
    },
  },
}
