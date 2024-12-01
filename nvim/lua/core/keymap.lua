-- swap : and ;
vim.cmd([[
    noremap : ;
    noremap ; :
]])

local k = vim.keymap

vim.g.mapleader = ','

-- clear search
k.set('n', '<leader>h', '<cmd>nohl<CR>', { noremap = true, silent = true })

-- create split
k.set('n', '<leader>sh', '<C-w>v', { noremap = true, silent = true })
k.set('n', '<leader>sv', '<C-w>s', { noremap = true, silent = true })
--
-- control split focus
k.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
k.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
k.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
k.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- nvim-tree
k.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- telescope
vim.g.telescope_key = ' '
k.set('n', vim.g.telescope_key .. 'f', ':Telescope find_files<CR>', { noremap = true, silent = true })
k.set('n', vim.g.telescope_key .. 'g', ':Telescope live_grep<CR>', { noremap = true, silent = true })
k.set('n', vim.g.telescope_key .. 'b', ':Telescope buffers<CR>', { noremap = true, silent = true })
k.set('n', vim.g.telescope_key .. 'h', ':Telescope help_tags<CR>', { noremap = true, silent = true })
