vim.cmd('autocmd BufWritePost init.lua source <afile>')

vim.cmd("let g:netrw_liststyle = 3")

local o = vim.opt

-- numbers on the left
o.relativenumber = true
o.number = true

-- tabs & indentation
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true

-- line wrapping
o.wrap = true
o.linebreak = true

-- search settings
o.ignorecase = true
o.smartcase = true

-- split behaviour
o.splitright = true
o.splitbelow = true

-- synced clipboard
o.clipboard:append("unnamedplus")

-- syntax highlight
vim.cmd([[syntax on]])
