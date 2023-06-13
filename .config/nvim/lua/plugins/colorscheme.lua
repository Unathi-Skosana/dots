-- File: plugins/colorscheme.lua
-- Description: Colorscheme config: Zenbones syntax - rose-pine status line

return {
  {
    "mcchrish/zenbones.nvim",
    name = "zenbones",
    dependencies = {
      "rktjmp/lush.nvim"
    }
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      dark_variant = "main"
    },
    lazy = true
  },
}
