-- File: plugins/markdown.lua
-- Description: Plugins to make working with markdown easier
-- zettelkasten nvim, tabular, and vim-markdown

return {
  {
    'mickael-menu/zk-nvim',
    lazy = true,
    ft = "markdown",
    config = function()
      require('zk').setup({
        picker = "telescope",
      })
    end
  },
  {
    'godlygeek/tabular',
    lazy = true,
    ft = 'markdown'
  },
  {
    'preservim/vim-markdown',
    lazy = true,
    ft = 'markdown'
  },
}
