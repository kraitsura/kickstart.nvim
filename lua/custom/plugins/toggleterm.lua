-- ToggleTerm: Better terminal integration for Neovim
-- Provides floating, horizontal, and vertical terminals with easy toggling

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  cmd = 'ToggleTerm',
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return 20
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-`>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float'
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    float_opts = {
      border = 'curved',
      winblend = 0,
      highlights = {
        border = 'Normal',
        background = 'Normal',
      },
    },
    winbar = {
      enabled = false,
    },
  },
  keys = {
    {
      '<leader>tf',
      '<cmd>ToggleTerm direction=float<cr>',
      desc = 'Terminal Float',
    },
    {
      '<leader>th',
      '<cmd>ToggleTerm direction=horizontal<cr>',
      desc = 'Terminal Horizontal',
    },
    {
      '<leader>tv',
      '<cmd>ToggleTerm direction=vertical<cr>',
      desc = 'Terminal Vertical',
    },
    {
      '<C-`>',
      '<cmd>ToggleTerm<cr>',
      desc = 'Toggle Terminal',
      mode = { 'n', 't' },
    },
    {
      '<leader>gg',
      function()
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new {
          cmd = 'lazygit',
          direction = 'float',
          hidden = true,
          float_opts = {
            border = 'curved',
          },
          on_open = function(term)
            vim.cmd 'startinsert!'
            vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
          end,
        }
        lazygit:toggle()
      end,
      desc = 'LazyGit',
    },
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    -- Terminal mode keymaps for easier navigation
    function _G.set_terminal_keymaps()
      local opts_term = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts_term)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts_term)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts_term)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts_term)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts_term)
    end

    vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

    -- Predefined terminal functions
    local Terminal = require('toggleterm.terminal').Terminal

    -- Python REPL
    local python = Terminal:new {
      cmd = 'python3',
      direction = 'float',
      hidden = true,
    }

    function _PYTHON_TOGGLE()
      python:toggle()
    end

    vim.keymap.set('n', '<leader>tp', '<cmd>lua _PYTHON_TOGGLE()<CR>', { desc = 'Python REPL', noremap = true, silent = true })

    -- Node REPL
    local node = Terminal:new {
      cmd = 'node',
      direction = 'float',
      hidden = true,
    }

    function _NODE_TOGGLE()
      node:toggle()
    end

    vim.keymap.set('n', '<leader>tn', '<cmd>lua _NODE_TOGGLE()<CR>', { desc = 'Node REPL', noremap = true, silent = true })
  end,
}
