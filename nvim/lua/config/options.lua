vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Format on save; toggle with <leader>uf (global) or <leader>uF (buffer).
vim.g.autoformat = true

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.laststatus = 3
opt.showmode = false
opt.winborder = "rounded"

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true

opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "nosplit"

opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"

opt.undofile = true
opt.confirm = true
opt.mouse = "a"
opt.updatetime = 200
opt.timeoutlen = 300

-- Over SSH, leave the system clipboard alone so OSC 52 can do its thing.
-- On WSL, Neovim picks up win32yank.exe from PATH on its own.
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"
