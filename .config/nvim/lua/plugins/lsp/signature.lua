local status_ok, signature = pcall(require, 'lsp_signature')
if not status_ok then
  return
end

signature.setup({
	bind = true,
	handler_opts = {
		border = "rounded",
	},
	toggle_key = "<M-x>",
	floating_window = false,
})
