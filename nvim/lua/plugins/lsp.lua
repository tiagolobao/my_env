-- ~/.config/nvim/lua/plugins/lsp.lua
-- Neovim 0.12+: native vim.lsp.config() API replaces nvim-lspconfig.
-- Mason v2 + mason-lspconfig with automatic_enable = true starts servers
-- automatically; no setup_handlers() needed.

return {
  -- nvim-lspconfig is kept for its bundled server definitions (cmd, root_markers,
  -- filetypes), but we no longer call lspconfig[server].setup().
  'neovim/nvim-lspconfig',
  lazy = false,
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
  },
  config = function()

    -- Global defaults applied to every LSP client --------------------------
    vim.lsp.config('*', {
      capabilities = vim.lsp.protocol.make_client_capabilities(),
    })

    -- Lua ------------------------------------------------------------------
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime     = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } },
          workspace   = {
            library      = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })

    -- TypeScript / JavaScript / React (ts_ls) ------------------------------
    vim.lsp.config('ts_ls', {
      -- These are the correct Neovim filetype names:
      --   javascript      -> .js files
      --   javascriptreact -> .jsx files
      --   typescript      -> .ts files
      --   typescriptreact -> .tsx files
      -- (javascript.jsx and typescript.tsx are NOT valid Neovim filetypes)
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      },
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints                          = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName   = false,
            includeInlayFunctionParameterTypeHints                  = true,
            includeInlayVariableTypeHints                           = true,
            includeInlayPropertyDeclarationTypeHints                = true,
            includeInlayFunctionLikeReturnTypeHints                 = true,
            includeInlayEnumMemberValueHints                        = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints                          = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName   = false,
            includeInlayFunctionParameterTypeHints                  = true,
            includeInlayVariableTypeHints                           = true,
            includeInlayPropertyDeclarationTypeHints                = true,
            includeInlayFunctionLikeReturnTypeHints                 = true,
            includeInlayEnumMemberValueHints                        = true,
          },
        },
      },
    })

    -- Keymap: toggle inlay hints for the current buffer --------------------
    vim.keymap.set('n', 'gh', function()
      vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }),
        { bufnr = 0 }
      )
    end, { desc = 'Toggle Inlay Hints' })

    -- Native insert-mode completion (Neovim 0.12 built-in) -----------------
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method('textDocument/completion') then
          vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
      end,
    })
  end,
}
