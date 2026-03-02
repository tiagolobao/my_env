-- ~/.config/nvim/lua/plugins/lsp.lua

-- Plugin specification for lazy.nvim
return {
  'neovim/nvim-lspconfig',
  lazy = false,
  dependencies = {
    'hrsh7th/nvim-cmp',      -- For autocompletion
    'hrsh7th/cmp-nvim-lsp',  -- For completion capabilities
  },
  config = function()
    vim.lsp.enable("rust_analyzer");
    vim.lsp.enable("lua_ls");
    -- Keymap to toggle inlay hints
    vim.keymap.set('n', 'gh', function()
       vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
    end, { desc = "Toggle Inlay Hints" })
  end,
}


