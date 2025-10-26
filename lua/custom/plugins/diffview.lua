-- Diffview.nvim: Single tabpage interface for cycling through diffs
-- Provides a better git diff and file history viewing experience

return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
  opts = {
    diff_binaries = false, -- Show diffs for binaries
    enhanced_diff_hl = true, -- Use nvim's builtin diff highlighting
    use_icons = true, -- Requires nvim-web-devicons
    show_help_hints = true, -- Show hints for available keymaps
    watch_index = true, -- Update views when index changes
    icons = {
      folder_closed = '',
      folder_open = '',
    },
    signs = {
      fold_closed = '',
      fold_open = '',
      done = '✓',
    },
    view = {
      default = {
        layout = 'diff2_horizontal',
        winbar_info = false,
      },
      merge_tool = {
        layout = 'diff3_horizontal',
        disable_diagnostics = true,
        winbar_info = true,
      },
      file_history = {
        layout = 'diff2_horizontal',
        winbar_info = false,
      },
    },
    file_panel = {
      listing_style = 'tree', -- 'list' or 'tree'
      tree_options = {
        flatten_dirs = true,
        folder_statuses = 'only_folded',
      },
      win_config = {
        position = 'left',
        width = 35,
        win_opts = {},
      },
    },
    file_history_panel = {
      log_options = {
        git = {
          single_file = {
            diff_merges = 'combined',
          },
          multi_file = {
            diff_merges = 'first-parent',
          },
        },
      },
      win_config = {
        position = 'bottom',
        height = 16,
        win_opts = {},
      },
    },
    commit_log_panel = {
      win_config = {
        win_opts = {},
      },
    },
    default_args = {
      DiffviewOpen = {},
      DiffviewFileHistory = {},
    },
    hooks = {},
    keymaps = {
      disable_defaults = false,
      -- Keymaps are loaded when diffview is opened
      -- Default keymaps work well, no custom overrides needed
    },
  },
  keys = {
    {
      '<leader>gd',
      '<cmd>DiffviewOpen<cr>',
      desc = 'Git Diff View',
    },
    {
      '<leader>gc',
      '<cmd>DiffviewClose<cr>',
      desc = 'Close Diff View',
    },
    {
      '<leader>gh',
      '<cmd>DiffviewFileHistory %<cr>',
      desc = 'File History',
    },
    {
      '<leader>gH',
      '<cmd>DiffviewFileHistory<cr>',
      desc = 'Repo History',
    },
  },
}
