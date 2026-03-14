-- Neovim basic configuration
-- This is a minimal setup for a productive editing experience

-- Nerd font is installed
vim.g.have_nerd_font = true

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse support
vim.opt.mouse = "a"

-- Tab settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Line wrapping
vim.opt.wrap = false

-- Enable 24-bit RGB color
vim.opt.termguicolors = true

-- Split to the right instead of below
vim.opt.splitright = true

-- Persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Keep signcolumn always visible
vim.opt.signcolumn = "yes"

-- Set completeopt for better autocomplete
vim.opt.completeopt = "menuone,noselect"

-- cursor improvements
vim.o.scrolloff = 10
vim.o.cursorline = true

-- Plugins (using lazy.vim)
-- For plugin list, check ~/.config/nvim/lua/config/lazy.lua
require("config.lazy")

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

