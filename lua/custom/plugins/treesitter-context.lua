-- Treesitter Context: Shows the context of the current function/class at the top
-- Helpful for long functions - keeps track of where you are in the code

return {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    enable = true,
    max_lines = 3, -- How many lines the context window should show
    min_window_height = 0, -- Minimum editor window height to enable context
    line_numbers = true,
    multiline_threshold = 1, -- Maximum number of lines to show for a single context
    trim_scope = 'outer', -- Which context lines to discard if max_lines is exceeded
    mode = 'cursor', -- Line used to calculate context ('cursor' or 'topline')
    separator = nil, -- Separator between context and content. Set to '-' for a line
    zindex = 20, -- Z-index of the context window
    on_attach = nil, -- Callback when attaching to a buffer
    patterns = {
      -- Match patterns for different languages
      default = {
        'class',
        'function',
        'method',
        'for',
        'while',
        'if',
        'switch',
        'case',
        'interface',
        'struct',
        'enum',
      },
      rust = {
        'impl_item',
        'struct',
        'enum',
      },
      typescript = {
        'class_declaration',
        'abstract_class_declaration',
        'else_clause',
      },
    },
  },
  keys = {
    {
      '<leader>tc',
      function()
        require('treesitter-context').toggle()
      end,
      desc = 'Toggle Treesitter Context',
    },
  },
}
