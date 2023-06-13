-- File: config/keymaps.lua
-- Description: Define keymaps of Neovim and installed plugins.

local map = vim.keymap.set

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Close all windows and exit from Neovim with <leader> and q
map("n", "<leader>q", ":qa!<CR>", {})
-- Fast saving with <leader> and s
map("n", "<leader>s", ":w<CR>", {})
-- Move around splits
map("n", "<leader>wh", "<C-w>h", {})
map("n", "<leader>wj", "<C-w>j", {})
map("n", "<leader>wk", "<C-w>k", {})
map("n", "<leader>wl", "<C-w>l", {})

-- Swap semicolons & Colons
map("n", ";", ":")
map("n", ":", ";")

-- Yank to end
map("n", "Y", "y$")

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- Map Esc to kk
-- map('i', 'kk', '<Esc>')

-- Clear search highlighting with <leader> and c
map('n', '<leader>c', ':nohl<CR>')

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Reload configuration without restart nvim
map("n", "<leader>r", ":so %<CR>", {})

-- Reload currently opened file
map('n', '<leader>e', ':e<CR>')

-- Fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>')

-- Close all windows and exit from Neovim with <leader> and q
map('n', '<leader>q', ':qa!<CR>')

-- Stay in indent mode
map("v", "<", "<gv", { desc = "unindent line" })
map("v", ">", ">gv", { desc = "indent line" })

-- Improved Terminal Mappings
map("t", "<esc>", "<C-\\><C-n>", { desc = "Terminal normal mode" })
map("t", "jk", "<C-\\><C-n>", { desc = "Terminal normal mode" })
map("t", "<C-h>", "<c-\\><c-n><c-w>h", { desc = "Terminal left window navigation" })
map("t", "<C-j>", "<c-\\><c-n><c-w>j", { desc = "Terminal down window navigation" })
map("t", "<C-k>", "<c-\\><c-n><c-w>k", { desc = "Terminal up window navigation" })
map("t", "<C-l>", "<c-\\><c-n><c-w>l", { desc = "Terminal right window naviation" })

-- Smart Splits
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
map("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
map("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Alpha
map("n", "<leader>d", "<cmd>Alpha<cr>", { desc = "Alpha Dashboard" })

-- Terminal mappings
map('n', '<C-t>', ':Term<CR>', { noremap = true }) -- open
map('t', '<Esc>', '<C-\\><C-n>')                   -- exit

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, {})
map("n", "<leader>fg", builtin.live_grep, {})
map("n", "<leader>fb", builtin.buffers, {})
map("n", "<leader>fh", builtin.help_tags, {})

-- Neotree
-- open/close
map('n', '<C-n>', ':Neotree<CR>')

-- LSP Installer
map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP information" })
map("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", { desc = "LSP installer" })

-- SymbolsOutline
map("n", "<leader>lS", "<cmd>SymbolsOutline<cr>", { desc = "Symbols outline" })

-- ZK

-- Create a new note after asking for its title.
map("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

-- Open notes.
map("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)

-- Open notes associated with the selected tags.
map("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

-- Open notes associated with the selected tags.
map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)

-- Open notes associated with the selected tags.
map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)

-- Search for the notes matching a given query.
map("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>", opts)

-- Search for the notes matching the current visual selection.
map("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)

-- GitSigns
map("n", "<leader>gj", function()
  require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })
map("n", "<leader>gk", function()
  require("gitsigns").prev_hunk()
end, { desc = "Previous git hunk" })
map("n", "<leader>gl", function()
  require("gitsigns").blame_line()
end, { desc = "View git blame" })
map("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview git hunk" })
map("n", "<leader>gh", function()
  require("gitsigns").r_hunk()
end, { desc = "R git hunk" })
map("n", "<leader>gr", function()
  require("gitsigns").r_buffer()
end, { desc = "R git buffer" })
map("n", "<leader>gs", function()
  require("gitsigns").stage_hunk()
end, { desc = "Stage git hunk" })
map("n", "<leader>gu", function()
  require("gitsigns").undo_stage_hunk()
end, { desc = "Unstage git hunk" })
map("n", "<leader>gd", function()
  require("gitsigns").diffthis()
end, { desc = "View git diff" })


-- Trouble
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
map("n", "<leader>xw", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>")
map("n", "<leader>xd", "<cmd>TroubleToggle lsp_document_diagnostics<cr>")
map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>")

-- Delete & navigate buffers
map("n", "<leader>c", "<cmd>bdelete!<cr>", { desc = "Close buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
