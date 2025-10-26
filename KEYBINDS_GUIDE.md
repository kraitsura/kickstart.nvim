# Complete Neovim Setup Guide

A comprehensive guide to using your customized Neovim setup with all keybinds, plugins, tmux, and smug workflows.

---

## 🎉 2025 Enhancements

Your Neovim setup has been upgraded with modern performance and UX improvements:

### Performance Optimizations
- ✅ **Lua Loader**: Enabled for ~30% faster startup
- ✅ **faster.nvim**: Auto-disables features for large files (>1MB)
- ✅ **Lazy Loading**: All plugins load on-demand

### Modern UI/UX
- ✅ **Snacks.nvim**: Quality-of-life features (smooth scrolling, notifications, indent guides)
- ✅ **Noice.nvim**: Beautiful command line, messages, and popupmenu
- ✅ **Trouble.nvim**: Better diagnostics and quickfix UI

### Enhanced Navigation
- ✅ **Flash.nvim**: Lightning-fast motion (jump anywhere with 2 keystrokes)
- ✅ **Treesitter Context**: Shows current function/class context

### Better Terminal
- ✅ **ToggleTerm**: Floating/horizontal/vertical terminals with LazyGit integration

### Git Workflow
- ✅ **Diffview.nvim**: Professional git diff and file history viewer

### Testing
- ✅ **Neotest**: Integrated test runner with debugging (Python, Go, Rust, JS/TS)

### Session Management
- ✅ **Persistence.nvim**: Auto-save/restore sessions

### New Keybindings
- `s` - Flash jump (quick navigation)
- `Space-xx` - Trouble diagnostics
- `Space-gd` - Git diff view
- `Space-gg` - LazyGit
- `Ctrl-\` - Toggle terminal
- `Space-tr` - Run nearest test
- `Space-qs` - Restore session
- `Space-tt` - Toggle color theme

---

## Table of Contents

1. [Basic Vim Motions](#basic-vim-motions)
2. [Global Settings](#global-settings)
3. [Custom Keybinds](#custom-keybinds)
4. [Plugin-Specific Keybinds](#plugin-specific-keybinds)
5. [LSP Features](#lsp-features)
6. [IDE-Like Setup Guide](#ide-like-setup-guide)
7. [Tmux Configuration & Usage](#tmux-configuration--usage)
8. [Smug Session Manager](#smug-session-manager)
9. [Tips & Tricks](#tips--tricks)

---

## Basic Vim Motions

### Movement (Normal Mode)
```
h, j, k, l          - Left, Down, Up, Right (basic movement)
w                   - Move forward by word
b                   - Move backward by word
e                   - Move to end of word
0                   - Move to start of line
^                   - Move to first non-blank character of line
$                   - Move to end of line
gg                  - Go to first line of file
G                   - Go to last line of file
{number}G           - Go to line number
%                   - Jump to matching bracket/paren

Ctrl-d              - Half page down (centered with zz)
Ctrl-u              - Half page up (centered with zz)
Ctrl-f              - Full page down
Ctrl-b              - Full page up

n                   - Next search result (centered with zzzv)
N                   - Previous search result (centered with zzzv)
*                   - Search word under cursor forward (centered)
#                   - Search word under cursor backward (centered)
```

### Editing
```
i                   - Insert before cursor
I                   - Insert at beginning of line
a                   - Append after cursor
A                   - Append at end of line
o                   - Open new line below
O                   - Open new line above

x                   - Delete character under cursor
dd                  - Delete line
D                   - Delete to end of line
dw                  - Delete word
d{motion}           - Delete with motion (e.g., d$, d0)

yy                  - Yank (copy) line
yw                  - Yank word
y{motion}           - Yank with motion
p                   - Paste after cursor
P                   - Paste before cursor

u                   - Undo
Ctrl-r              - Redo
.                   - Repeat last command
```

### Visual Mode
```
v                   - Visual mode (character-wise)
V                   - Visual line mode
Ctrl-v              - Visual block mode

(in visual mode)
d                   - Delete selection
y                   - Yank selection
c                   - Change selection
>                   - Indent right (stays in visual mode)
<                   - Indent left (stays in visual mode)
J                   - Move selection down
K                   - Move selection up
```

### Search & Replace

#### Single File
```
/pattern            - Search forward for pattern
?pattern            - Search backward for pattern
:s/old/new/         - Replace first occurrence in line
:s/old/new/g        - Replace all occurrences in line
:%s/old/new/g       - Replace all occurrences in file
:%s/old/new/gc      - Replace all with confirmation
```

#### Multi-file Search & Replace (Across Codebase)

**Method 1: Using `:grep` + `:cfdo` (Recommended)**
```vim
:grep "oldText"                        " Search for pattern (uses ripgrep)
:copen                                 " Review results in quickfix list
:cfdo %s/oldText/newText/gc | update   " Replace across all files with confirmation

" Flags:
" g  - Replace all occurrences per line
" c  - Confirm each replacement
" i  - Case insensitive
" e  - Suppress errors if pattern not found
```

**Method 2: Using `:vimgrep` (Pure Vim)**
```vim
:vimgrep /oldText/g **/*.lua          " Search recursively in .lua files
:cfdo %s/oldText/newText/g | update   " Replace across all files
```

**Method 3: Args List Method**
```vim
:args **/*.lua                        " Add files to args list
:argdo %s/oldText/newText/ge | update " Replace across all args

" Good for specific file types or patterns
```

**Method 4: Using Telescope + Quickfix**
```
Space-sg            - Live grep for pattern
<C-q>               - Send results to quickfix list
:cfdo %s/old/new/g | update
```

**Useful Tips:**
```vim
:copen              - Open quickfix list to review matches
:cclose             - Close quickfix list
:cfdo undo          - Undo changes across all files
:wa                 - Write all modified buffers

" Case-insensitive search:
:grep -i "pattern"
:cfdo %s/oldText/newText/gi | update

" Specific file types (with ripgrep):
:grep "pattern" --type=lua
:grep "pattern" --type=python
:grep "pattern" *.{lua,vim}

" Preview before replacing:
:grep "oldText"
:copen                                " Review all matches
:cfdo %s/oldText/newText/gc | update  " Confirm each change
```

**Example Workflow:**
```vim
" 1. Search for pattern
:grep "oldFunctionName"

" 2. Review results
:copen

" 3. Replace across all files
:cfdo %s/oldFunctionName/newFunctionName/g | update

" 4. Verify changes
:copen
:cnext / :cprev  " Navigate through changed files
```

---

## Global Settings

Your setup includes these important settings:

- **Leader Key**: `Space` (both leader and local leader)
- **Line Numbers**: Enabled with relative numbers (toggle based on mode/focus)
- **Mouse**: Enabled for all modes
- **Clipboard**: Synced with system clipboard
- **Case-insensitive Search**: Unless search contains capitals or `\C`
- **Undo History**: Persistent across sessions (saved in `~/.local/share/nvim/undo`)
- **Tab Settings**: 2 spaces, expanded tabs
- **No Swap Files**: Disabled for cleaner workflow
- **Scroll Offset**: 10 lines above/below cursor

---

## Custom Keybinds

### General Navigation & Editing

#### Normal Mode
```
Esc                 - Clear search highlights
Ctrl-s              - Save file
Space-q             - Quit current window
Space-Q             - Force quit all windows without saving

Space-pv            - Exit to file explorer (netrw)
```

#### Buffer Management
```
Shift-h             - Previous buffer
Shift-l             - Next buffer
Space-bd            - Delete current buffer
Space-ba            - Delete all buffers except current
Space-<Space>       - Find existing buffers (Telescope)
```

#### Window Navigation
```
Ctrl-h              - Move to left window
Ctrl-j              - Move to bottom window
Ctrl-k              - Move to top window
Ctrl-l              - Move to right window
```

#### Window Resizing
```
Ctrl-Up             - Decrease window height
Ctrl-Down           - Increase window height
Ctrl-Left           - Decrease window width
Ctrl-Right          - Increase window width
```

#### Visual Mode Editing
```
<                   - Indent left (keeps visual selection)
>                   - Indent right (keeps visual selection)
J                   - Move selected lines down
K                   - Move selected lines up
Alt-j               - Move selected lines down (alternative)
Alt-k               - Move selected lines up (alternative)

Space-p             - Paste without yanking deleted text
```

#### Terminal Mode
```
Esc Esc             - Exit terminal mode
```

### Diagnostic Navigation
```
Space-q             - Open diagnostic quickfix list
```

---

## Plugin-Specific Keybinds

### Telescope (Fuzzy Finder)

Telescope is your primary tool for finding files, searching code, and navigating your project.

```
Space-sf            - Search Files (find files by name)
Space-gf            - Git Files (search git-tracked files)
Space-sg            - Search by Grep (live grep in all files)
Space-sw            - Search Word (grep for word under cursor)
Space-sh            - Search Help (search Neovim help tags)
Space-sk            - Search Keymaps (find all keybindings)
Space-ss            - Search Select Telescope (Telescope pickers)
Space-sd            - Search Diagnostics (project diagnostics)
Space-sr            - Search Resume (resume last search)
Space-s.            - Search Recent files (oldfiles)
Space-sn            - Search Neovim config files
Space-/             - Fuzzy search in current buffer
Space-s/            - Live grep in open files
```

### Neo-tree (File Explorer)

```
\                   - Toggle Neo-tree file explorer
\                   - Close Neo-tree (when focused)
```

**Neo-tree Navigation** (when focused):
- `j/k` or arrow keys to move
- `Enter` to open file/folder
- `a` to add file/folder
- `d` to delete
- `r` to rename
- `y` to copy
- `x` to cut
- `p` to paste
- `?` for help

### Oil (Alternative File Manager)

```
-                   - Open parent directory in Oil
```

Oil provides a buffer-like file editing experience where you can edit the filesystem like text.

### Harpoon (Quick File Navigation)

Harpoon allows you to mark and quickly navigate between frequently used files.

```
Space-hh            - Toggle Harpoon quick menu
Space-ha            - Add current file to Harpoon
Space-hn            - Navigate to next Harpoon file
Space-hp            - Navigate to previous Harpoon file
```

**In Harpoon Menu**:
- Navigate with j/k
- Press Enter to open file
- Press dd to remove file from list

### Git (Gitsigns & Fugitive)

#### Git Hunk Navigation
```
]c                  - Jump to next git change
[c                  - Jump to previous git change
```

#### Git Hunk Actions (Normal Mode)
```
Space-hs            - Git stage hunk
Space-hr            - Git reset hunk
Space-hS            - Git stage entire buffer
Space-hu            - Git undo stage hunk
Space-hR            - Git reset entire buffer
Space-hp            - Git preview hunk
Space-hb            - Git blame line
Space-hd            - Git diff against index
Space-hD            - Git diff against last commit
```

#### Git Hunk Actions (Visual Mode)
```
Space-hs            - Stage selected hunk
Space-hr            - Reset selected hunk
```

#### Git Toggles
```
Space-tb            - Toggle git blame line
Space-tD            - Toggle git show deleted (inline)
```

#### Fugitive
```
:Git                - Open git command interface
:Git status         - Git status
:Git commit         - Git commit
:Git push           - Git push
:Git pull           - Git pull
```

### Mini.nvim Plugins

#### Mini.ai (Text Objects)
Enhanced text objects for editing:
```
va)                 - Visually select around parentheses
vi)                 - Visually select inside parentheses
yinq                - Yank inside next quote
ci'                 - Change inside single quotes
da"                 - Delete around double quotes
```

#### Mini.surround (Surround Operations)
```
saiw)               - Surround add inner word with parentheses
sd'                 - Surround delete single quotes
sr)'                - Surround replace parentheses with quotes
```

Examples:
- `saiw"` on "hello" → `"hello"`
- `sd"` on `"hello"` → `hello`
- `sr"'` on `"hello"` → `'hello'`

### Which-key

Which-key automatically shows available keybindings after a short delay.

- Just press `Space` and wait to see available commands
- Press `?` in any which-key popup for help

### Alpha (Start Screen)

The dashboard appears when you start Neovim without a file:
```
e                   - New file
f                   - Find file (Telescope)
r                   - Recent files
s                   - Open settings
q                   - Quit
```

### Auto-pairs

Automatically closes brackets, quotes, and parentheses:
- Type `(` → automatically adds `)`
- Type `"` → automatically adds closing `"`
- Works with `[]`, `{}`, `''`, `` `` ``, etc.

### Trouble.nvim (Better Diagnostics)

A beautiful diagnostics, references, and quickfix UI:
```
Space-xx            - Toggle diagnostics (Trouble)
Space-xX            - Buffer diagnostics (Trouble)
Space-cs            - Symbols (Trouble)
Space-cl            - LSP definitions/references (Trouble)
Space-xL            - Location list (Trouble)
Space-xQ            - Quickfix list (Trouble)
[t                  - Previous trouble item
]t                  - Next trouble item
```

**In Trouble window**:
- `j/k` - Navigate items
- `<CR>` - Jump to item
- `q` - Close
- `?` - Show help

### Flash.nvim (Enhanced Navigation)

Lightning-fast motion for jumping to any location:
```
s                   - Flash jump (type 2 chars, then select label)
S                   - Flash treesitter (select treesitter nodes)
r (operator)        - Remote flash
R (visual/operator) - Treesitter search
Ctrl-s (cmdline)    - Toggle flash search
```

**Usage**:
1. Press `s`
2. Type 2 characters you want to jump to
3. Labels appear on all matches
4. Type the label to jump

### ToggleTerm (Better Terminal)

Modern terminal integration:
```
Ctrl-\              - Toggle terminal
Space-tf            - Floating terminal
Space-th            - Horizontal terminal
Space-tv            - Vertical terminal
Space-gg            - LazyGit (if installed)
Space-tp            - Python REPL
Space-tn            - Node REPL
```

**In terminal mode**:
- `Esc` - Exit insert mode
- `Ctrl-h/j/k/l` - Navigate to vim windows

### Persistence.nvim (Session Management)

Automatically save and restore sessions:
```
Space-qs            - Restore session for current directory
Space-ql            - Restore last session
Space-qd            - Don't save current session
```

Sessions are automatically saved when you exit Neovim.

### Diffview.nvim (Enhanced Git)

Better git diff and file history:
```
Space-gd            - Open git diff view
Space-gc            - Close diff view
Space-gh            - File history (current file)
Space-gH            - Repository history (all files)
```

**In Diffview**:
- `<Tab>/<S-Tab>` - Next/previous file
- `gf` - Go to file
- `-` - Stage/unstage file
- `S` - Stage all
- `U` - Unstage all
- `R` - Refresh
- `q` - Close

### Neotest (Testing Integration)

Integrated test running and debugging:
```
Space-tr            - Run nearest test
Space-tR            - Run all tests in file
Space-td            - Debug nearest test
Space-ts            - Toggle test summary
Space-to            - Show test output
Space-tO            - Toggle output panel
Space-tS            - Stop running test
Space-tw            - Toggle watch mode
[t                  - Previous failed test
]t                  - Next failed test
```

**In test summary**:
- `j/k` - Navigate tests
- `<CR>` - Run test
- `d` - Debug test
- `o` - View output
- `m` - Mark test
- `R` - Run marked tests

### Treesitter Context

Shows function/class context at top of screen:
```
Space-tc            - Toggle treesitter context
```

Automatically shows the current function, class, or block you're in when scrolling.

### Snacks.nvim (QoL Features)

Collection of quality-of-life improvements:
```
Space-n             - Show notification history
Space-un            - Dismiss all notifications
```

Features:
- Smooth scrolling
- Better notifications
- Enhanced input dialogs
- Improved indent guides
- Performance optimizations for large files

### Noice.nvim (Modern UI)

Modern UI for messages, cmdline, and popupmenu:
```
Space-sn            - Message history
Space-sl            - Last message
Space-se            - Show errors
```

Features:
- Beautiful command line interface
- Better LSP hover and signature help
- Inline virtual text for search
- Long messages sent to split

### DAP (Debug Adapter Protocol)

Debugging keybinds:
```
F5                  - Start/Continue debugging
F1                  - Step into
F2                  - Step over
F3                  - Step out
F7                  - Toggle debug UI

Space-b             - Toggle breakpoint
Space-B             - Set conditional breakpoint
```

### Todo Comments

Highlights TODO, FIXME, NOTE, etc. in comments:
```
:TodoTelescope      - Search all todos in project
```

Recognized keywords: TODO, HACK, WARN, PERF, NOTE, FIX, FIXME

---

## LSP Features

Language Server Protocol provides intelligent code features.

### Code Navigation
```
grd                 - Go to definition
grr                 - Go to references (Telescope)
gri                 - Go to implementation (Telescope)
grt                 - Go to type definition (Telescope)
grD                 - Go to declaration
gO                  - Open document symbols (Telescope)
gW                  - Open workspace symbols (Telescope)
```

### Code Actions
```
grn                 - Rename symbol
gra                 - Code action (normal/visual mode)
K                   - Hover documentation
Space-th            - Toggle inlay hints
```

### Diagnostics
```
Space-q             - Open diagnostic quickfix list
[d                  - Go to previous diagnostic
]d                  - Go to next diagnostic
```

### Formatting
```
Space-f             - Format buffer (Conform.nvim)
```

Auto-formatting is enabled on save for most file types (except C/C++).

**Configured formatters**:
- Lua: stylua
- JavaScript/TypeScript: prettier
- Python: black
- Rust: rustfmt
- Go: goimports

### Autocompletion (Blink.cmp)

While typing in insert mode:
```
Ctrl-space          - Open completion menu / show docs
Ctrl-n / Down       - Next completion item
Ctrl-p / Up         - Previous completion item
Ctrl-y              - Accept completion
Ctrl-e              - Close completion menu
Ctrl-k              - Toggle signature help
Tab                 - Jump to next snippet placeholder
Shift-Tab           - Jump to previous snippet placeholder
```

---

## IDE-Like Setup Guide

### Creating an IDE Layout

Here's how to set up a complete IDE-like environment:

#### Method 1: Manual Setup

1. **Start Neovim** in your project directory:
   ```bash
   cd ~/Projects/your-project
   nvim
   ```

2. **Open file explorer** on the left:
   ```
   \                    # Opens Neo-tree
   ```

3. **Split your workspace**:
   ```
   # In Neo-tree, navigate to a file and press Enter to open it
   # Then create a vertical split:
   :vsplit              # Or use Ctrl-w v
   ```

4. **Open a terminal** at the bottom:
   ```
   :split               # Horizontal split
   :terminal            # Open terminal
   Ctrl-w J             # Move terminal to bottom
   :resize 15           # Resize to 15 lines high
   ```

5. **Navigate between panes**:
   ```
   Ctrl-h               # Move to left (Neo-tree)
   Ctrl-l               # Move to right (code)
   Ctrl-j               # Move down (terminal)
   Ctrl-k               # Move up (code)
   ```

#### Method 2: Using Tmux (Recommended)

Tmux provides better terminal management and persistence.

1. **Start tmux session**:
   ```bash
   tmux new -s myproject
   ```

2. **Open Neovim**:
   ```bash
   nvim
   ```

3. **Create tmux pane** for terminal:
   ```
   Ctrl-a "             # Split horizontally
   Ctrl-a %             # Split vertically
   ```

4. **Navigate with vim-tmux-navigator**:
   ```
   Ctrl-h/j/k/l         # Seamlessly move between vim and tmux panes
   ```

#### Method 3: Using Smug (Best for Repeated Workflows)

See [Smug Section](#smug-session-manager) below for automated project setup.

### Recommended IDE Workflow

**Typical Layout**:
```
┌─────────────┬──────────────────────┐
│             │                      │
│  Neo-tree   │    Main Editor       │
│  (Files)    │    (Code)            │
│             │                      │
│             ├──────────────────────┤
│             │                      │
│             │    Terminal          │
└─────────────┴──────────────────────┘
```

**Daily Workflow**:

1. Open project with Smug or tmux
2. Use `\` to toggle file explorer (Neo-tree)
3. Use `Space-sf` to quickly find files
4. Use Harpoon (`Space-ha`) to mark important files
5. Use `Space-<Space>` to switch between buffers
6. Use terminal pane for git, testing, running code
7. Use `Space-sg` for project-wide search

---

## Tmux Configuration & Usage

### Prefix Key

Your tmux prefix is: `Ctrl-a` (not the default `Ctrl-b`)

### Essential Tmux Keybinds

#### Session Management
```bash
# Outside tmux:
tmux new -s <name>      # Create new named session
tmux ls                 # List sessions
tmux attach -t <name>   # Attach to session
tmux kill-session -t <name>  # Kill session

# Inside tmux:
Ctrl-a d                # Detach from session
Ctrl-a $                # Rename session
```

#### Window Management
```
Ctrl-a c                # Create new window
Ctrl-a N                # Create new window (custom binding)
Ctrl-a n                # Next window
Ctrl-a p                # Previous window
Ctrl-a 0-9              # Switch to window number
Ctrl-a ,                # Rename window
Ctrl-a &                # Kill window
Ctrl-a w                # List windows
```

#### Pane Management
```
Ctrl-a "                # Split pane horizontally
Ctrl-a %                # Split pane vertically

# Navigation (works seamlessly with Neovim via vim-tmux-navigator):
Ctrl-h                  # Move to left pane
Ctrl-j                  # Move to bottom pane
Ctrl-k                  # Move to top pane
Ctrl-l                  # Move to right pane
Ctrl-\                  # Move to previous pane

Ctrl-a x                # Kill pane
Ctrl-a z                # Zoom/unzoom pane (fullscreen toggle)
Ctrl-a {                # Swap pane with previous
Ctrl-a }                # Swap pane with next
Ctrl-a q                # Show pane numbers
Ctrl-a o                # Next pane
Ctrl-a ;                # Last active pane
```

#### Pane Synchronization
```
Ctrl-a y                # Toggle synchronize-panes
                        # (type in all panes simultaneously)
```

#### Copy Mode (Scrollback)
```
Ctrl-a [                # Enter copy mode
q                       # Exit copy mode

# In copy mode:
Space                   # Start selection
Enter                   # Copy selection
/                       # Search forward
?                       # Search backward
n                       # Next search result
N                       # Previous search result
```

#### Other Useful Commands
```
Ctrl-a r                # Reload tmux configuration
Ctrl-a ?                # Show all keybindings
Ctrl-a :                # Enter command mode
```

### Tmux Features in Your Config

- **Mouse Support**: Enabled - click to select panes, scroll, resize
- **Window Indexing**: Starts at 1 (not 0)
- **True Color Support**: Enabled for better color schemes
- **History**: 5000 lines of scrollback
- **Status Bar**: Shows session name, user, time, and load average
- **Persistent Sessions**: tmux-resurrect and tmux-continuum installed

### Vim-Tmux Integration

Your setup includes `vim-tmux-navigator` which allows seamless navigation:

- `Ctrl-h/j/k/l` works the same in both Neovim and tmux
- No mental overhead switching between vim splits and tmux panes

---

## Smug Session Manager

Smug automates tmux session creation with predefined layouts.

### What is Smug?

Smug reads YAML configuration files and automatically creates tmux sessions with:
- Predefined window layouts
- Automatic pane splits
- Pre-run commands in each pane
- Project-specific directory settings

### Your Smug Configurations

You have three Smug configurations at `~/.config/smug/`:

#### 1. `dev.yml` - General Development Session
```yaml
session: dev
root: $HOME/Projects
windows:
  - name: main
    layout: main-horizontal
    commands:
      - nvim
    panes:
      - commands:
          - echo "Welcome Back"
  - name: sideview
    panes:
      - layout: vertical
```

**Start with**: `smug start dev`

**Layout**:
- Window 1 "main": Neovim on top, shell below
- Window 2 "sideview": Side-by-side panes

#### 2. `shilp.yml` - Shilp Project Session
```yaml
session: shilp
root: $HOME/Projects/shilp
windows:
  - name: code
    layout: main-horizontal
    commands:
      - nvim
    panes:
      - type: horizontal
        commands:
          - clear
  - name: directory
    layout: main-vertical
    commands:
      - nvim .
```

**Start with**: `smug start shilp`

**Layout**:
- Window 1 "code": Neovim with horizontal terminal below
- Window 2 "directory": Neovim in file explorer mode

#### 3. `cardgame.yml` - Card Game Project

**Start with**: `smug start cardgame`

### Using Smug

#### Basic Commands
```bash
smug start <session>    # Start a session
smug stop <session>     # Stop a session
smug list              # List all session configs
smug edit <session>    # Edit session config
smug new <session>     # Create new session config
```

#### Workflow

1. **Create a session config**:
   ```bash
   smug new myproject
   ```

2. **Edit the config** at `~/.config/smug/myproject.yml`:
   ```yaml
   session: myproject
   root: ~/Projects/myproject

   windows:
     - name: editor
       layout: main-horizontal
       commands:
         - nvim
       panes:
         - commands:
             - git status

     - name: server
       commands:
         - npm run dev
   ```

3. **Start the session**:
   ```bash
   smug start myproject
   ```

4. **Attach if needed**:
   ```bash
   tmux attach -t myproject
   ```

### Creating Custom Smug Layouts

#### Example: Full Stack Development
```yaml
session: fullstack
root: ~/Projects/my-app

windows:
  - name: editor
    layout: main-vertical
    panes:
      - commands:
          - nvim
      - type: vertical
        commands:
          - nvim backend/

  - name: servers
    layout: tiled
    panes:
      - commands:
          - cd frontend && npm run dev
      - commands:
          - cd backend && go run main.go
      - commands:
          - docker-compose up

  - name: git
    commands:
      - git status
      - clear
```

#### Layout Options
- `main-horizontal`: Main pane on top, others below
- `main-vertical`: Main pane on left, others on right
- `tiled`: All panes evenly distributed
- `even-horizontal`: All panes horizontal, equal size
- `even-vertical`: All panes vertical, equal size

---

## Tips & Tricks

### Productivity Hacks

1. **Quick File Access**:
   - Mark your most-used files with Harpoon (`Space-ha`)
   - Access them instantly with `Space-hh` + number key

2. **Multi-file Editing**:
   - Use `Space-sg` to search for text across all files
   - Open results in quickfix list
   - Edit multiple files simultaneously

3. **Buffer Management**:
   - Keep only relevant buffers open
   - Use `Space-ba` to close all except current
   - Use `Space-<Space>` for quick buffer switching

4. **Split Workflows**:
   - Keep tests on one side, implementation on other
   - Use `Ctrl-w =` to equalize split sizes
   - Use `Ctrl-w _` to maximize current split height
   - Use `Ctrl-w |` to maximize current split width

5. **Terminal Integration**:
   - Use tmux for long-running processes
   - Use `:terminal` for quick commands
   - Exit terminal mode with `Esc Esc`

### Common Workflows

#### Workflow 1: Bug Fixing
```
1. Space-sg → search for error message
2. grr → find all references to function
3. Space-b → set breakpoint
4. F5 → start debugging
5. F2 → step over, F1 → step into
6. grn → rename after fixing
```

#### Workflow 2: Feature Development
```
1. smug start myproject
2. \ → open Neo-tree
3. Navigate to file, Enter to open
4. Space-ha → add to Harpoon
5. Ctrl-a " → split for terminal
6. Write code, Space-f to format
7. Run tests in terminal pane
8. Space-hs → stage changes
9. :Git commit
```

#### Workflow 3: Code Refactoring
```
1. Space-sw → find all usages of symbol
2. grr → LSP references
3. grn → rename across all files
4. Space-f → format all changes
5. Space-gf → find modified files
6. Review each file
7. Stage with gitsigns
```

### Advanced Vim Tricks

#### Macros
```
qa                  # Start recording macro in register 'a'
{commands}          # Perform actions
q                   # Stop recording
@a                  # Play macro
@@                  # Repeat last macro
10@a                # Play macro 10 times
```

#### Marks
```
ma                  # Set mark 'a' at cursor
'a                  # Jump to mark 'a'
:marks              # List all marks
```

#### Registers
```
"ayy                # Yank line into register 'a'
"ap                 # Paste from register 'a'
:reg                # View all registers
"+y                 # Yank to system clipboard
"+p                 # Paste from system clipboard
```

### Performance Tips

1. **Lua Loader**: Enabled automatically for ~30% faster startup
2. **Lazy Loading**: Most plugins load on-demand
3. **Large Files**: faster.nvim automatically disables heavy features for files >1MB
4. **Clear Highlights**: Press `Esc` to clear search highlights
5. **Close Unused Buffers**: Use `Space-bd` regularly
6. **Restart LSP**: `:LspRestart` if things get slow
7. **Update Plugins**: `:Lazy update` monthly
8. **Check Startup Time**: Run `nvim --startuptime startup.log` to benchmark
9. **Session Management**: Use persistence.nvim to quickly restore your workspace

### Customization

#### Adding Custom Keybinds
Edit `~/.config/nvim/init.lua`:
```lua
vim.keymap.set('n', '<leader>custom', ':YourCommand<CR>', { desc = 'Your description' })
```

#### Installing New LSP Servers
```
:Mason              # Opens Mason UI
                    # Search and install LSP servers
                    # Add to init.lua servers table
```

#### Creating New Smug Sessions
```bash
cd ~/.config/smug
cp dev.yml mynewproject.yml
# Edit mynewproject.yml
smug start mynewproject
```

---

## Quick Reference Card

### Most Common Commands

```
NAVIGATION          EDITING             FILES               NEW FEATURES
Ctrl-h/j/k/l       i/a/o               Space-sf  Files     s         Flash jump
Space-<Space>      dd/yy/p             Space-sg  Grep      Space-xx  Trouble
Space-sf           u/Ctrl-r            \         Neo-tree  Space-gd  Git diff
Space-sg           .                   Space-ha  Harpoon   Space-qs  Session
s (Flash)          Space-p (visual)    -         Oil       Ctrl-\    Terminal

LSP                 GIT                 TMUX                TESTING
grd                ]c/[c               Ctrl-a "  Split H   Space-tr  Run test
grr                Space-hs  Stage     Ctrl-a %  Split V   Space-ts  Summary
grn                Space-gd  Diff      Ctrl-a c  Window    Space-td  Debug
gra                Space-gh  History   Ctrl-a d  Detach    [t/]t     Navigate
K                  Space-gg  LazyGit   Ctrl-a r  Reload    Space-tw  Watch

DEBUG              BUFFERS             SEARCH              UI/THEMES
F5                 Shift-h/l           /pattern            Space-tt  Toggle theme
F1/F2/F3          Space-bd            n/N                 Space-n   Notifications
Space-b           Space-ba            */#                 Space-tc  Tree context
F7                                    Space-sw            Space-sn  Messages
```

---

## Getting Help

- **Neovim Help**: `:help <topic>` (e.g., `:help buffers`)
- **Plugin Docs**: `:help <plugin>` (e.g., `:help telescope`)
- **Keybinds**: `Space-sk` to search all keymaps
- **Which-key**: Press `Space` and wait to see options
- **LSP Info**: `:LspInfo`
- **Mason**: `:Mason` for installed tools
- **Lazy**: `:Lazy` for plugin management

---

## Troubleshooting

### LSP Not Working
```
:LspInfo            # Check LSP status
:Mason              # Verify LSP installed
:LspRestart         # Restart LSP
```

### Treesitter Issues
```
:TSUpdate           # Update parsers
:TSInstall <lang>   # Install language parser
:TSUpdateSync       # Update all parsers synchronously
```

### Plugin Issues
```
:Lazy sync          # Sync all plugins
:Lazy clean         # Remove unused plugins
:Lazy update        # Update all plugins
:Lazy restore       # Restore to lockfile state
:Lazy profile       # Profile startup time
```

### New Plugin Issues

**Trouble.nvim not showing diagnostics**:
```
:Trouble diagnostics toggle
:LspRestart
```

**Flash.nvim not working**:
- Ensure you're pressing `s` in normal mode
- Try `S` for treesitter selection
- Check `:Lazy` to ensure flash.nvim is loaded

**ToggleTerm not appearing**:
```
:ToggleTerm         # Manual toggle
:checkhealth toggleterm
```

**Neotest not finding tests**:
```
:Neotest summary    # Open summary to see detected tests
:checkhealth neotest
```
Make sure test files follow naming conventions (test_*.py, *_test.go, etc.)

**Diffview conflicts**:
```
:DiffviewClose      # Close any open diffviews
:DiffviewOpen       # Reopen
```

**Session not restoring**:
```
:lua print(vim.fn.stdpath('data') .. '/sessions/')  # Check session directory
Space-ql            # Try restoring last session explicitly
```

### Performance Issues
```
:Lazy profile       # Check slow plugins
nvim --startuptime startup.log  # Measure startup time
:checkhealth        # Run all health checks
```

If Neovim feels slow:
1. Check for large files (faster.nvim should handle them)
2. Disable Noice temporarily: `:Noice disable`
3. Check LSP: `:LspInfo` and `:LspStop` if needed
4. Profile with `:Lazy profile`

### Tmux Not Responding
```
Ctrl-a r            # Reload config
tmux kill-server    # Nuclear option (outside tmux)
```

### Keybinding Conflicts
If a keybinding doesn't work:
```
:verbose map <key>  # Check what's mapped to that key
:map <key>          # See all mappings for that key
Space-sk            # Search keymaps with Telescope
```

---

**Happy coding!** This setup is optimized for productivity. Take time to build muscle memory for the most common commands, and gradually explore advanced features as needed.
