local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

npairs.setup({
  check_ts = true,
})

cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done { map_char = { tex = "" } })
