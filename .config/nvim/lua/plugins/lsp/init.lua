require("plugins.lsp.config")
require("plugins.lsp.signature")
require("plugins.lsp.trouble")
require("plugins.lsp.barbecue")

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local mason_lsp_ok, masonLspConfig = pcall(require, "mason-lspconfig")
if not mason_lsp_ok then
  return
end

local lsp_ok, lspConfig = pcall(require, "lspconfig")
if not lsp_ok then
  return
end

local cmp_nvim_lsp_ok, cmpLsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
  return
end

local typescript_ok, typescript = pcall(require, "typescript")
if not typescript_ok then
  return
end

local rust_tools_ok, rustTools= pcall(require, "rust-tools")
if not rust_tools_ok then
  return
end

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

masonLspConfig.setup({
  ensure_installed = {
   "lua_ls",
   "jsonls",
   "tsserver",
   "eslint",
   "html",
   "cssls",
   "yamlls",
   "cssmodules_ls",
   "rust_analyzer",
   "pylsp"
  },
})

local opts = {
		capabilities = cmpLsp.default_capabilities(),
		on_attach = require("plugins.lsp.on_attach").on_attach,
	}

masonLspConfig.setup_handlers({
	function(server_name)
		local has_custom_opts, custom_opts = pcall(require, "config.lsp.settings." .. server_name)

		local server_opts = opts

		if has_custom_opts then
			server_opts = vim.tbl_deep_extend("force", custom_opts, opts)
		end

		lspConfig[server_name].setup(server_opts)
	end,
	["tsserver"] = function()
		typescript.setup({ server = opts })
	end,
	["rust_analyzer"] = function()
		rustTools.setup({ server = opts })
	end,
})

require("plugins.lsp.null-ls")
