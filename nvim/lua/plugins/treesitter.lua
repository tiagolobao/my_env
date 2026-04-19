-- ~/.config/nvim/lua/plugins/treesitter.lua

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'lua',
        'rust',
        'c',
        'cpp',
        'python',
        -- JS / TS / React
        'javascript',
        'typescript',
        'tsx',
        'html',
        'css',
        'json',
      },
      auto_install   = true,
      highlight      = { enable = true },
      indent         = { enable = true },
    })
  end,
}
