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

-- Native insert-mode autocompletion (Neovim 0.12+)
vim.opt.completeopt = "menuone,noselect,popup"
vim.opt.autocomplete = true

-- cursor improvements
vim.o.scrolloff = 10
vim.o.cursorline = true

-- Plugins (using lazy.nvim)
-- For plugin list, check ~/.config/nvim/lua/config/lazy.lua
require("config.lazy")

-- Explicitly map Neovim filetypes to their treesitter parser names.
-- Neovim uses 'typescriptreact' as the filetype for .tsx files, but
-- the treesitter parser is called 'tsx'. Same story for .jsx files.
vim.treesitter.language.register('tsx',        'typescriptreact')
vim.treesitter.language.register('javascript', 'javascriptreact')

-- Activate treesitter for supported filetypes.
-- Wrapped in pcall so that a missing parser (e.g. before the first
-- :TSUpdate has finished) never crashes startup with an error.
vim.api.nvim_create_autocmd('FileType', {
    pattern = {
      -- systems / scripting
      'rust', 'c', 'cpp', 'lua', 'python',
      -- web / JS / TS / React
      'javascript', 'javascriptreact',
      'typescript', 'typescriptreact',
      'html', 'css', 'json',
    },
    callback = function()
      local ok, err = pcall(vim.treesitter.start)
      if not ok then
        vim.notify(
          'treesitter parser not yet installed for this filetype: ' .. err,
          vim.log.levels.DEBUG
        )
        return
      end
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })

-- Add custom trim whitespaces command
vim.api.nvim_create_user_command("TrimWhitespaces", function()
  vim.cmd([[keeppatterns %s/\s\+$//e]])
end, {})

