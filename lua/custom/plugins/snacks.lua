-- Snacks.nvim: Collection of QoL plugins for Neovim
-- Top trending plugin of 2025 - provides multiple enhancements in one package

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    -- Performance optimization for large files
    bigfile = { enabled = true },
    -- Dashboard (can coexist with alpha-nvim)
    dashboard = { enabled = false }, -- Set to true to replace alpha-nvim
    -- Better indent guides
    indent = {
      enabled = true,
      animate = {
        enabled = false, -- Disable animation for better performance
      },
    },
    -- Enhanced vim.ui.input
    input = { enabled = true },
    -- Better notifications (integrates with noice.nvim if present)
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    -- Fast file operations
    quickfile = { enabled = true },
    -- Smooth scrolling
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 15, total = 150 },
      },
    },
    -- Better status column
    statuscolumn = {
      enabled = true,
      left = { 'mark', 'sign' },
      right = { 'fold', 'git' },
      folds = {
        open = true,
        git_hl = true,
      },
      git = {
        patterns = { 'GitSign', 'MiniDiffSign' },
      },
    },
    -- Document highlights (like LSP highlight references)
    words = { enabled = true },
    -- Dim inactive windows
    dim = { enabled = false }, -- Can enable if you want inactive windows dimmed
  },
  keys = {
    {
      '<leader>n',
      function()
        require('snacks').notifier.show_history()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>un',
      function()
        require('snacks').notifier.hide()
      end,
      desc = 'Dismiss Notifications',
    },
  },
}
