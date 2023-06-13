-- File: plugins/toggleterm.lua
-- Description: Config for toggle term

return { -- Floating terminal
  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = [[<c-\>]],
      terminal_mappings = true,
      insert_mappings = true,
      shade_terminals = false,
      start_in_insert = true,
      direction = "float",
    },
  } }
