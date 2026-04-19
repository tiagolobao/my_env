-- ~/.config/nvim/lua/plugins/mason.lua
-- Mason: package manager for LSP servers, linters, formatters

return {
  {
    'mason-org/mason.nvim',
    lazy = false,
    priority = 100, -- load before mason-lspconfig
    opts = {
      ui = {
        icons = {
          package_installed   = '✓',
          package_pending     = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },

  {
    'mason-org/mason-lspconfig.nvim',
    lazy = false,
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      -- Automatically install these servers if not present
      ensure_installed = {
        'lua_ls',
        'rust_analyzer',
        'ts_ls',       -- TypeScript / JavaScript / React (TSX/JSX)
      },
      automatic_installation = true,
    },
  },
}
