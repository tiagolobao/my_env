-- ~/.config/nvim/lua/plugins/treesitter.lua
-- Neovim 0.12: nvim-treesitter.configs module is removed.
-- The plugin now only handles parser installation; highlight and indent
-- are native Neovim features enabled via vim.treesitter.start() (see init.lua).
-- IMPORTANT: 0.12 requires the 'main' branch, not 'master'.

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    -- Install parsers that are not bundled with Neovim 0.12 by default.
    -- Bundled parsers (lua, c, vimdoc, etc.) do not need to be listed.
    require('nvim-treesitter').setup({
      ensure_install = {
        'rust',
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
    })
  end,
}
