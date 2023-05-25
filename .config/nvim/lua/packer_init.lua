----------------------------------------------------------- Plugin manager configuration file ---------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)
  -- Essentials
  use('wbthomason/packer.nvim')
  use('lewis6991/impatient.nvim')
  use('nvim-lua/plenary.nvim')
  use('kyazdani42/nvim-web-devicons')
  use('MunifTanjim/nui.nvim')

-- Navigation
	use({
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v2.x',
	})

  -- Treesitter
  use('nvim-treesitter/nvim-treesitter')
  use('windwp/nvim-ts-autotag')
  use('nvim-treesitter/nvim-treesitter-textobjects')
  use('p00f/nvim-ts-rainbow')
  use('windwp/nvim-autopairs')
  use('yamatsum/nvim-cursorline')


  -- CMP
  use({
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'petertriho/cmp-git',
    'f3fora/cmp-spell',
    'uga-rosa/cmp-dictionary',
    'lukas-reineke/cmp-rg',
    'hrsh7th/cmp-nvim-lsp-signature-help',
  })
  use('zbirenbaum/copilot.lua')
	use('zbirenbaum/copilot-cmp')
  use('rafamadriz/friendly-snippets')

  -- LSP
  use({
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig'
  })
	use('b0o/SchemaStore.nvim')
  use({
		'weilbith/nvim-code-action-menu',
		cmd = 'CodeActionMenu',
	})
  use('jose-elias-alvarez/null-ls.nvim')
  use('jose-elias-alvarez/typescript.nvim')
	use('simrat39/symbols-outline.nvim')
  use('ray-x/lsp_signature.nvim')
  use('onsails/lspkind.nvim')
  use('gpanders/editorconfig.nvim')
	use('folke/trouble.nvim')
	use('smiteshp/nvim-navic')
	use('utilyre/barbecue.nvim')
  use('simrat39/rust-tools.nvim')

  -- Telescope
  use('nvim-telescope/telescope.nvim')
  use('nvim-telescope/telescope-fzy-native.nvim')
	use('nvim-telescope/telescope-project.nvim')

  -- Editing
  use('max397574/better-escape.nvim')
  use('tpope/vim-eunuch')
  use('ethanholz/nvim-lastplace')
  use('numToStr/Comment.nvim')
	use('JoosepAlviste/nvim-ts-context-commentstring')
  use('simnalamburt/vim-mundo')
	use('kylechui/nvim-surround')

  -- UI
	use('stevearc/dressing.nvim')
  use('goolord/alpha-nvim')
  use('junegunn/goyo.vim')
  use('junegunn/limelight.vim')
  use({
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    requires = "rktjmp/lush.nvim"
  })
  use({ 'catppuccin/nvim', as = 'catppuccin' })
  use({ 'sainnhe/everforest' })
  use({ 'EdenEast/nightfox.nvim' })
  use({ 'nvim-lualine/lualine.nvim' })
	use({ 'akinsho/bufferline.nvim', tag = 'v3.*' })
  use('lewis6991/gitsigns.nvim')
  use('lukas-reineke/indent-blankline.nvim')

  -- Misc
  use {
    'mickael-menu/zk-nvim',
    config = function()
      require('zk').setup({
        picker = "fzf",
      })
    end
  }
  use({
    'iamcco/markdown-preview.nvim',
    run = function()
      vim.fn['mkdp#util#install']()
    end,
})
  use({
    'folke/persistence.nvim',
    event = 'BufReadPre',
    module = 'persistence',
    config = function()
      require('persistence').setup()
    end,
  })
  use('sindrets/diffview.nvim')
  use('aserowy/tmux.nvim')
  use('akinsho/toggleterm.nvim')
  use('junegunn/vim-easy-align')
  use("jc-doyle/cmp-pandoc-references")
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
