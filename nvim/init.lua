vim.cmd("set nu")
vim.cmd("set tabstop=2 softtabstop=2 shiftwidth=2")
vim.cmd("set expandtab")
vim.cmd("set number ruler")
vim.cmd("set autoindent smartindent")
vim.cmd("set nohlsearch")
vim.g.mapleader = " "
-- lazy nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<C-f>', ':Neotree filesystem reveal left<CR>', {})

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"cpp", "lua", "python"},
  highlight = { enabled = true },
  indent = { enabled = true },
})

require("gruvbox").setup()
vim.cmd.colorscheme "gruvbox"

