-- ~/.config/nvim/lua/plugins/mason.lua
-- Mason v2: package manager for LSP servers, linters, formatters.
-- automatic_enable = true tells mason-lspconfig to call vim.lsp.enable()
-- for every installed server automatically (Mason-LSPConfig v2 API).

return {
  {
    'mason-org/mason.nvim',
    lazy = false,
    priority = 100,
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
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      ensure_installed = {
        'lua_ls',
        'rust_analyzer',
        'ts_ls',   -- TypeScript / JavaScript / React (TSX / JSX)
      },
      -- Mason-LSPConfig v2: calls vim.lsp.enable() for every installed server.
      automatic_enable = true,
    },
  },
}
