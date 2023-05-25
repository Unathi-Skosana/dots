-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local map = vim.keymap.set

-- Change leader to a comma
vim.g.mapleader = ' '

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

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
map('i', 'kk', '<Esc>')

-- Clear search highlighting with <leader> and c
map('n', '<leader>c', ':nohl<CR>')

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so %<CR>')

-- Reload file
map('n', '<leader>e', ':e<CR>')

-- Fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>')
map('i', '<leader>s', '<C-c>:w<CR>')

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
map('n', '<C-t>', ':Term<CR>', { noremap = true })  -- open
map('t', '<Esc>', '<C-\\><C-n>')                    -- exit

-- Neotree
map('n', '<C-n>', ':Neotree<CR>')            -- open/close

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
  require("gitsigns").reset_hunk()
end, { desc = "Reset git hunk" })
map("n", "<leader>gr", function()
  require("gitsigns").reset_buffer()
end, { desc = "Reset git buffer" })
map("n", "<leader>gs", function()
  require("gitsigns").stage_hunk()
end, { desc = "Stage git hunk" })
map("n", "<leader>gu", function()
  require("gitsigns").undo_stage_hunk()
end, { desc = "Unstage git hunk" })
map("n", "<leader>gd", function()
  require("gitsigns").diffthis()
end, { desc = "View git diff" })


-- Telescope
map("n", "<leader>fw", function()
  require("telescope.builtin").live_grep()
end, { desc = "Search words" })
map("n", "<leader>gt", function()
  require("telescope.builtin").git_status()
end, { desc = "Git status" })
map("n", "<leader>gb", function()
  require("telescope.builtin").git_branches()
end, { desc = "Git branchs" })
map("n", "<leader>gc", function()
  require("telescope.builtin").git_commits()
end, { desc = "Git commits" })
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Search files" })
map("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = "Search buffers" })
map("n", "<leader>fh", function()
  require("telescope.builtin").help_tags()
end, { desc = "Search help" })
map("n", "<leader>fm", function()
  require("telescope.builtin").marks()
end, { desc = "Search marks" })
map("n", "<leader>fo", function()
  require("telescope.builtin").oldfiles()
end, { desc = "Search history" })
map("n", "<leader>sb", function()
  require("telescope.builtin").git_branches()
end, { desc = "Git branchs" })
map("n", "<leader>sh", function()
  require("telescope.builtin").help_tags()
end, { desc = "Search help" })
map("n", "<leader>sm", function()
  require("telescope.builtin").man_pages()
end, { desc = "Search man" })
map("n", "<leader>sn", function()
  require("telescope").extensions.notify.notify()
end, { desc = "Search notifications" })
map("n", "<leader>sr", function()
  require("telescope.builtin").registers()
end, { desc = "Search registers" })
map("n", "<leader>sk", function()
  require("telescope.builtin").keymaps()
end, { desc = "Search keymaps" })
map("n", "<leader>sc", function()
  require("telescope.builtin").commands()
end, { desc = "Search commands" })
map("n", "<leader>ls", function()
  local aerial_avail, _ = pcall(require, "aerial")
  if aerial_avail then
    require("telescope").extensions.aerial.aerial()
  else
    require("telescope.builtin").lsp_document_symbols()
  end
end, { desc = "Search symbols" })
map("n", "<leader>lR", function()
  require("telescope.builtin").lsp_references()
end, { desc = "Search references" })
map("n", "<leader>lD", function()
  require("telescope.builtin").diagnostics()
end, { desc = "Search diagnostics" })

-- Trouble
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
map("n", "<leader>xw", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>")
map("n", "<leader>xd", "<cmd>TroubleToggle lsp_document_diagnostics<cr>")
map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>")

-- Undo history
map("n", "<leader>m", "<cmd>MundoToggle<cr>")


-- Delete & navigate buffers
map("n", "<leader>c", "<cmd>bdelete!<cr>", { desc = "Close buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })


-- Packer
map("n", "<leader>pc", "<cmd>PackerCompile<cr>", { desc = "Packer Compile" })
map("n", "<leader>pi", "<cmd>PackerInstall<cr>", { desc = "Packer Install" })
map("n", "<leader>ps", "<cmd>PackerSync<cr>", { desc = "Packer Sync" })
map("n", "<leader>pS", "<cmd>PackerStatus<cr>", { desc = "Packer Status" })
map("n", "<leader>pu", "<cmd>PackerUpdate<cr>", { desc = "Packer Update" })
