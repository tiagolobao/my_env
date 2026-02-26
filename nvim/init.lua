-- Neovim basic configuration
-- This is a minimal setup for a productive editing experience

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse support
vim.opt.mouse = "a"

-- Tab settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Line wrapping
vim.opt.wrap = false

-- Enable 24-bit RGB color
vim.opt.termguicolors = true

-- Better split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Keep signcolumn always visible
vim.opt.signcolumn = "yes"

-- Set completeopt for better autocomplete
vim.opt.completeopt = "menuone,noselect"

-- Key mappings
local keymap = vim.keymap.set

-- Plugins (using lazy.vim)
-- For plugin list, check ~/.config/nvim/lua/config/lazy.lua
require("config.lazy")

require('lualine').setup{
    options = { 
        theme = 'horizon',
        icons_enabled = true,
    }
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'rust', 'c', 'cpp', 'lua', 'python' },
    callback = function()
      -- syntax highlighting, provided by Neovim
      vim.treesitter.start()
      -- folds, provided by Neovim
      -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      -- vim.wo.foldmethod = 'expr'
      -- indentation, provided by nvim-treesitter
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })

