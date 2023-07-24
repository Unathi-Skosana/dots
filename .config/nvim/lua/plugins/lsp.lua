-- File: plugins/lsp.lua
-- Description: LSP setup and config
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp

return { -- LSP - Quickstart configs for Nvim LSP
  {
    "L3MON4D3/LuaSnip",
    version      = '1',
    dependencies = {
      {
        "rafamadriz/friendly-snippets"
      }
    },
    config       = function()
      require 'luasnip'.config.setup {
        history = true,
        native_menu = true,
        updateevents = 'TextChanged,TextChangedI',
        enable_autosnippets = true,
        --ft_func = require 'luasnip.extras.filetype_functions'.from_pos_or_filetype,
        load_ft_func = require 'luasnip.extras.filetype_functions'.extend_load_ft {
          latex = { 'markdown' },
          markdown = { 'lua', 'latex', 'json', 'html', 'yaml', 'css', 'typescript', 'javascript' },
          html = { 'javascript', 'css', 'graphql', 'json' },
          javascript = { 'html', 'css', 'graphql' },
          typescript = { 'html', 'css', 'graphql' },
        },
      }

      require 'luasnip.loaders.from_lua'.lazy_load()
      require 'luasnip.loaders.from_vscode'.lazy_load()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    version = false,
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "ray-x/cmp-treesitter",
      "onsails/lspkind-nvim",
      {
        'petertriho/cmp-git', -- autocomplete git issues
        opts = {
          remotes = { 'upstream', 'origin', 'fork' },
          enableRemoteUrlRewrites = true,
        }
      },
      {
        'KadoBOT/cmp-plugins', -- plugin names
        opts = { files = { 'lua/plugins.*\\.lua' } }
      },
    },
    opts = function()
      -- luasnip setup
      local luasnip = require "luasnip"

      -- nvim-cmp setup
      local cmp = require "cmp"
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
          },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" })
        }),

        window = {
          completion = {
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
            col_offset = -3,
            side_padding = 0,
          },
        },

        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          -- fields = { "kind", "abbr" },
          format = function(entry, vim_item)
            local kind = require 'lspkind'.cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, '%s', { trimempty = true })
            kind.kind = ' ' .. strings[1] .. ' '
            -- kind.menu = "    (" .. strings[2] .. ")"
            kind.menu = ({
              buffer = '🧹',
              nvim_lsp = '🔮',
              luasnip = '✂️',
              nvim_lua = '🌙',
              path = '怒',
              treesitter = '🌴',
              copilot = '🤖'
            })[entry.source.name]
            return kind
          end,
        },

        experimental = {
          ghost_text = true,
        },

        sources = {
          { name = "nvim_lsp" },
          { name = 'calc' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'treesitter' },
          { name = "luasnip" },
          { name = "copilot" },
          { name = "path" },
          {
            name = "buffer",
            keyword_length = 3,
            option = {
              -- Avoid accidentally running on big files
              get_bufnrs = function()
                local buf = vim.api.nvim_get_current_buf()
                local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                if byte_size > 1024 * 1024 then -- 1 Megabyte max
                  return {}
                end
                return { buf }
              end
            }
          } }
      }
    end
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { -- Mason
      -- Portable package manager for Neovim that runs everywhere Neovim runs.
      -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" }, -- Autocomplete
      -- A completion plugin for neovim coded in Lua.
    },
    opts = {
      -- Automatically format on save
      autoformat = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        jsonls = {},
        dockerls = {},
        bashls = {},
        gopls = {},
        pyright = {
          disableLanguageServices = false,
          disableOrganizeImports = true
        },
        vimls = {},
        yamlls = {},
        ltex = {}
      },
      -- you can do any additional lsp server setup here
      -- return true if you don"t want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      }
    },
    ---@param opts Opts
    config = function(_, opts)
      local servers = opts.servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities)
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- temp fix for lspconfig rename
      -- https://github.com/neovim/nvim-lspconfig/pull/2439
      local mappings = require("mason-lspconfig.mappings.server")
      if not mappings.lspconfig_to_package.lua_ls then
        mappings.lspconfig_to_package.lua_ls = "lua-language-server"
        mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
      end

      local mlsp = require("mason-lspconfig")
      local available = mlsp.get_available_servers()

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_installation = true
      })
      require("mason-lspconfig").setup_handlers({ setup })
    end
  }, -- Use Neovim as a language server to inject LSP diagnostics,
  -- code actions, and more via Lua.
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "williamboman/mason.nvim", "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      local null_ls = require("null-ls")
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      local formatting = null_ls.builtins.formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      local diagnostics = null_ls.builtins.diagnostics

      null_ls.setup({
        debug = false,
        root_dir = require("null-ls.utils").root_pattern(".git", "package.json"),
        sources = { formatting.prettier.with {
          extra_filetypes = { "toml" },
        }, formatting.black.with {
          extra_args = { "--fast" }
        }, formatting.stylua, diagnostics.flake8 }
      })
    end
  } }
