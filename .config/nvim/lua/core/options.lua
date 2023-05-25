-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
opt.swapfile = false                  -- Don't use swapfile
opt.completeopt = 'menu,menuone,noselect'  -- Autocomplete options
opt.fileencoding = 'utf-8'            -- File content encoding for the buffer
opt.undofile = true                   -- Enable persistent undo
opt.writebackup = false               -- Disable making a backup before overwriting a file
opt.shell = "/usr/bin/zsh"            -- Default shell
opt.spell = true
-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true           -- Show line number
opt.relativenumber = true   -- Show relative numberline
opt.showmatch = true        -- Highlight matching parenthesis
opt.showmode = false        -- Disable showing modes in command line
opt.foldmethod = 'syntax'     -- Enable folding (default 'foldmarker')
opt.foldlevelstart = 99
opt.signcolumn = "yes"      -- Always show the sign column
opt.cursorline = true       -- Highlight the text line of the cursor
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
opt.sidescrolloff = 8       -- Number of columns to keep at the sides of the cursor
opt.scrolloff = 8           -- Number of lines to keep above and below the cursor
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.linebreak = true        -- Wrap on word boundary
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.laststatus=3            -- Set global statusline
opt.list = true             -- List invisible characters
opt.showbreak = '↪'         -- Show breakline symbol
opt.listchars = { eol = '¬', tab = '>·', trail = '~', extends = '>', precedes = '<' }
opt.pumheight = 10         -- Height of the pop up menu

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.wrap = true
opt.wrapmargin = 2
opt.softtabstop = 2
opt.textwidth = 80         -- Width of characters before text breaks to another line
opt.expandtab = true        -- Use spaces instead of tabs
opt.shiftwidth = 2          -- Shift 2 spaces when tab
opt.tabstop = 2             -- 1 tab == 2 spaces
opt.smartindent = true      -- Autoindent new lines
opt.copyindent = true
opt.preserveindent = true  -- Preserve indent structure as much as possible
-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 100           -- Remember N lines in history
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 700        -- ms to wait for trigger an event
opt.timeoutlen = 300        -- Length of time to wait for a mapped sequence
-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append "sI"

-- Disable builtins plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

