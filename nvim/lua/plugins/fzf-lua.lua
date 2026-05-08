-- ~/.config/nvim/lua/plugins/fzf-lua.lua

return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  ---@module 'fzf-lua'
  ---@type fzf-lua.Config|{}
  ---@diagnostic disable: missing-fields
  opts = {},
  ---@diagnostic enable: missing-fields
  keys = {
    -- Files & buffers -------------------------------------------------------
    { '<leader>ff', '<cmd>FzfLua files<cr>',        desc = '[F]ind [F]iles' },
    { '<leader>fr', '<cmd>FzfLua oldfiles<cr>',     desc = '[F]ind [R]ecent files' },
    { '<leader>fb', '<cmd>FzfLua buffers<cr>',      desc = '[F]ind [B]uffers' },

    -- Search ----------------------------------------------------------------
    { '<leader>fg', '<cmd>FzfLua live_grep<cr>',    desc = '[F]ind by [G]rep' },
    { '<leader>/',  '<cmd>FzfLua grep_cword<cr>',   desc = 'Grep current [W]ord' },

    -- Help & meta -----------------------------------------------------------
    { '<leader>fh', '<cmd>FzfLua helptags<cr>',     desc = '[F]ind [H]elp' },

    -- LSP -------------------------------------------------------------------
    { '<leader>fs', '<cmd>FzfLua lsp_document_symbols<cr>',  desc = '[F]ind [S]ymbols' },
    { '<leader>fd', '<cmd>FzfLua diagnostics_document<cr>',  desc = '[F]ind [D]iagnostics' },
  },
}
