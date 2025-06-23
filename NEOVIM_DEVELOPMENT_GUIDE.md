# Neovim Development Guide: Keybinds & Workflow

## Essential Movement & Navigation

### Basic Movement
- `h` `j` `k` `l` - Left, Down, Up, Right
- `w` `e` `b` - Word forward, End of word, Word backward
- `0` `^` `$` - Start of line, First non-blank, End of line
- `gg` `G` - Top of file, Bottom of file
- `{` `}` - Previous/Next paragraph
- `Ctrl-u` `Ctrl-d` - Half page up/down
- `Ctrl-f` `Ctrl-b` - Full page forward/backward

### Advanced Navigation
- `f{char}` `F{char}` - Find character forward/backward
- `t{char}` `T{char}` - Till character forward/backward
- `;` `,` - Repeat last f/F/t/T forward/backward
- `*` `#` - Search word under cursor forward/backward
- `%` - Jump to matching bracket/parenthesis
- `gd` - Go to definition
- `gD` - Go to global definition
- `gi` - Go to last insert position

## File & Buffer Management

### File Operations
- `:e filename` - Edit file
- `:w` - Save file
- `:wa` - Save all files
- `:q` - Quit
- `:wq` - Save and quit
- `:q!` - Quit without saving

### Buffer Navigation
- `:bnext` `:bn` - Next buffer
- `:bprev` `:bp` - Previous buffer
- `:bd` - Delete buffer
- `:ls` - List buffers
- `Ctrl-^` - Switch to alternate buffer

### Window Management
- `Ctrl-w s` - Split horizontal
- `Ctrl-w v` - Split vertical
- `Ctrl-w c` - Close window
- `Ctrl-w o` - Close other windows
- `Ctrl-w h/j/k/l` - Navigate windows
- `Ctrl-w H/J/K/L` - Move windows
- `Ctrl-w =` - Equalize window sizes
- `Ctrl-w +/-` - Resize window height
- `Ctrl-w >/<` - Resize window width

### Tabs
- `:tabnew` - New tab
- `:tabc` - Close tab
- `gt` `gT` - Next/Previous tab
- `{n}gt` - Go to tab n

## Text Editing & Manipulation

### Insert Mode
- `i` `a` - Insert before/after cursor
- `I` `A` - Insert at beginning/end of line
- `o` `O` - Open line below/above
- `s` `S` - Substitute character/line
- `c{motion}` - Change text object
- `C` - Change to end of line

### Delete & Copy
- `x` `X` - Delete character forward/backward
- `dd` - Delete line
- `d{motion}` - Delete with motion
- `D` - Delete to end of line
- `yy` - Yank (copy) line
- `y{motion}` - Yank with motion
- `Y` - Yank to end of line
- `p` `P` - Paste after/before cursor

### Visual Mode
- `v` - Visual character mode
- `V` - Visual line mode
- `Ctrl-v` - Visual block mode
- `gv` - Reselect last visual selection
- `>` `<` - Indent/Unindent selection
- `=` - Auto-indent selection

### Text Objects
- `iw` `aw` - Inside/Around word
- `is` `as` - Inside/Around sentence
- `ip` `ap` - Inside/Around paragraph
- `i"` `a"` - Inside/Around quotes
- `i(` `a(` - Inside/Around parentheses
- `i{` `a{` - Inside/Around braces
- `it` `at` - Inside/Around tags

## Search & Replace

### Basic Search
- `/pattern` - Search forward
- `?pattern` - Search backward
- `n` `N` - Next/Previous match
- `:noh` - Clear search highlighting

### Advanced Search & Replace
- `:s/old/new/` - Replace first occurrence in line
- `:s/old/new/g` - Replace all occurrences in line
- `:%s/old/new/g` - Replace all occurrences in file
- `:%s/old/new/gc` - Replace with confirmation
- `:g/pattern/d` - Delete lines matching pattern
- `:v/pattern/d` - Delete lines not matching pattern

## Code Development Features

### Code Navigation
- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Go to references
- `K` - Show documentation
- `[d` `]d` - Previous/Next diagnostic
- `[c` `]c` - Previous/Next git change

### Code Formatting
- `=` - Auto-indent
- `==` - Auto-indent current line
- `gg=G` - Auto-indent entire file
- `gq` - Format text (with motion)

### Folding
- `za` - Toggle fold
- `zo` `zc` - Open/Close fold
- `zR` `zM` - Open/Close all folds
- `zf{motion}` - Create fold

### Marks & Jumps
- `m{letter}` - Set mark
- `'{letter}` - Jump to mark
- `''` - Jump to previous position
- `Ctrl-o` `Ctrl-i` - Jump backward/forward
- `:jumps` - Show jump list

## Plugin-Specific Workflows

### File Explorer (Neo-tree/NvimTree)
- `\` or `<leader>e` - Toggle file explorer
- `a` - Add file/folder
- `d` - Delete
- `r` - Rename
- `y` - Copy
- `x` - Cut
- `p` - Paste

### Fuzzy Finder (Telescope)
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Help tags
- `<leader>fo` - Old files
- `Ctrl-q` - Send to quickfix list

### Git Integration (Gitsigns/Fugitive)
- `]c` `[c` - Next/Previous hunk
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hp` - Preview hunk
- `<leader>hb` - Blame line
- `:Git` - Git status
- `:Gdiff` - Git diff

### LSP (Language Server Protocol)
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>rn` - Rename
- `<leader>ca` - Code action
- `[d` `]d` - Previous/Next diagnostic

### Completion (nvim-cmp)
- `Ctrl-n` `Ctrl-p` - Next/Previous suggestion
- `Ctrl-y` - Accept completion
- `Ctrl-e` - Close completion menu
- `Ctrl-d` `Ctrl-u` - Scroll docs down/up

## Advanced Workflows

### Macros
- `q{letter}` - Start recording macro
- `q` - Stop recording
- `@{letter}` - Execute macro
- `@@` - Repeat last macro

### Command Line
- `:` - Enter command mode
- `Ctrl-f` - Open command history
- `Ctrl-c` - Cancel command
- `Tab` - Command completion

### Registers
- `"{register}` - Use specific register
- `"0` - Yank register (last yanked text)
- `"+` - System clipboard
- `"*` - Primary selection
- `:reg` - Show all registers

## Development Best Practices

### Efficient Editing
1. Use text objects for precise selections
2. Combine operators with motions (e.g., `d2w`, `c$`)
3. Use visual mode for complex selections
4. Master the dot command (`.`) for repetition

### Code Navigation
1. Use tags for jumping between definitions
2. Leverage LSP features for smart navigation
3. Use marks for bookmarking important locations
4. Utilize the jump list for navigation history

### Workflow Optimization
1. Configure leader key for custom mappings
2. Use abbreviations for common typos
3. Create custom commands for repetitive tasks
4. Organize plugins for specific development needs

### Session Management
- `:mksession` - Save session
- `:source Session.vim` - Load session
- Use session plugins for automatic management

## Debugging & Troubleshooting

### Health Check
- `:checkhealth` - Check Neovim health
- `:checkhealth {plugin}` - Check specific plugin

### Logs & Debugging
- `:messages` - Show messages
- `:verbose` - Verbose command output
- `$NVIM_LOG_FILE` - Log file location

### Performance
- `:profile start profile.log` - Start profiling
- `:profile func *` - Profile all functions
- `:profile file *` - Profile all files

## Configuration Tips

### Key Mapping Principles
1. Use logical groupings with leader key
2. Keep frequently used commands easily accessible
3. Maintain consistency across similar operations
4. Document custom mappings

### Plugin Management
1. Use lazy loading for better startup time
2. Configure plugins systematically
3. Regular cleanup of unused plugins
4. Test configurations incrementally

This guide covers the essential keybinds and workflows for effective Neovim development. Practice these commands regularly to build muscle memory and improve your coding efficiency.