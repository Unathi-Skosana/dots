-- File: plugins/neotree.lua
-- Description: Config for neo-tree file explorer

return {
  -- File explore
  -- nvim-tree.lua - A file explorer tree for neovim written in lua
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
      {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opt = true
      },
      {
        "MunifTanjim/nui.nvim",
        lazy = true
      }
    },
    config = true
  }
}
