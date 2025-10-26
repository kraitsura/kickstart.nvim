-- Noice.nvim: Modern UI replacement for messages, cmdline, and popupmenu
-- Completely replaces the default Neovim UI with a more modern experience

return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  opts = {
    lsp = {
      -- Override markdown rendering so that cmp and other plugins use Treesitter
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
      -- Customize LSP hover and signature help
      hover = {
        enabled = true,
        silent = false,
      },
      signature = {
        enabled = true,
        auto_open = {
          enabled = true,
          trigger = true,
          luasnip = true,
          throttle = 50,
        },
      },
    },
    -- Presets for common configurations
    presets = {
      bottom_search = true, -- Use a classic bottom cmdline for search
      command_palette = true, -- Position the cmdline and popupmenu together
      long_message_to_split = true, -- Long messages will be sent to a split
      inc_rename = false, -- Enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- Add a border to hover docs and signature help
    },
    -- Routes for filtering messages
    routes = {
      {
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'written',
        },
        opts = { skip = true },
      },
      -- Route warnings and errors to notify
      {
        filter = {
          event = 'msg_show',
          min_height = 10,
        },
        view = 'split',
      },
    },
    -- Command line configuration
    cmdline = {
      enabled = true,
      view = 'cmdline_popup',
      format = {
        cmdline = { icon = '>' },
        search_down = { icon = '🔍⌄' },
        search_up = { icon = '🔍⌃' },
        filter = { icon = '$' },
        lua = { icon = '☾' },
        help = { icon = '?' },
      },
    },
    -- Messages configuration
    messages = {
      enabled = true,
      view = 'notify',
      view_error = 'notify',
      view_warn = 'notify',
      view_history = 'messages',
      view_search = 'virtualtext',
    },
    -- Popup menu configuration
    popupmenu = {
      enabled = true,
      backend = 'nui',
    },
    -- Notification configuration
    notify = {
      enabled = true,
      view = 'notify',
    },
  },
  keys = {
    {
      '<leader>sn',
      function()
        require('noice').cmd 'history'
      end,
      desc = 'Noice Message History',
    },
    {
      '<leader>sl',
      function()
        require('noice').cmd 'last'
      end,
      desc = 'Noice Last Message',
    },
    {
      '<leader>se',
      function()
        require('noice').cmd 'errors'
      end,
      desc = 'Noice Errors',
    },
  },
}
