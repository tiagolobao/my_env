-- ~/.config/nvim/lua/plugins/lsp.lua

return {
  'neovim/nvim-lspconfig',
  lazy = false,
  dependencies = {
    'hrsh7th/nvim-cmp',             -- autocompletion engine
    'hrsh7th/cmp-nvim-lsp',         -- LSP completion source
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
  },
  config = function()
    local lspconfig       = require('lspconfig')
    local mason_lspconfig = require('mason-lspconfig')

    -- Extend default capabilities with nvim-cmp completion support
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Default handler: called for every server managed by mason-lspconfig
    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      -- Per-server overrides --------------------------------------------------

      ['lua_ls'] = function()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = { globals = { 'vim' } }, -- suppress 'vim' undefined warnings
              workspace   = { checkThirdParty = false },
              telemetry   = { enable = false },
            },
          },
        })
      end,

      ['ts_ls'] = function()
        lspconfig.ts_ls.setup({
          capabilities = capabilities,
          -- Activate for JS/TS/JSX/TSX files
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
          },
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints         = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints          = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints  = true,
                includeInlayEnumMemberValueHints        = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints         = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints          = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints  = true,
                includeInlayEnumMemberValueHints        = true,
              },
            },
          },
        })
      end,
    })

    -- Keymap to toggle inlay hints (works for any LSP)
    vim.keymap.set('n', 'gh', function()
      vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }),
        { bufnr = 0 }
      )
    end, { desc = 'Toggle Inlay Hints' })
  end,
}
