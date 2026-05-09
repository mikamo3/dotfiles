-- Modern minimal Neovim configuration for basic file editing
-- Replaces legacy init.vim setup

-- Basic editor settings
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.splitright = true
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true
vim.opt.hidden = true
vim.opt.termguicolors = true

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Leader key
vim.g.mapleader = " "

-- Essential keymaps
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<C-j>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-k>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-w>d", ":bdelete<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<C-w>|", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<C-w>-", ":split<CR>", { desc = "Horizontal split" })

-- Clear search highlighting with Esc
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlighting" })

-- Auto-install lazy.nvim (modern plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Minimal plugins for basic editing
require("lazy").setup({
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  
  -- Essential editing improvements
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  
  -- Comment toggle
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = true,
  },
  
  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = true,
  },
  
  -- EditorConfig support
  {
    "editorconfig/editorconfig-vim",
    event = "VeryLazy",
  },
})

-- FileType specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "vim",
  callback = function()
    vim.opt_local.foldmethod = "marker"
  end,
})