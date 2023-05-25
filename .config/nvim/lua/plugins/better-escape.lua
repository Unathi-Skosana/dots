local status_ok, betterEscape = pcall(require, 'better_escape')
if not status_ok then
  return
end

betterEscape.setup({
  mapping = { "jk", "jj" },
})
