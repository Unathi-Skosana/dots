local status_ok, copilot = pcall(require, 'copilot')
if not status_ok then
  return
end

local status_ok, copilot_cmp = pcall(require, 'copilot_cmp')
if not status_ok then
  return
end


copilot.setup({
 filetypes = {
    markdown = true,
    javascript = true,
    typescript = true,
    python = true,
    rust = true,
    lua = true,
    json = true,
    yaml = true,
    css = true,
    html = true,
    ["*"] = false,
  },
})
copilot_cmp.setup()
