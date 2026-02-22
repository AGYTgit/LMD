local opt = vim.opt

-- ui
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

-- cursor
opt.cursorline = true
opt.signcolumn = "yes"

-- color fix
opt.termguicolors = true

-- scroll
opt.scrolloff = 8
opt.sidescrolloff = 8

-- wrap
opt.wrap = true
opt.linebreak = true

-- mode
opt.showmode = false
opt.showcmd = true
opt.showcmdloc = "statusline"

-- indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

-- search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- splits
opt.splitright = true
opt.splitbelow = true

-- files
opt.swapfile = true
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- performance
opt.updatetime = 250
opt.timeoutlen = 300

-- completion
opt.completeopt = { "menuone", "noselect" }

-- clipboard sync
opt.clipboard:append("unnamedplus")

-- rust formatter
vim.g.rustfmt_autosave = 0

-- transparency
-- settings are in tokyonight.lua

-- opt.signcolumn = "yes"
