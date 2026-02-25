-- ~/.config/nvim/lua/plugins/lsp.lua

-- Neovim version detection
local has_new_lsp_api = vim.version().major == 0 and vim.version().minor >= 11

-- New API setup function (Nvim 0.11+)
function setup_lsp_new()
  require'lspconfig'.clangd.setup{}
  require'lspconfig'.pyright.setup{}
  require'lspconfig'.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false;
      }
    }
  }
}
  -- Setup common LSP attach handlers
  setup_lsp_attach()
end

-- Legacy API setup function (Nvim 0.10)
function setup_lsp_legacy()
  local lspconfig = require('lspconfig')
  
  -- Setup pyright
  lspconfig.pyright.setup({})
end

-- Common LSP attach configuration (works with both APIs)
function setup_lsp_attach()
  return function(client, bufnr)
    -- Buffer-local keymaps
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    
    -- Set omnifunc for manual completion fallback
    vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
  end
end

-- IMPORTANT: This extra closing is for the main return block
-- The file should end here with no extra 'end' statements needed


-- Plugin specification for lazy.nvim
return {
  'neovim/nvim-lspconfig',
  tag = has_new_lsp_api and 'v2.0.0' or 'v1.9.0',
  lazy = false,
  dependencies = {
    'hrsh7th/nvim-cmp',      -- For autocompletion
    'hrsh7th/cmp-nvim-lsp',  -- For completion capabilities
  },
  config = function()
    if has_new_lsp_api then
      setup_lsp_new()
    else
      setup_lsp_legacy()
    end
  end,
}


