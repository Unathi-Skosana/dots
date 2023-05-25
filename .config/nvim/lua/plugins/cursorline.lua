local status_ok, cursorLine = pcall(require, 'nvim-cursorline')
if not status_ok then
  return
end

cursorLine.setup({
	cursorline = {
		enable = true,
	},
	cursorword = {
		enable = true,
	},
})
