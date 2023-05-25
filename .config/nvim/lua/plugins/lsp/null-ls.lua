local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not status_ok then
  return
end

local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local status_ok, mason_automatic_setup = pcall(require, "mason-null-ls.automatic_setup")
if not status_ok then
  return
end

mason_null_ls.setup({
	ensure_installed = { "stylua", "prettier", "spell", "cspell" },
})

	mason_null_ls.setup_handlers({
		function(source_name, methods)
			-- all sources with no handler get passed here
			-- Keep original functionality of `automatic_setup = true`
			mason_automatic_setup(source_name, methods)
		end,
		stylua = function()
			null_ls.register(null_ls.builtins.formatting.stylua)
		end,
	})

	-- will setup any installed and configured sources above
	null_ls.setup({
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr })
					end,
				})
			end
		end,
	})
