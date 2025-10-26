-- Performance optimization plugin for handling large files
-- Automatically disables heavy features when editing large files or executing macros

return {
  'pteroctopus/faster.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    -- Disable features for files larger than 1MB
    behaviours = {
      bigfile = {
        filesize = 1, -- 1MB
        pattern = '*', -- All file types
        features_disabled = {
          'illuminate', -- Disable word highlighting
          'matchparen', -- Disable matching parentheses
          'lsp', -- Disable LSP
          'treesitter', -- Disable treesitter
          'syntax', -- Disable syntax highlighting
          'vimopts', -- Disable various vim options
          'filetype', -- Disable filetype detection
        },
      },
      -- Disable features when executing macros for better performance
      fastmacro = {
        features_disabled = {
          'illuminate',
          'matchparen',
        },
      },
    },
  },
}
