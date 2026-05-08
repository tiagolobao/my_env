-- ~/.config/nvim/lua/plugins/ibl.lua
-- indent-blankline: shows indent guide lines for the current scope.
-- Minimal setup — no rainbow colours, just subtle indent markers.

return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = 'BufReadPre', -- load only when a file is opened
  opts = {
    indent = {
      -- Use a thin pipe character as the indent marker.
      -- Any single-cell char works here (e.g. '│', '▏', '|').
      char = '│',
    },
    scope = {
      -- Highlight the indent level of the current scope
      -- (the block your cursor is inside) with a slightly
      -- more visible line. Requires treesitter.
      enabled = true,
      show_start = false, -- don't underline the opening line
      show_end   = false, -- don't underline the closing line
    },
    exclude = {
      -- Disable ibl in these filetypes where guides are distracting.
      filetypes = {
        'help', 'alpha', 'dashboard', 'neo-tree',
        'Trouble', 'trouble', 'lazy', 'mason',
        'notify', 'toggleterm', 'lazyterm',
      },
    },
  },
}
